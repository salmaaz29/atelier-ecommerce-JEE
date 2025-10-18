<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Mes Commandes - ShopMaroc</title>
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
        }

        /* Navbar */
        .navbar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 1rem 0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-container {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 2rem;
        }

        .logo {
            color: white;
            font-size: 1.8rem;
            font-weight: bold;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #667eea;
            font-weight: bold;
        }

        .nav-actions {
            display: flex;
            gap: 1.5rem;
            align-items: center;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            padding: 0.6rem 1.2rem;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
        }

        .cart-icon {
            position: relative;
        }

        .cart-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #e74c3c;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            font-weight: bold;
        }

        /* Main Container */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Page Header */
        .page-header {
            text-align: center;
            margin-bottom: 3rem;
            animation: fadeInDown 0.8s ease;
        }

        .page-header h1 {
            font-size: 3rem;
            color: #2c3e50;
            margin-bottom: 0.5rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .page-header p {
            font-size: 1.2rem;
            color: #7f8c8d;
        }

        /* Messages */
        .message, .error {
            max-width: 600px;
            margin: 0 auto 2rem;
            padding: 1rem 1.5rem;
            border-radius: 10px;
            text-align: center;
            font-weight: 500;
            animation: slideInDown 0.5s ease;
        }

        .message {
            background: #d4edda;
            color: #155724;
            border: 2px solid #c3e6cb;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
            border: 2px solid #f5c6cb;
        }

        /* Commandes Container */
        .commandes-container {
            animation: fadeInUp 0.8s ease;
        }

        /* Commandes Grid */
        .commandes {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 2rem;
        }

        /* Commande Card */
        .commande-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.4s ease;
            display: flex;
            flex-direction: column;
        }

        .commande-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.2);
        }

        .commande-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.2rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .commande-id {
            font-weight: bold;
            font-size: 1.1rem;
        }

        .commande-date {
            opacity: 0.9;
            font-size: 0.9rem;
        }

        .commande-body {
            padding: 1.5rem;
            flex-grow: 1;
        }

        .commande-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }

        .statut {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: bold;
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

        .commande-total {
            font-size: 1.5rem;
            font-weight: bold;
            color: #e74c3c;
            text-align: right;
        }

        .lignes-commande {
            margin-top: 1rem;
        }

        .ligne-commande {
            display: flex;
            justify-content: space-between;
            padding: 0.8rem 0;
            border-bottom: 1px solid #f5f5f5;
        }

        .ligne-commande:last-child {
            border-bottom: none;
        }

        .produit-nom {
            font-weight: 500;
            color: #2c3e50;
        }

        .produit-details {
            color: #7f8c8d;
            font-size: 0.9rem;
        }

        .ligne-prix {
            font-weight: bold;
            color: #2c3e50;
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

        /* Actions */
        .actions {
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

        .btn-secondary {
            background: #95a5a6;
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
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
            .nav-container {
                flex-direction: column;
                gap: 1rem;
            }

            .page-header h1 {
                font-size: 2rem;
            }

            .commandes {
                grid-template-columns: 1fr;
            }

            .commande-info {
                flex-direction: column;
                gap: 0.5rem;
            }

            .commande-total {
                text-align: left;
            }
        }

        @media (max-width: 480px) {
            .commande-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar">
    <div class="nav-container">
        <a href="${pageContext.request.contextPath}/" class="logo">
            <div class="logo-icon">SM</div>
            <span>ShopMaroc</span>
        </a>
        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/panier?action=view" class="nav-link cart-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="9" cy="21" r="1"></circle>
                    <circle cx="20" cy="21" r="1"></circle>
                    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                </svg>
                Mon Panier
                <c:if test="${not empty panierCount and panierCount > 0}">
                    <span class="cart-badge">${panierCount}</span>
                </c:if>
            </a>
            <a href="${pageContext.request.contextPath}/user?action=logout" class="nav-link">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                    <polyline points="16 17 21 12 16 7"></polyline>
                    <line x1="21" y1="12" x2="9" y2="12"></line>
                </svg>
                Déconnexion
            </a>
        </div>
    </div>
</nav>

<!-- Main Container -->
<div class="main-container">
    <!-- Page Header -->
    <div class="page-header">
        <h1>📦 Mes Commandes</h1>
        <p>Retrouvez l'historique de toutes vos commandes</p>
    </div>

    <!-- Messages -->
    <c:if test="${not empty message}">
        <div class="message">✓ ${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="error">✗ ${error}</div>
    </c:if>

    <!-- Commandes Container -->
    <div class="commandes-container">
        <div class="commandes">
            <c:choose>
                <c:when test="${not empty commandes}">
                    <c:forEach var="commande" items="${commandes}" varStatus="status">
                        <div class="commande-card">
                            <div class="commande-header">
                                <div class="commande-id">Commande #${status.index + 1}</div>
                                <div class="commande-date">${commande.dateCommande}</div>
                            </div>

                            <div class="commande-body">
                                <div class="commande-info">
                                    <div>
                                        <span class="statut
                                            <c:choose>
                                                <c:when test="${commande.statut == 'CONFIRME'}">statut-confirme</c:when>
                                                <c:when test="${commande.statut == 'EN_COURS'}">statut-en-cours</c:when>
                                                <c:when test="${commande.statut == 'LIVRE'}">statut-livre</c:when>
                                                <c:otherwise>statut-en-cours</c:otherwise>
                                            </c:choose>">
                                                ${commande.statut}
                                        </span>
                                    </div>
                                    <div class="commande-total">${commande.total} DH</div>
                                </div>

                                <div class="lignes-commande">
                                    <c:forEach var="ligne" items="${commande.lignes}">
                                        <div class="ligne-commande">
                                            <div>
                                                <div class="produit-nom">${ligne.produit.nom_produit}</div>
                                                <div class="produit-details">Quantité: ${ligne.quantite}</div>
                                            </div>
                                            <div class="ligne-prix">${ligne.quantite * ligne.produit.prix_produit} DH</div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">📦</div>
                        <h2>Aucune commande effectuée</h2>
                        <p>Vous n'avez pas encore passé de commande sur notre site.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Actions -->
        <div class="actions">
            <a href="${pageContext.request.contextPath}/produit?action=list" class="btn btn-primary">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M19 12H5M12 19l-7-7 7-7"/>
                </svg>
                Retour aux produits
            </a>
            <a href="${pageContext.request.contextPath}/user?action=logout" class="btn btn-secondary">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                    <polyline points="16 17 21 12 16 7"></polyline>
                    <line x1="21" y1="12" x2="9" y2="12"></line>
                </svg>
                Déconnexion
            </a>
        </div>
    </div>
</div>
</body>
</html>