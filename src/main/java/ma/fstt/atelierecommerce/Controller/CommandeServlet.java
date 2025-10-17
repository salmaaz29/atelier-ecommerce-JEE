package ma.fstt.atelierecommerce.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.fstt.atelierecommerce.Model.Commande;
import ma.fstt.atelierecommerce.Model.User;
import ma.fstt.atelierecommerce.util.JPAUtil;

import jakarta.persistence.EntityManager;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CommandeServlet", value = "/commande")
public class CommandeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        EntityManager em = JPAUtil.createEntityManager();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        try {
            if (action != null && user != null) {
                System.out.println("Commande action: " + action);
                switch (action) {
                    case "list":
                        List<Commande> commandes = em.createQuery(
                                        "SELECT c FROM Commande c WHERE c.user = :user", Commande.class)
                                .setParameter("user", user)
                                .getResultList();
                        request.setAttribute("commandes", commandes);
                        request.getRequestDispatcher("/WEB-INF/views/commandes.jsp").forward(request, response);
                        return;
                    default:
                        System.out.println("Unknown commande action: " + action);
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
        response.sendRedirect(request.getContextPath() + "/commande?action=list");
    }
}