package ma.fstt.atelierecommerce.Model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Entity
@Table(name = "commande")
@Getter
@Setter
@NoArgsConstructor
public class Commande {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_commande;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dateCommande;

    @Column
    private double total; // Total de la commande, calculé à partir des lignes

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @OneToMany(mappedBy = "commande", cascade = CascadeType.ALL)
    private List<LigneCommande> lignes;

    public Commande(Date dateCommande, double total, User user) {
        this.dateCommande = dateCommande;
        this.total = total;
        this.user = user;
    }
}