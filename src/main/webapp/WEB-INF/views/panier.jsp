<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Mon Panier - ShopMaroc</title>
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
            max-width: 1200px;
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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .page-header p {
            font-size: 1.2rem;
            color: #7f8c8d;
        }

        /* Messages */
        .message, .error {
            max-width: 800px;
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

        /* Cart Container */
        .cart-container {
            display: grid;
            grid-template-columns: 1fr;
            gap: 2rem;
            animation: fadeInUp 0.8s ease;
        }

        /* Cart Items */
        .cart-items {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .cart-item {
            display: grid;
            grid-template-columns: 100px 1fr auto;
            gap: 1.5rem;
            padding: 1.5rem;
            border-bottom: 2px solid #f0f0f0;
            align-items: center;
            transition: background 0.3s ease;
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .cart-item:hover {
            background: #f8f9fa;
        }

        .item-image {
            width: 100px;
            height: 100px;
            border-radius: 10px;
            object-fit: cover;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .item-details {
            flex-grow: 1;
        }

        .item-name {
            font-size: 1.3rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }

        .item-price {
            color: #667eea;
            font-size: 1.1rem;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .item-quantity {
            color: #7f8c8d;
            font-size: 0.95rem;
        }

        .item-actions {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 1rem;
        }

        .item-total {
            font-size: 1.5rem;
            font-weight: bold;
            color: #e74c3c;
        }

        .btn-remove {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-remove:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }

        /* Cart Summary */
        .cart-summary {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 100px;
        }

        .summary-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #f0f0f0;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            font-size: 1.1rem;
            color: #7f8c8d;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            font-size: 1.8rem;
            font-weight: bold;
            color: #2c3e50;
            padding-top: 1rem;
            border-top: 2px solid #f0f0f0;
            margin-top: 1rem;
        }

        .summary-total .amount {
            color: #e74c3c;
        }

        .btn-validate {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 1rem;
            border-radius: 10px;
            font-size: 1.2rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-validate:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-continue {
            width: 100%;
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
            padding: 1rem;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-continue:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
        }

        /* Empty Cart */
        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }

        .empty-cart-icon {
            font-size: 5rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .empty-cart h2 {
            font-size: 2rem;
            color: #2c3e50;
            margin-bottom: 1rem;
        }

        .empty-cart p {
            color: #7f8c8d;
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }

        .btn-shop {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .btn-shop:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
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

            .cart-item {
                grid-template-columns: 80px 1fr;
                gap: 1rem;
            }

            .item-image {
                width: 80px;
                height: 80px;
            }

            .item-actions {
                grid-column: 2;
                flex-direction: row;
                justify-content: space-between;
                align-items: center;
            }

            .cart-summary {
                position: static;
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
        <h1>
            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="9" cy="21" r="1"></circle>
                <circle cx="20" cy="21" r="1"></circle>
                <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
            </svg>
            Mon Panier
        </h1>
        <p>Gérez vos articles et finalisez votre commande</p>
    </div>

    <!-- Messages -->
    <c:if test="${not empty message}">
        <div class="message">✓ ${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="error">✗ ${error}</div>
    </c:if>

    <!-- Cart Content -->
    <c:choose>
        <c:when test="${not empty lignes}">
            <div class="cart-container">
                <!-- Cart Items -->
                <div class="cart-items">
                    <c:forEach var="ligne" items="${lignes}">
                        <div class="cart-item">
                            <c:choose>
                                <c:when test="${not empty ligne.produit.image_produit}">
                                    <img src="${ligne.produit.image_produit}" alt="${ligne.produit.nom_produit}" class="item-image" />
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/images/default.jpg" alt="Image par défaut" class="item-image" />
                                </c:otherwise>
                            </c:choose>

                            <div class="item-details">
                                <div class="item-name">${ligne.produit.nom_produit}</div>
                                <div class="item-price">Prix unitaire: ${ligne.produit.prix_produit} DH</div>
                                <div class="item-quantity">📦 Quantité: ${ligne.quantite}</div>
                            </div>

                            <div class="item-actions">
                                <div class="item-total">${ligne.quantite * ligne.produit.prix_produit} DH</div>
                                <a href="${pageContext.request.contextPath}/panier?action=removeLine&ligneId=${ligne.id_ligne}"
                                   class="btn-remove"
                                   onclick="return confirm('Voulez-vous vraiment supprimer ${ligne.produit.nom_produit} du panier ?')">
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <polyline points="3 6 5 6 21 6"></polyline>
                                        <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                        <line x1="10" y1="11" x2="10" y2="17"></line>
                                        <line x1="14" y1="11" x2="14" y2="17"></line>
                                    </svg>
                                    Supprimer
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Cart Summary -->
                <div class="cart-summary">
                    <h2 class="summary-title">Récapitulatif</h2>

                    <div class="summary-row">
                        <span>Nombre d'articles:</span>
                        <span><strong>${lignes.size()}</strong></span>
                    </div>

                    <div class="summary-row">
                        <span>Sous-total:</span>
                        <span><strong>${total} DH</strong></span>
                    </div>

                    <div class="summary-row">
                        <span>Livraison:</span>
                        <span><strong>Gratuite 🎉</strong></span>
                    </div>

                    <div class="summary-total">
                        <span>Total:</span>
                        <span class="amount">${total} DH</span>
                    </div>

                    <form action="${pageContext.request.contextPath}/panier?action=validate" method="post">
                        <button type="submit" class="btn-validate">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <polyline points="20 6 9 17 4 12"></polyline>
                            </svg>
                            Valider la commande
                        </button>
                    </form>

                    <a href="${pageContext.request.contextPath}/produit?action=list" class="btn-continue">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                        Continuer mes achats
                    </a>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Empty Cart -->
            <div class="empty-cart">
                <div class="empty-cart-icon">🛒</div>
                <h2>Votre panier est vide</h2>
                <p>Découvrez nos produits et ajoutez vos articles favoris à votre panier</p>
                <a href="${pageContext.request.contextPath}/produit?action=list" class="btn-shop">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="9" cy="21" r="1"></circle>
                        <circle cx="20" cy="21" r="1"></circle>
                        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                    </svg>
                    Découvrir nos produits
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>