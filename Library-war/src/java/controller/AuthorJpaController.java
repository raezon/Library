/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import controller.exceptions.IllegalOrphanException;
import controller.exceptions.NonexistentEntityException;
import controller.exceptions.RollbackFailureException;
import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import model.Livre;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.transaction.UserTransaction;
import model.Author;

/**
 *
 * @author HP
 */
public class AuthorJpaController implements Serializable {

    public AuthorJpaController(UserTransaction utx, EntityManagerFactory emf) {
        this.utx = utx;
        this.emf = emf;
    }
    private UserTransaction utx = null;
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Author author) throws RollbackFailureException, Exception {
        if (author.getLivreCollection() == null) {
            author.setLivreCollection(new ArrayList<Livre>());
        }
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Collection<Livre> attachedLivreCollection = new ArrayList<Livre>();
            for (Livre livreCollectionLivreToAttach : author.getLivreCollection()) {
                livreCollectionLivreToAttach = em.getReference(livreCollectionLivreToAttach.getClass(), livreCollectionLivreToAttach.getIssn());
                attachedLivreCollection.add(livreCollectionLivreToAttach);
            }
            author.setLivreCollection(attachedLivreCollection);
            em.persist(author);
            for (Livre livreCollectionLivre : author.getLivreCollection()) {
                Author oldNumAuteurOfLivreCollectionLivre = livreCollectionLivre.getNumAuteur();
                livreCollectionLivre.setNumAuteur(author);
                livreCollectionLivre = em.merge(livreCollectionLivre);
                if (oldNumAuteurOfLivreCollectionLivre != null) {
                    oldNumAuteurOfLivreCollectionLivre.getLivreCollection().remove(livreCollectionLivre);
                    oldNumAuteurOfLivreCollectionLivre = em.merge(oldNumAuteurOfLivreCollectionLivre);
                }
            }
            utx.commit();
        } catch (Exception ex) {
            try {
                utx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Author author) throws IllegalOrphanException, NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Author persistentAuthor = em.find(Author.class, author.getNum());
            Collection<Livre> livreCollectionOld = persistentAuthor.getLivreCollection();
            Collection<Livre> livreCollectionNew = author.getLivreCollection();
            List<String> illegalOrphanMessages = null;
            for (Livre livreCollectionOldLivre : livreCollectionOld) {
                if (!livreCollectionNew.contains(livreCollectionOldLivre)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Livre " + livreCollectionOldLivre + " since its numAuteur field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Collection<Livre> attachedLivreCollectionNew = new ArrayList<Livre>();
            for (Livre livreCollectionNewLivreToAttach : livreCollectionNew) {
                livreCollectionNewLivreToAttach = em.getReference(livreCollectionNewLivreToAttach.getClass(), livreCollectionNewLivreToAttach.getIssn());
                attachedLivreCollectionNew.add(livreCollectionNewLivreToAttach);
            }
            livreCollectionNew = attachedLivreCollectionNew;
            author.setLivreCollection(livreCollectionNew);
            author = em.merge(author);
            for (Livre livreCollectionNewLivre : livreCollectionNew) {
                if (!livreCollectionOld.contains(livreCollectionNewLivre)) {
                    Author oldNumAuteurOfLivreCollectionNewLivre = livreCollectionNewLivre.getNumAuteur();
                    livreCollectionNewLivre.setNumAuteur(author);
                    livreCollectionNewLivre = em.merge(livreCollectionNewLivre);
                    if (oldNumAuteurOfLivreCollectionNewLivre != null && !oldNumAuteurOfLivreCollectionNewLivre.equals(author)) {
                        oldNumAuteurOfLivreCollectionNewLivre.getLivreCollection().remove(livreCollectionNewLivre);
                        oldNumAuteurOfLivreCollectionNewLivre = em.merge(oldNumAuteurOfLivreCollectionNewLivre);
                    }
                }
            }
            utx.commit();
        } catch (Exception ex) {
            try {
                utx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = author.getNum();
                if (findAuthor(id) == null) {
                    throw new NonexistentEntityException("The author with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws IllegalOrphanException, NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Author author;
            try {
                author = em.getReference(Author.class, id);
                author.getNum();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The author with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            Collection<Livre> livreCollectionOrphanCheck = author.getLivreCollection();
            for (Livre livreCollectionOrphanCheckLivre : livreCollectionOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Author (" + author + ") cannot be destroyed since the Livre " + livreCollectionOrphanCheckLivre + " in its livreCollection field has a non-nullable numAuteur field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(author);
            utx.commit();
        } catch (Exception ex) {
            try {
                utx.rollback();
            } catch (Exception re) {
                throw new RollbackFailureException("An error occurred attempting to roll back the transaction.", re);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Author> findAuthorEntities() {
        return findAuthorEntities(true, -1, -1);
    }

    public List<Author> findAuthorEntities(int maxResults, int firstResult) {
        return findAuthorEntities(false, maxResults, firstResult);
    }

    private List<Author> findAuthorEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Author.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Author findAuthor(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Author.class, id);
        } finally {
            em.close();
        }
    }

    public int getAuthorCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Author> rt = cq.from(Author.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
