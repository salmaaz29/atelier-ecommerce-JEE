package ma.fstt.atelierecommerce.Model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "produit")
@Getter
@Setter
@NoArgsConstructor
public class Produit {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_produit;
    @Column
    private String nom_produit;
    @Column
    private Long stock;
    @Column
    private String description_produit;
    @Column
    private String image_produit;
    @Column
    private Double prix_produit;

    @OneToMany(mappedBy = "produit", cascade = CascadeType.ALL)
    private List<LignePanier> lignes;

    @OneToMany(mappedBy = "produit", cascade = CascadeType.ALL)
    private List<LigneCommande> ligneCommandes;

    public Produit(String nom_produit, Long stock, String description_produit, String image_produit, Double prix_produit) {
        this.nom_produit = nom_produit;
        this.stock = stock;
        this.description_produit = description_produit;
        this.image_produit = image_produit;
        this.prix_produit = prix_produit;
    }
}