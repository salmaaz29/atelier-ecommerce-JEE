package ma.fstt.atelierecommerce.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.fstt.atelierecommerce.Model.User;
import ma.fstt.atelierecommerce.utils.JPAUtil;

import jakarta.persistence.EntityManager;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserAdminServlet", value = "/admin/user/*")
public class UserAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo(); // Pour CRUD (admin)
        EntityManager em = JPAUtil.createEntityManager();

        try {
            if (pathInfo != null && !pathInfo.equals("/")) {
                System.out.println("Admin pathInfo: " + pathInfo);
                switch (pathInfo) {
                    case "/list":
                        List<User> allUsers = em.createQuery("SELECT u FROM User u", User.class).getResultList();
                        request.setAttribute("users", allUsers);
                        request.getRequestDispatcher("/WEB-INF/views/adminUsers.jsp").forward(request, response);
                        break;
                    case "/add-user":
                        request.getRequestDispatcher("/WEB-INF/views/addUser.jsp").forward(request, response);
                        break;
                    default:
                        if (pathInfo.matches("/edit/\\d+")) {
                            Long id = Long.parseLong(pathInfo.substring(6));
                            User user = em.find(User.class, id);
                            if (user == null) {
                                request.setAttribute("error", "Erreur : cet utilisateur n'existe pas dans la base de données");
                                request.getRequestDispatcher("/WEB-INF/views/adminUsers.jsp").forward(request, response);
                                return;
                            }
                            request.setAttribute("user", user);
                            request.getRequestDispatcher("/WEB-INF/views/editUser.jsp").forward(request, response);
                        } else if (pathInfo.matches("/delete/\\d+")) {
                            Long id = Long.parseLong(pathInfo.substring(8));
                            User user = em.find(User.class, id);
                            if (user != null) {
                                em.getTransaction().begin();
                                try {
                                    em.remove(user);
                                    em.getTransaction().commit();
                                    response.sendRedirect(request.getContextPath() + "/admin/user/list");
                                } catch (Exception e) {
                                    em.getTransaction().rollback();
                                    request.setAttribute("error", "Erreur lors de la suppression : " + e.getMessage());
                                    request.getRequestDispatcher("/WEB-INF/views/adminUsers.jsp").forward(request, response);
                                }
                            } else {
                                request.setAttribute("error", "Utilisateur non trouvé");
                                request.getRequestDispatcher("/WEB-INF/views/adminUsers.jsp").forward(request, response);
                            }
                        } else {
                            request.setAttribute("error", "Chemin invalide");
                            request.getRequestDispatcher("/WEB-INF/views/adminUsers.jsp").forward(request, response);
                        }
                        break;
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/user/list");
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
                    case "/add-user":
                        String nom = request.getParameter("nom");
                        String email = request.getParameter("email");
                        String motdepasse = request.getParameter("motdepasse");
                        String adresse = request.getParameter("adresse");

                        em.getTransaction().begin();
                        try {
                            User newUser = new User(nom, email, motdepasse, adresse);
                            em.persist(newUser);
                            em.getTransaction().commit();
                            response.sendRedirect(request.getContextPath() + "/admin/user/list");
                        } catch (Exception e) {
                            em.getTransaction().rollback();
                            request.setAttribute("error", "Erreur lors de l'ajout : " + e.getMessage());
                            request.getRequestDispatcher("/WEB-INF/views/addUser.jsp").forward(request, response);
                        }
                        break;
                    case "/edit":
                        Long id = Long.parseLong(request.getParameter("id"));
                        User user = em.find(User.class, id);
                        if (user != null) {
                            em.getTransaction().begin();
                            try {
                                user.setNom(request.getParameter("nom"));
                                user.setEmail(request.getParameter("email"));
                                user.setMotdepasse(request.getParameter("motdepasse"));
                                user.setAdresse(request.getParameter("adresse"));
                                em.getTransaction().commit();
                                response.sendRedirect(request.getContextPath() + "/admin/user/list");
                            } catch (Exception e) {
                                em.getTransaction().rollback();
                                request.setAttribute("error", "Erreur lors de la modification : " + e.getMessage());
                                request.setAttribute("user", user);
                                request.getRequestDispatcher("/WEB-INF/views/editUser.jsp").forward(request, response);
                            }
                        } else {
                            response.sendError(HttpServletResponse.SC_NOT_FOUND);
                        }
                        break;
                    default:
                        request.setAttribute("error", "Chemin POST invalide");
                        request.getRequestDispatcher("/WEB-INF/views/adminUsers.jsp").forward(request, response);
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