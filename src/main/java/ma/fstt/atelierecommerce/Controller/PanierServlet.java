package ma.fstt.atelierecommerce.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.fstt.atelierecommerce.Model.Commande;
import ma.fstt.atelierecommerce.Model.LigneCommande;
import ma.fstt.atelierecommerce.Model.LignePanier;
import ma.fstt.atelierecommerce.Model.Panier;
import ma.fstt.atelierecommerce.Model.Produit;
import ma.fstt.atelierecommerce.Model.User;
import ma.fstt.atelierecommerce.utils.JPAUtil;

import jakarta.persistence.EntityManager;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet(name = "PanierServlet", value = "/panier")
public class PanierServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        EntityManager em = JPAUtil.createEntityManager();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try {
            if (action != null && user != null) {
                System.out.println("Panier action: " + action);
                Panier panier = user.getPanier();
                switch (action) {
                    case "view":
                        if (panier != null) {
                            List<LignePanier> lignes = em.createQuery(
                                            "SELECT l FROM LignePanier l WHERE l.panier = :panier", LignePanier.class)
                                    .setParameter("panier", panier)
                                    .getResultList();
                            request.setAttribute("lignes", lignes);
                            Double total = em.createQuery(
                                            "SELECT COALESCE(SUM(l.quantite * p.prix_produit), 0) FROM LignePanier l JOIN l.produit p WHERE l.panier = :panier", Double.class)
                                    .setParameter("panier", panier)
                                    .getSingleResult();
                            request.setAttribute("total", total);
                        } else {
                            request.setAttribute("lignes", new java.util.ArrayList<>());
                            request.setAttribute("total", 0.0);
                        }
                        request.getRequestDispatcher("/WEB-INF/views/panier.jsp").forward(request, response);
                        return;
                    case "removeLine":
                        try {
                            Long ligneId = Long.parseLong(request.getParameter("ligneId"));
                            System.out.println("Tentative de suppression de ligne avec ID: " + ligneId);
                            LignePanier ligne = em.find(LignePanier.class, ligneId);

                            if (ligne == null) {
                                request.setAttribute("error", "Ligne avec ID " + ligneId + " non trouvée.");
                            } else if (panier == null) {
                                request.setAttribute("error", "Panier de l'utilisateur introuvable.");
                            } else {
                                User ligneUser = ligne.getPanier().getUser();
                                System.out.println("Utilisateur connecté (ID/Email): " + (user != null ? user.getId_user() + "/" + user.getEmail() : "null") +
                                        ", Utilisateur de la ligne (ID/Email): " + (ligneUser != null ? ligneUser.getId_user() + "/" + ligneUser.getEmail() : "null"));

                                if (ligne.getPanier() == null || ligneUser == null) {
                                    request.setAttribute("error", "Relation panier ou utilisateur invalide pour la ligne.");
                                } else if (!ligneUser.getEmail().equals(user.getEmail())) {
                                    request.setAttribute("error", "L'utilisateur connecté (" + user.getEmail() +
                                            ") ne correspond pas au propriétaire de la ligne (" + ligneUser.getEmail() + ").");
                                } else {
                                    em.getTransaction().begin();
                                    try {
                                        // mettre a jour le stock du produit
                                        Produit produit = ligne.getProduit();
                                        if (produit != null) {
                                            produit.setStock(produit.getStock() + ligne.getQuantite());
                                            em.merge(produit);
                                        }

                                        // Supprimer la ligne
                                        em.remove(ligne);
                                        em.flush(); // Forcer la synchronisation

                                        System.out.println("Ligne supprimée avec ID: " + ligneId);

                                        // Mettre à jour le total du panier (panier est déjà managé)
                                        Double newTotal = em.createQuery(
                                                        "SELECT COALESCE(SUM(l.quantite * p.prix_produit), 0) FROM LignePanier l JOIN l.produit p WHERE l.panier = :panier", Double.class)
                                                .setParameter("panier", panier)
                                                .getSingleResult();
                                        panier.setTotal(newTotal);


                                        em.getTransaction().commit();
                                        request.setAttribute("message", "Ligne supprimée du panier !");
                                    } catch (Exception e) {
                                        em.getTransaction().rollback();
                                        request.setAttribute("error", "Erreur lors de la suppression : " + e.getMessage());
                                        e.printStackTrace();
                                    }
                                }
                            }
                        } catch (NumberFormatException e) {
                            request.setAttribute("error", "ID de ligne invalide : " + e.getMessage());
                            e.printStackTrace();
                        }
                }
            }
            response.sendRedirect(request.getContextPath() + "/produit?action=list");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur serveur : " + e.getMessage());
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        EntityManager em = JPAUtil.createEntityManager();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try {
            if (action != null && user != null) {
                switch (action) {
                    case "validate":
                        Panier panier = user.getPanier();
                        if (panier != null) {
                            em.getTransaction().begin();
                            try {
                                // recuperer les lignes avant de creer la commande
                                List<LignePanier> lignes = em.createQuery(
                                                "SELECT l FROM LignePanier l WHERE l.panier = :panier", LignePanier.class)
                                        .setParameter("panier", panier)
                                        .getResultList();

                                // verifier si le penier n est pas vide
                                if (lignes.isEmpty()) {
                                    request.setAttribute("error", "Le panier est vide !");
                                    request.getRequestDispatcher("/WEB-INF/views/panier.jsp").forward(request, response);
                                    return;
                                }

                                // creation de la commande
                                Commande commande = new Commande(new Date(), 0.0, user,"en attente");
                                em.persist(commande);

                                double totalCommande = 0.0;
                                for (LignePanier ligne : lignes) {
                                    // Vérifier le stock disponible
                                    Produit produit = ligne.getProduit();
                                    if (produit.getStock() < ligne.getQuantite()) {
                                        em.getTransaction().rollback();
                                        request.setAttribute("error", "Stock insuffisant pour le produit : " + produit.getNom_produit());
                                        request.getRequestDispatcher("/WEB-INF/views/panier.jsp").forward(request, response);
                                        return;
                                    }

                                    // creation de ligne de commande
                                    LigneCommande ligneCommande = new LigneCommande(ligne.getQuantite(), commande, produit);
                                    em.persist(ligneCommande);
                                    commande.getLignes().add(ligneCommande);

                                    // decrementer le stock
                                    produit.setStock(produit.getStock() - ligne.getQuantite());
                                    em.merge(produit);

                                    totalCommande += ligne.getQuantite() * produit.getPrix_produit();
                                }

                                // mettre a jour le total de la commande
                                commande.setTotal(totalCommande);
                                em.merge(commande);

                                // vider le panier
                                em.createQuery("DELETE FROM LignePanier l WHERE l.panier = :panier")
                                        .setParameter("panier", panier)
                                        .executeUpdate();

                                panier.setTotal(0.0);

                                em.getTransaction().commit();
                                request.setAttribute("message", "Commande validée avec succès ! Total : " + totalCommande + " DH");
                            } catch (Exception e) {
                                em.getTransaction().rollback();
                                request.setAttribute("error", "Erreur lors de la validation : " + e.getMessage());
                                e.printStackTrace();
                            }
                        } else {
                            request.setAttribute("error", "Panier vide ou invalide");
                        }
                        request.getRequestDispatcher("/WEB-INF/views/panier.jsp").forward(request, response);
                        return;
                }
            }
            response.sendRedirect(request.getContextPath() + "/panier?action=view");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur serveur : " + e.getMessage());
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }
}