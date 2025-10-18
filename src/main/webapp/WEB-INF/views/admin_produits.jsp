<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Administration - Liste des Produits</title>
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

        .products-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        .products-table th {
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

        .products-table td {
            padding: 1.2rem;
            border-bottom: 1px solid var(--border);
            vertical-align: middle;
        }

        .products-table tr:hover {
            background: #f8fafc;
            transform: scale(1.01);
            transition: all 0.2s ease;
        }

        .product-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .stock-badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-align: center;
            display: inline-block;
        }

        .stock-high {
            background: #c6f6d5;
            color: #276749;
        }

        .stock-medium {
            background: #fefcbf;
            color: #744210;
        }

        .stock-low {
            background: #fed7d7;
            color: #c53030;
        }

        .price {
            font-weight: 700;
            color: var(--primary);
            font-size: 1.1rem;
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
            .products-table {
                font-size: 0.9rem;
            }

            .products-table th,
            .products-table td {
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
        }

        @media (max-width: 480px) {
            .admin-header h1 {
                font-size: 1.5rem;
            }

            .products-table th,
            .products-table td {
                padding: 0.5rem;
                font-size: 0.8rem;
            }

            .product-image {
                width: 40px;
                height: 40px;
            }
        }
    </style>
</head>
<body>
<div class="admin-container">
    <div class="admin-header">
        <h1>📊 Administration des Produits</h1>
        <p>Gérez votre catalogue de produits</p>
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
            <a href="${pageContext.request.contextPath}/admin/produit/add-product" class="btn btn-primary">
                ➕ Ajouter un nouveau produit
            </a>
            <div class="stats">
                <small>📈 ${not empty produits ? produits.size() : 0} produit(s) au total</small>
            </div>
        </div>

        <div class="table-container">
            <c:choose>
                <c:when test="${not empty produits}">
                    <table class="products-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Nom</th>
                            <th>Description</th>
                            <th>Stock</th>
                            <th>Prix</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="produit" items="${produits}">
                            <tr>
                                <td><strong>#${produit.id_produit}</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty produit.image_produit}">
                                            <img src="${produit.image_produit}" alt="${produit.nom_produit}" class="product-image" onerror="this.style.display='none'">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="width:60px;height:60px;background:#f1f5f9;border-radius:8px;display:flex;align-items:center;justify-content:center;color:#94a3b8;">
                                                🖼️
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <strong>${produit.nom_produit}</strong>
                                </td>
                                <td>
                                    <span style="max-width:200px;display:block;">${produit.description_produit}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${produit.stock > 20}">
                                            <span class="stock-badge stock-high">${produit.stock} unités</span>
                                        </c:when>
                                        <c:when test="${produit.stock > 5}">
                                            <span class="stock-badge stock-medium">${produit.stock} unités</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="stock-badge stock-low">${produit.stock} unités</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="price">${produit.prix_produit} DH </span>
                                </td>
                                <td>
                                    <div class="action-links">
                                        <a href="${pageContext.request.contextPath}/admin/produit/edit/${produit.id_produit}" class="action-link edit-link">
                                            ✏️ Modifier
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/produit/delete/${produit.id_produit}"
                                           class="action-link delete-link"
                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer le produit ${produit.nom_produit} ?')">
                                        🗑️ Supprimer
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
                        <div class="empty-state-icon">📦</div>
                        <h3>Aucun produit disponible</h3>
                        <p>Commencez par ajouter votre premier produit</p>
                        <a href="${pageContext.request.contextPath}/admin/produit/add-product" class="btn btn-primary" style="margin-top:1rem;">
                            ➕ Ajouter un produit
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
</body>
</html>