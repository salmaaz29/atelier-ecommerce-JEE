<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Administration - Liste des Utilisateurs</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary: #667eea;
            --secondary: #764ba2;
            --accent: #f093fb;
            --dark: #2d3748;
            --light: #f8fafc;
            --success: #48bb78;
            --danger: #e53e3e;
            --warning: #ed8936;
            --text: #2d3748;
            --text-light: #718096;
            --border: #e2e8f0;
        }

        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--text);
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .admin-container {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .admin-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 2.5rem;
            text-align: center;
        }

        .admin-header h1 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .admin-header p {
            opacity: 0.9;
            font-size: 1.1rem;
        }

        .admin-content {
            padding: 2.5rem;
        }

        /* Messages */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 2rem;
            font-weight: 500;
            animation: slideInDown 0.5s ease;
        }

        .alert-error {
            background: #fed7d7;
            color: #c53030;
            border: 2px solid #feb2b2;
        }

        .alert-success {
            background: #c6f6d5;
            color: #276749;
            border: 2px solid #9ae6b4;
        }

        /* Actions Bar */
        .actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        /* Search and Filters */
        .search-filters {
            display: flex;
            gap: 1rem;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-box {
            padding: 0.8rem 1.2rem;
            border: 2px solid var(--border);
            border-radius: 10px;
            font-size: 0.9rem;
            width: 250px;
            transition: all 0.3s ease;
        }

        .search-box:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        /* Button Styles */
        .btn {
            padding: 0.8rem 1.5rem;
            border-radius: 10px;
            font-size: 0.9rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .btn-warning {
            background: var(--warning);
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        /* Table Styles */
        .table-container {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        .users-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        .users-table th {
            background: var(--light);
            padding: 1.2rem;
            text-align: left;
            font-weight: 600;
            color: var(--text);
            border-bottom: 2px solid var(--border);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .users-table td {
            padding: 1.2rem;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        .users-table tr:hover {
            background: #f8fafc;
            transform: scale(1.01);
            transition: all 0.2s ease;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.2rem;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-details h4 {
            margin-bottom: 0.3rem;
            color: var(--text);
        }

        .user-details .email {
            color: var(--text-light);
            font-size: 0.9rem;
        }

        .status-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-align: center;
            display: inline-block;
        }

        .status-active {
            background: #c6f6d5;
            color: #276749;
        }

        .status-inactive {
            background: #fed7d7;
            color: #c53030;
        }

        .action-links {
            display: flex;
            gap: 0.8rem;
        }

        .action-link {
            padding: 0.5rem 1rem;
            border-radius: 6px;
            text-decoration: none;
            font-size: 0.8rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .edit-link {
            background: var(--light);
            color: var(--primary);
            border: 1px solid var(--primary);
        }

        .delete-link {
            background: #fed7d7;
            color: var(--danger);
            border: 1px solid #feb2b2;
        }

        .edit-link:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
        }

        .delete-link:hover {
            background: var(--danger);
            color: white;
            transform: translateY(-2px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-light);
        }

        .empty-state-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--text);
        }

        /* Navigation */
        .admin-nav {
            background: var(--light);
            padding: 1.5rem 2.5rem;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .nav-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .nav-link:hover {
            color: var(--secondary);
            transform: translateX(5px);
        }

        /* Animations */
        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .users-table {
                font-size: 0.9rem;
            }

            .users-table th,
            .users-table td {
                padding: 0.8rem;
            }
        }

        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .admin-header {
                padding: 2rem 1.5rem;
            }

            .admin-content {
                padding: 2rem 1.5rem;
            }

            .actions-bar {
                flex-direction: column;
                align-items: stretch;
            }

            .search-filters {
                width: 100%;
            }

            .search-box {
                width: 100%;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .action-links {
                flex-direction: column;
            }

            .admin-nav {
                flex-direction: column;
                text-align: center;
            }

            .user-info {
                flex-direction: column;
                text-align: center;
                gap: 0.5rem;
            }
        }

        @media (max-width: 480px) {
            .admin-header h1 {
                font-size: 1.5rem;
            }

            .users-table th,
            .users-table td {
                padding: 0.5rem;
                font-size: 0.8rem;
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
<div class="admin-container">
    <div class="admin-header">
        <h1> Gestion des Utilisateurs</h1>
        <p>Administrez les comptes utilisateurs de votre plateforme</p>
    </div>

    <div class="admin-content">
        <c:if test="${not empty message}">
            <div class="alert alert-success">
                ✅ ${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                ⚠️ ${error}
            </div>
        </c:if>

        <div class="actions-bar">
            <a href="${pageContext.request.contextPath}/admin/user/add-user" class="btn btn-primary">
                ➕ Ajouter un utilisateur
            </a>
            <div class="search-filters">
                <input type="text" class="search-box" placeholder="🔍 Rechercher un utilisateur..." id="searchInput">
                <div class="stats">
                    <small> ${not empty users ? users.size() : 0} utilisateur(s) au total</small>
                </div>
            </div>
        </div>

        <div class="table-container">
            <c:choose>
                <c:when test="${not empty users}">
                    <table class="users-table">
                        <thead>
                        <tr>
                            <th>Utilisateur</th>
                            <th>Email</th>
                            <th>Adresse</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr class="user-row">
                                <td>
                                    <div class="user-info">
                                        <div class="user-avatar">
                                                ${user.nom.charAt(0)}
                                        </div>
                                        <div class="user-details">
                                            <h4>${user.nom}</h4>
                                            <small>ID: #${user.id_user}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="email">${user.email}</span>
                                </td>
                                <td>
                                    <span style="max-width:200px;display:block;">${user.adresse}</span>
                                </td>
                                <td>
                                    <span class="status-badge status-active">✅ Actif</span>
                                </td>
                                <td>
                                    <div class="action-links">
                                        <a href="${pageContext.request.contextPath}/admin/user/edit/${user.id_user}" class="action-link edit-link">
                                             Modifier
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/user/delete/${user.id_user}"
                                           class="action-link delete-link"
                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer user  ${user.nom} ?')">
                                         Supprimer
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">👥</div>
                        <h3>Aucun utilisateur trouvé</h3>
                        <p>Commencez par créer votre premier utilisateur</p>
                        <a href="${pageContext.request.contextPath}/admin/user/add-user" class="btn btn-primary" style="margin-top:1rem;">
                            ➕ Ajouter un utilisateur
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="admin-nav">
        <a href="${pageContext.request.contextPath}/user?action=logout" class="nav-link">
             Déconnexion
        </a>
    </div>
</div>

<script>
    // Fonction de recherche
    document.getElementById('searchInput').addEventListener('input', function(e) {
        const searchTerm = e.target.value.toLowerCase();
        const rows = document.querySelectorAll('.user-row');

        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            if (text.includes(searchTerm)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
</script>
</body>
</html>