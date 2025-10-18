package ma.fstt.atelierecommerce.Controller;


import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.fstt.atelierecommerce.Model.Commande;
import ma.fstt.atelierecommerce.utils.JPAUtil;

import java.io.IOException;
import java.util.List;

@WebServlet(name="CommandeAdminServlet" , value = "/admin/commande/*")
public class CommandeAdminServlet  extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo(); // Pour CRUD (admin)
        EntityManager em = JPAUtil.createEntityManager();
        try {
            if (pathInfo != null && !pathInfo.equals("/")) {
                System.out.println("Admin pathInfo: " + pathInfo);
                switch (pathInfo) {
                    case "/list":
                        List<Commande> allCommandes = em.createQuery("SELECT c FROM Commande c", Commande.class).getResultList();
                        request.setAttribute("commandes", allCommandes);
                        request.getRequestDispatcher("/WEB-INF/views/admin_commandes.jsp").forward(request, response);
                        break;
                    default:
                        if (pathInfo.matches("/edit/\\d+")) {
                            Long id = Long.parseLong(pathInfo.substring(6));
                            Commande commande = em.find(Commande.class, id);
                            if (commande == null) {
                                request.setAttribute("error", "Erreur : cette commqande n'existe pas dans la base de données");
                                request.getRequestDispatcher("/WEB-INF/views/admin_commandes.jsp").forward(request, response);
                                return;
                            }
                            request.setAttribute("commande", commande);
                            request.getRequestDispatcher("/WEB-INF/views/editcommande.jsp").forward(request, response);
                        }
                        break;
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/commande/list");
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
                    case "/edit":
                        Long id = Long.parseLong(request.getParameter("id"));
                        Commande commande = em.find(Commande.class, id);
                        if (commande != null) {
                            em.getTransaction().begin();
                            try {
                                // recuperer le nouveau statut depuis le form
                                String nouveauStatut = request.getParameter("statut");
                                if (nouveauStatut != null && !nouveauStatut.trim().isEmpty()) {
                                    commande.setStatut(nouveauStatut); // modifier le statut
                                    em.getTransaction().commit();
                                    response.sendRedirect(request.getContextPath() + "/admin/commande/list");
                                } else {
                                    em.getTransaction().rollback();
                                    request.setAttribute("error", "Le statut ne peut pas être vide.");
                                    request.setAttribute("commande", commande);
                                    request.getRequestDispatcher("/WEB-INF/views/editcommande.jsp").forward(request, response);
                                }
                            } catch (Exception e) {
                                em.getTransaction().rollback();
                                request.setAttribute("error", "Erreur lors de la modification : " + e.getMessage());
                                request.setAttribute("commande", commande);
                                request.getRequestDispatcher("/WEB-INF/views/editcommande.jsp").forward(request, response);
                            }
                        } else {
                            response.sendError(HttpServletResponse.SC_NOT_FOUND);
                        }
                        break;
                    default:
                        request.setAttribute("error", "Chemin POST invalide");
                        request.getRequestDispatcher("/WEB-INF/views/admin_commandes.jsp").forward(request, response);
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