/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author HP
 */
@Entity
@Table(name = "livre")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Livre.findAll", query = "SELECT l FROM Livre l"),
    @NamedQuery(name = "Livre.findByIssn", query = "SELECT l FROM Livre l WHERE l.issn = :issn"),
    @NamedQuery(name = "Livre.findByTitre", query = "SELECT l FROM Livre l WHERE l.titre = :titre"),
    @NamedQuery(name = "Livre.findByNbrpage", query = "SELECT l FROM Livre l WHERE l.nbrpage = :nbrpage"),
    @NamedQuery(name = "Livre.findByDomaine", query = "SELECT l FROM Livre l WHERE l.domaine = :domaine"),
    @NamedQuery(name = "Livre.findByImage", query = "SELECT l FROM Livre l WHERE l.image = :image")})
public class Livre implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "issn")
    private Integer issn;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "titre")
    private String titre;
    @Basic(optional = false)
    @NotNull
    @Column(name = "nbrpage")
    private int nbrpage;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "domaine")
    private String domaine;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 120)
    @Column(name = "image")
    private String image;
    @Basic(optional = false)
    @NotNull
    @Lob
    @Size(min = 1, max = 2147483647)
    @Column(name = "resume")
    private String resume;
    @JoinColumn(name = "num_auteur", referencedColumnName = "num")
    @ManyToOne(optional = false)
    private Author numAuteur;

    public Livre() {
    }

    public Livre(Integer issn) {
        this.issn = issn;
    }

    public Livre(Integer issn, String titre, int nbrpage, String domaine, String image, String resume) {
        this.issn = issn;
        this.titre = titre;
        this.nbrpage = nbrpage;
        this.domaine = domaine;
        this.image = image;
        this.resume = resume;
    }

    public Integer getIssn() {
        return issn;
    }

    public void setIssn(Integer issn) {
        this.issn = issn;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public int getNbrpage() {
        return nbrpage;
    }

    public void setNbrpage(int nbrpage) {
        this.nbrpage = nbrpage;
    }

    public String getDomaine() {
        return domaine;
    }

    public void setDomaine(String domaine) {
        this.domaine = domaine;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getResume() {
        return resume;
    }

    public void setResume(String resume) {
        this.resume = resume;
    }

    public Author getNumAuteur() {
        return numAuteur;
    }

    public void setNumAuteur(Author numAuteur) {
        this.numAuteur = numAuteur;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (issn != null ? issn.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Livre)) {
            return false;
        }
        Livre other = (Livre) object;
        if ((this.issn == null && other.issn != null) || (this.issn != null && !this.issn.equals(other.issn))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "model.Livre[ issn=" + issn + " ]";
    }
    
}
