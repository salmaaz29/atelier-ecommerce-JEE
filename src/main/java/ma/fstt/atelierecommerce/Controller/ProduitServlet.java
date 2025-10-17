package ma.fstt.atelierecommerce.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.fstt.atelierecommerce.Model.LignePanier;
import ma.fstt.atelierecommerce.Model.Panier;
import ma.fstt.atelierecommerce.Model.Produit;
import ma.fstt.atelierecommerce.Model.User;
import ma.fstt.atelierecommerce.util.JPAUtil;

import jakarta.persistence.EntityManager;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProduitServlet", value = "/produit")
public class ProduitServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        EntityManager em = JPAUtil.createEntityManager();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try {
            if (action != null && user != null) {
                System.out.println("Produit action: " + action);
                switch (action) {
                    case "list":
                        List<Produit> produits = em.createQuery("SELECT p FROM Produit p", Produit.class).getResultList();
                        request.setAttribute("produits", produits);
                        request.getRequestDispatcher("/WEB-INF/views/produits.jsp").forward(request, response);
                        return;
                    default:
                        System.out.println("Unknown produit action: " + action);
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
                    case "addToCart":
                        Long produitId = Long.parseLong(request.getParameter("produitId"));
                        int quantite = Integer.parseInt(request.getParameter("quantite") != null ? request.getParameter("quantite") : "1");

                        Produit produit = em.find(Produit.class, produitId);
                        if (produit != null && produit.getStock() >= quantite) {
                            Panier panier = user.getPanier();
                            if (panier == null) {
                                em.getTransaction().begin();
                                panier = new Panier(new java.util.Date(), 0.0, user);
                                user.setPanier(panier);
                                em.persist(panier);
                                em.getTransaction().commit();
                            }

                            em.getTransaction().begin();
                            try {
                                // Vérifier et gérer la ligne existante
                                LignePanier ligneExistante = em.createQuery(
                                                "SELECT l FROM LignePanier l WHERE l.panier = :panier AND l.produit = :produit", LignePanier.class)
                                        .setParameter("panier", panier)
                                        .setParameter("produit", produit)
                                        .getResultList().stream().findFirst().orElse(null);

                                if (ligneExistante != null) {
                                    ligneExistante.setQuantite(ligneExistante.getQuantite() + quantite);
                                    em.merge(ligneExistante);
                                } else {
                                    LignePanier ligne = new LignePanier(quantite, panier, produit);
                                    em.persist(ligne); // Assure la persistance
                                    panier.getLignes().add(ligne); // Mettre à jour la liste côté objet
                                }

                                // Mettre à jour le stock
                                produit.setStock(produit.getStock() - quantite);
                                em.merge(produit);

                                // Recalculer le total
                                Double newTotal = em.createQuery(
                                                "SELECT SUM(l.quantite * p.prix_produit) FROM LignePanier l JOIN l.produit p WHERE l.panier = :panier", Double.class)
                                        .setParameter("panier", panier)
                                        .getSingleResult();
                                panier.setTotal(newTotal != null ? newTotal : 0.0);
                                em.merge(panier);

                                em.getTransaction().commit();
                                request.setAttribute("message", "Produit ajouté au panier !");
                            } catch (Exception e) {
                                em.getTransaction().rollback();
                                request.setAttribute("error", "Erreur lors de l'ajout au panier : " + e.getMessage());
                                e.printStackTrace(); // Ajouter pour débogage
                            }
                        } else {
                            request.setAttribute("error", "Stock insuffisant ou produit inexistant");
                        }
                        List<Produit> produits = em.createQuery("SELECT p FROM Produit p", Produit.class).getResultList();
                        request.setAttribute("produits", produits);
                        request.getRequestDispatcher("/WEB-INF/views/produits.jsp").forward(request, response);
                        return;
                    default:
                        System.out.println("Unknown produit action: " + action);
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
}