package ma.fstt.atelierecommerce.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.fstt.atelierecommerce.Model.Produit;
import ma.fstt.atelierecommerce.utils.JPAUtil;

import jakarta.persistence.EntityManager;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProduitAdminServlet", value = "/admin/produit/*")
public class ProduitAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo(); // Pour CRUD (admin)
        EntityManager em = JPAUtil.createEntityManager();

        try {
            if (pathInfo != null && !pathInfo.equals("/")) {
                System.out.println("Admin pathInfo: " + pathInfo);
                switch (pathInfo) {
                    case "/list":
                        List<Produit> allProduits = em.createQuery("SELECT p FROM Produit p", Produit.class).getResultList();
                        request.setAttribute("produits", allProduits);
                        request.getRequestDispatcher("/WEB-INF/views/admin_produits.jsp").forward(request, response);
                        break;
                    case "/add-product":
                        request.getRequestDispatcher("/WEB-INF/views/addProduit.jsp").forward(request, response);
                        break;
                    default:
                        if (pathInfo.matches("/edit/\\d+")) {
                            Long id = Long.parseLong(pathInfo.substring(6));
                            Produit produit = em.find(Produit.class, id);
                            if (produit == null) {
                                request.setAttribute("error", "Erreur : ce produit n'existe pas dans la base de données");
                                request.getRequestDispatcher("/WEB-INF/views/produits.jsp").forward(request, response);
                                return;
                            }
                            request.setAttribute("produit", produit);
                            request.getRequestDispatcher("/WEB-INF/views/editProduit.jsp").forward(request, response);
                        } else if (pathInfo.matches("/delete/\\d+")) {
                            Long id = Long.parseLong(pathInfo.substring(8));
                            Produit produit = em.find(Produit.class, id);
                            if (produit != null) {
                                em.getTransaction().begin();
                                try {
                                    em.remove(produit);
                                    em.getTransaction().commit();
                                    response.sendRedirect(request.getContextPath() + "/admin/produit/list");
                                } catch (Exception e) {
                                    em.getTransaction().rollback();
                                    request.setAttribute("error", "Erreur lors de la suppression : " + e.getMessage());
                                    request.getRequestDispatcher("/WEB-INF/views/produits.jsp").forward(request, response);
                                }
                            } else {
                                request.setAttribute("error", "Produit non trouvé");
                                request.getRequestDispatcher("/WEB-INF/views/produits.jsp").forward(request, response);
                            }
                        } else {
                            request.setAttribute("error", "Chemin invalide");
                            request.getRequestDispatcher("/WEB-INF/views/produits.jsp").forward(request, response);
                        }
                        break;
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/produit/list");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur serveur : " + e.getMessage());
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        EntityManager em = JPAUtil.createEntityManager();

        try {
            if (pathInfo != null) {
                switch (pathInfo) {
                    case "/add-product":
                        Produit newProduit = new Produit(
                                request.getParameter("nom_produit"),
                                Long.parseLong(request.getParameter("stock")),
                                request.getParameter("description_produit"),
                                request.getParameter("image_produit"),
                                Double.parseDouble(request.getParameter("prix_produit"))
                        );
                        em.getTransaction().begin();
                        try {
                            em.persist(newProduit);
                            em.getTransaction().commit();
                            response.sendRedirect(request.getContextPath() + "/admin/produit/list");
                        } catch (Exception e) {
                            em.getTransaction().rollback();
                            request.setAttribute("error", "Erreur lors de l'ajout : " + e.getMessage());
                            request.getRequestDispatcher("/WEB-INF/views/addProduit.jsp").forward(request, response);
                        }
                        break;
                    case "/edit":
                        Long id = Long.parseLong(request.getParameter("id"));
                        Produit produit = em.find(Produit.class, id);
                        if (produit != null) {
                            em.getTransaction().begin();
                            try {
                                produit.setNom_produit(request.getParameter("nom_produit"));
                                produit.setStock(Long.parseLong(request.getParameter("stock")));
                                produit.setDescription_produit(request.getParameter("description_produit"));
                                produit.setImage_produit(request.getParameter("image_produit"));
                                produit.setPrix_produit(Double.parseDouble(request.getParameter("prix_produit")));
                                em.getTransaction().commit();
                                response.sendRedirect(request.getContextPath() + "/admin/produit/list");
                            } catch (Exception e) {
                                em.getTransaction().rollback();
                                request.setAttribute("error", "Erreur lors de la modification : " + e.getMessage());
                                request.setAttribute("produit", produit);
                                request.getRequestDispatcher("/WEB-INF/views/editProduit.jsp").forward(request, response);
                            }
                        } else {
                            response.sendError(HttpServletResponse.SC_NOT_FOUND);
                        }
                        break;
                    default:
                        request.setAttribute("error", "Chemin POST invalide");
                        request.getRequestDispatcher("/WEB-INF/views/produits.jsp").forward(request, response);
                        break;
                }
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID ou données invalides : " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur serveur : " + e.getMessage());
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }
}