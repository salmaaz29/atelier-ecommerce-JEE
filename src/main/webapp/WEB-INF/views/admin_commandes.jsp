<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Liste des Commandes - Admin ShopMaroc</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: #333;
            min-height: 100vh;
            padding: 20px;
        }

        /* Header */
        .page-header {
            text-align: center;
            margin-bottom: 3rem;
            animation: fadeInDown 0.8s ease;
        }

        .page-header h1 {
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 0.5rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .page-header p {
            font-size: 1.1rem;
            color: #7f8c8d;
        }

        .admin-badge {
            display: inline-block;
            background: #e74c3c;
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 15px;
            font-size: 0.9rem;
            font-weight: bold;
            margin-left: 1rem;
            vertical-align: middle;
        }

        /* Messages */
        .error {
            max-width: 800px;
            margin: 0 auto 2rem;
            padding: 1rem 1.5rem;
            border-radius: 10px;
            text-align: center;
            font-weight: 500;
            animation: slideInDown 0.5s ease;
            background: #f8d7da;
            color: #721c24;
            border: 2px solid #f5c6cb;
        }

        /* Table Container */
        .table-container {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
            animation: fadeInUp 0.8s ease;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Commandes Table */
        .commande-table {
            width: 100%;
            border-collapse: collapse;
        }

        .commande-table th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.2rem 1rem;
            text-align: left;
            font-weight: 600;
            font-size: 1rem;
        }

        .commande-table td {
            padding: 1rem;
            border-bottom: 1px solid #eee;
            color: #2c3e50;
        }

        .commande-table tr:last-child td {
            border-bottom: none;
        }

        .commande-table tr:hover {
            background: #f8f9fa;
        }

        /* Status Badges */
        .statut-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: bold;
            text-align: center;
            display: inline-block;
            min-width: 100px;
        }

        .statut-confirme {
            background: #d4edda;
            color: #155724;
        }

        .statut-en-cours {
            background: #fff3cd;
            color: #856404;
        }

        .statut-livre {
            background: #d1ecf1;
            color: #0c5460;
        }

        .statut-annule {
            background: #f8d7da;
            color: #721c24;
        }

        /* Action Buttons */
        .btn-edit {
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 0.9rem;
            background: #3498db;
            color: white;
        }

        .btn-edit:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 3px 10px rgba(52, 152, 219, 0.3);
        }

        /* Admin Actions */
        .admin-actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #7f8c8d;
        }

        .empty-state-icon {
            font-size: 5rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .empty-state h2 {
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
            max-width: 1200px;
            margin: 0 auto 2rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            animation: fadeInUp 0.8s ease;
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #7f8c8d;
            font-size: 0.9rem;
            font-weight: 500;
        }

        /* Animations */
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

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
        @media (max-width: 768px) {
            .page-header h1 {
                font-size: 2rem;
            }

            .table-container {
                overflow-x: auto;
            }

            .commande-table {
                min-width: 700px;
            }

            .stats-container {
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            }
        }

        @media (max-width: 480px) {
            .admin-actions {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<!-- Page Header -->
<div class="page-header">
    <h1>📊 Liste des Commandes <span class="admin-badge">ADMIN</span></h1>
    <p>Gestion et suivi de toutes les commandes clients</p>
</div>

<!-- Messages -->
<c:if test="${not empty error}">
    <div class="error">✗ ${error}</div>
</c:if>

<!-- Statistics -->
<c:if test="${not empty commandes}">
    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-number">${commandes.size()}</div>
            <div class="stat-label">Total Commandes</div>
        </div>
        </div>
    </div>
</c:if>

<!-- Commandes Table -->
<div class="table-container">
    <c:choose>
        <c:when test="${not empty commandes}">
            <table class="commande-table">
                <thead>
                <tr>
                    <th>ID Commande</th>
                    <th>Date</th>
                    <th>Total</th>
                    <th>Statut</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="commande" items="${commandes}">
                    <tr>
                        <td><strong>#${commande.id_commande}</strong></td>
                        <td>${commande.dateCommande}</td>
                        <td><strong>${commande.total} DH</strong></td>
                        <td>
                                    <span class="statut-badge
                                        <c:choose>
                                            <c:when test="${commande.statut == 'CONFIRME'}">statut-confirme</c:when>
                                            <c:when test="${commande.statut == 'EN_COURS'}">statut-en-cours</c:when>
                                            <c:when test="${commande.statut == 'LIVRE'}">statut-livre</c:when>
                                            <c:when test="${commande.statut == 'ANNULE'}">statut-annule</c:when>
                                            <c:otherwise>statut-en-cours</c:otherwise>
                                        </c:choose>">
                                            ${commande.statut}
                                    </span>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/commande/edit/${commande.id_commande}" class="btn-edit">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                                    <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                                </svg>
                                Modifier
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div class="empty-state-icon">📦</div>
                <h2>Aucune commande disponible</h2>
                <p>Il n'y a actuellement aucune commande à afficher.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>


<div class="admin-actions">
    <a href="${pageContext.request.contextPath}/user?action=logout" class="btn btn-primary">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
            <polyline points="14 2 14 8 20 8"></polyline>
            <line x1="16" y1="13" x2="8" y2="13"></line>
            <line x1="16" y1="17" x2="8" y2="17"></line>
            <polyline points="10 9 9 9 8 9"></polyline>
        </svg>
        Deconnexion
    </a>
</div>
</body>
</html>