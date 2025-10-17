package ma.fstt.atelierecommerce.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JPAUtil {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("ecommercePU");

    public static EntityManager createEntityManager() {
        return emf.createEntityManager();
    }

    // Optionnel : Fermer l'EntityManagerFactory à la fin de l'application
    public static void closeEntityManagerFactory() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}