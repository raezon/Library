/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import controller.exceptions.NonexistentEntityException;
import controller.exceptions.RollbackFailureException;
import java.io.Serializable;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.UserTransaction;
import model.Author;
import model.Livre;

/**
 *
 * @author HP
 */
public class LivreJpaController implements Serializable {

    public LivreJpaController(UserTransaction utx, EntityManagerFactory emf) {
        this.utx = utx;
        this.emf = emf;
    }
    private UserTransaction utx = null;
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Livre livre) throws RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Author numAuteur = livre.getNumAuteur();
            if (numAuteur != null) {
                numAuteur = em.getReference(numAuteur.getClass(), numAuteur.getNum());
                livre.setNumAuteur(numAuteur);
            }
            em.persist(livre);
            if (numAuteur != null) {
                numAuteur.getLivreCollection().add(livre);
                numAuteur = em.merge(numAuteur);
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

    public void edit(Livre livre) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Livre persistentLivre = em.find(Livre.class, livre.getIssn());
            Author numAuteurOld = persistentLivre.getNumAuteur();
            Author numAuteurNew = livre.getNumAuteur();
            if (numAuteurNew != null) {
                numAuteurNew = em.getReference(numAuteurNew.getClass(), numAuteurNew.getNum());
                livre.setNumAuteur(numAuteurNew);
            }
            livre = em.merge(livre);
            if (numAuteurOld != null && !numAuteurOld.equals(numAuteurNew)) {
                numAuteurOld.getLivreCollection().remove(livre);
                numAuteurOld = em.merge(numAuteurOld);
            }
            if (numAuteurNew != null && !numAuteurNew.equals(numAuteurOld)) {
                numAuteurNew.getLivreCollection().add(livre);
                numAuteurNew = em.merge(numAuteurNew);
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
                Integer id = livre.getIssn();
                if (findLivre(id) == null) {
                    throw new NonexistentEntityException("The livre with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException, RollbackFailureException, Exception {
        EntityManager em = null;
        try {
            utx.begin();
            em = getEntityManager();
            Livre livre;
            try {
                livre = em.getReference(Livre.class, id);
                livre.getIssn();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The livre with id " + id + " no longer exists.", enfe);
            }
            Author numAuteur = livre.getNumAuteur();
            if (numAuteur != null) {
                numAuteur.getLivreCollection().remove(livre);
                numAuteur = em.merge(numAuteur);
            }
            em.remove(livre);
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

    public List<Livre> findLivreEntities() {
        return findLivreEntities(true, -1, -1);
    }

    public List<Livre> findLivreEntities(int maxResults, int firstResult) {
        return findLivreEntities(false, maxResults, firstResult);
    }

    private List<Livre> findLivreEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Livre.class));
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

    public Livre findLivre(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Livre.class, id);
        } finally {
            em.close();
        }
    }

    public int getLivreCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Livre> rt = cq.from(Livre.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
