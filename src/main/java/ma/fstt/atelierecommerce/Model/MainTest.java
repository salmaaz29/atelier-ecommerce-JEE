package ma.fstt.atelierecommerce.Model;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class MainTest {
    private static EntityManagerFactory emf;

    public static void main(String[] args) {
        // Initialisation de l'EntityManagerFactory avec l'unité de persistance "ecommercePU"
        emf = Persistence.createEntityManagerFactory("ecommercePU");

        // Créer un EntityManager
        EntityManager em = emf.createEntityManager();

        // Démarrer une transaction (nécessaire même pour vérifier la création)
        em.getTransaction().begin();

        try {
            // Pas besoin d'insérer de données pour tester la création des tables
            // La propriété eclipselink.ddl-generation créera les tables automatiquement
            System.out.println("Les tables devraient être créées ou étendues dans la base 'ecommerce_db'...");
        } catch (Exception e) {
            // Annuler la transaction en cas d'erreur
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            // Valider la transaction (pour appliquer la génération DDL)
            if (em.getTransaction().isActive()) {
                em.getTransaction().commit();
            }
            // Fermer l'EntityManager
            em.close();
        }

        // Fermer l'EntityManagerFactory
        if (emf != null && emf.isOpen()) {
            emf.close();
            System.out.println("Connexion fermée. Vérifie la base de données !");
        }
    }




}
