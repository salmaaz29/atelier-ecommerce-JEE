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
import ma.fstt.atelierecommerce.util.JPAUtil;

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
                switch (action) {
                    case "view":
                        Panier panier = user.getPanier();
                        if (panier != null) {
                            List<LignePanier> lignes = em.createQuery(
                                            "SELECT l FROM LignePanier l WHERE l.panier = :panier", LignePanier.class)
                                    .setParameter("panier", panier)
                                    .getResultList();
                            request.setAttribute("lignes", lignes);
                            Double total = em.createQuery(
                                            "SELECT SUM(l.quantite * p.prix_produit) FROM LignePanier l JOIN l.produit p WHERE l.panier = :panier", Double.class)
                                    .setParameter("panier", panier)
                                    .getSingleResult();
                            request.setAttribute("total", total != null ? total : 0.0);
                        } else {
                            request.setAttribute("lignes", new java.util.ArrayList<>());
                            request.setAttribute("total", 0.0);
                        }
                        request.getRequestDispatcher("/WEB-INF/views/panier.jsp").forward(request, response);
                        return;
                    case "removeLine":
                        Long ligneId = Long.parseLong(request.getParameter("ligneId"));
                        LignePanier ligne = em.find(LignePanier.class, ligneId);
                        if (ligne != null && ligne.getPanier().getUser().equals(user)) {
                            em.getTransaction().begin();
                            try {
                                Produit produit = ligne.getProduit();
                                produit.setStock(produit.getStock() + ligne.getQuantite());
                                em.merge(produit);
                                em.remove(ligne);
                                Panier panierrem = user.getPanier();
                                Double newTotal = em.createQuery(
                                                "SELECT SUM(l.quantite * p.prix_produit) FROM LignePanier l JOIN l.produit p WHERE l.panier = :panier", Double.class)
                                        .setParameter("panier", panierrem)
                                        .getSingleResult();
                                panierrem.setTotal(newTotal != null ? newTotal : 0.0);
                                em.merge(panierrem);
                                em.getTransaction().commit();
                                request.setAttribute("message", "Ligne supprimée du panier !");
                            } catch (Exception e) {
                                em.getTransaction().rollback();
                                request.setAttribute("error", "Erreur lors de la suppression : " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        List<LignePanier> lignes = em.createQuery(
                                        "SELECT l FROM LignePanier l WHERE l.panier = :panier", LignePanier.class)
                                .setParameter("panier", user.getPanier())
                                .getResultList();
                        request.setAttribute("lignes", lignes);
                        Double total = em.createQuery(
                                        "SELECT SUM(l.quantite * p.prix_produit) FROM LignePanier l JOIN l.produit p WHERE l.panier = :panier", Double.class)
                                .setParameter("panier", user.getPanier())
                                .getSingleResult();
                        request.setAttribute("total", total != null ? total : 0.0);
                        request.getRequestDispatcher("/WEB-INF/views/panier.jsp").forward(request, response);
                        return;
                    default:
                        System.out.println("Unknown panier action: " + action);
                        break;
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
                                Commande commande = new Commande(new Date(), 0.0, user);
                                em.persist(commande);

                                List<LignePanier> lignes = em.createQuery(
                                                "SELECT l FROM LignePanier l WHERE l.panier = :panier", LignePanier.class)
                                        .setParameter("panier", panier)
                                        .getResultList();
                                double totalCommande = 0.0;
                                for (LignePanier ligne : lignes) {
                                    LigneCommande ligneCommande = new LigneCommande(ligne.getQuantite(), commande, ligne.getProduit());
                                    em.persist(ligneCommande);
                                    commande.getLignes().add(ligneCommande);

                                    Produit produit = ligne.getProduit();
                                    produit.setStock(produit.getStock() - ligne.getQuantite());
                                    em.merge(produit);

                                    totalCommande += ligne.getQuantite() * produit.getPrix_produit();
                                }
                                commande.setTotal(totalCommande);
                                em.merge(commande);

                                // Supprimer uniquement les LignePanier
                                em.createQuery("DELETE FROM LignePanier l WHERE l.panier = :panier")
                                        .setParameter("panier", panier)
                                        .executeUpdate();
                                // Ne pas réinitialiser le total à 0 si tu veux le conserver
                                // panier.setTotal(0.0);
                                // em.merge(panier);

                                em.getTransaction().commit();
                                request.setAttribute("message", "Commande validée avec succès !");
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
                    default:
                        System.out.println("Unknown panier action: " + action);
                        break;
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