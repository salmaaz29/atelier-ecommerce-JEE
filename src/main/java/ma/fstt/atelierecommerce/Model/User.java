package ma.fstt.atelierecommerce.Model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Table(name = "user")
@Getter
@Setter
@NoArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_user;
    @Column
    private String nom;
    @Column
    private String email;
    @Column
    private String motdepasse;
    @Column
    private String adresse;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    private Panier panier;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
    private List<Commande> commandes;

    public User(String nom, String email, String motdepasse, String adresse) {
        this.nom = nom;
        this.email = email;
        this.motdepasse = motdepasse; // Correction : 'motdepsse' → 'motdepasse'
        this.adresse = adresse;
    }
}