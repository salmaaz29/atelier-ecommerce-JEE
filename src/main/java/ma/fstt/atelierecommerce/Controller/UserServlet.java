package ma.fstt.atelierecommerce.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.fstt.atelierecommerce.Model.User;
import ma.fstt.atelierecommerce.util.JPAUtil; // Crée cette classe ci-dessous

import jakarta.persistence.EntityManager;
import java.io.IOException;

@WebServlet(name = "UserServlet", value = "/user")
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "login";

        switch (action) {
            case "login":
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                break;
            case "register":
                request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                break;
            case "logout":
                request.getSession().invalidate();
                response.sendRedirect("user?action=login");
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        EntityManager em = JPAUtil.createEntityManager(); // Initialisation manuelle


            switch (action) {
                case "login":
                    String email = request.getParameter("email");
                    String motdepasse = request.getParameter("motdepasse");
                    em.getTransaction().begin();
                    try {
                    User user = em.createQuery("SELECT u FROM User u WHERE u.email = :email AND u.motdepasse = :motdepasse", User.class)
                            .setParameter("email", email)
                            .setParameter("motdepasse", motdepasse)
                            .getSingleResult();
                    em.getTransaction().commit();
                    request.getSession().setAttribute("user", user);
                    response.sendRedirect("produit?action=list");
            } catch (Exception e) {
                if (em.getTransaction().isActive()) em.getTransaction().rollback();
                e.printStackTrace(); // Ajouter pour voir l'erreur exacte
                request.setAttribute("error", "Email ou mot de passe incorrect : " + e.getMessage());
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            }
            break;

            case "register":
                String nom = request.getParameter("nom");
                String emailsign = request.getParameter("email");
                String mdpsign = request.getParameter("motdepasse");
                String adresse = request.getParameter("adresse");

                em.getTransaction().begin();
                try {
                    // Vérifier si l'email existe déjà (ajouter une gestion d'absence de résultat)
                    User existingUser = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                            .setParameter("email", emailsign)
                            .getResultList().stream().findFirst().orElse(null);
                    if (existingUser != null) {
                        em.getTransaction().rollback();
                        request.setAttribute("error", "Cet email est déjà utilisé. Veuillez vous connecter ou utiliser un autre email.");
                        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                        return;
                    }

                    // Créer le nouvel utilisateur
                    User newUser = new User(nom, emailsign, mdpsign, adresse);
                    em.persist(newUser);
                    em.getTransaction().commit();

                    // Connecter automatiquement l'utilisateur après inscription
                    request.getSession().setAttribute("user", newUser);
                    response.sendRedirect("produit?action=list");
                } catch (Exception e) {
                    if (em.getTransaction().isActive()) em.getTransaction().rollback();
                    e.printStackTrace(); // Ajouter pour voir l'erreur exacte
                    request.setAttribute("error", "Erreur lors de l'inscription : " + e.getMessage());
                    request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
                }

        }
    }
}
