<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Nos Produits - ShopMaroc</title>
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

        /* Products Grid */
        .produits {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
            animation: fadeInUp 0.8s ease;
        }

        /* Product Card */
        .produit-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.4s ease;
            display: flex;
            flex-direction: column;
        }

        .produit-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.3);
        }

        .product-image-container {
            width: 100%;
            height: 280px;
            overflow: hidden;
            background: #f8f9fa;
            position: relative;
        }

        .product-image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        .produit-card:hover .product-image-container img {
            transform: scale(1.1);
        }

        .stock-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #2ecc71;
            color: white;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: bold;
        }

        .stock-badge.low {
            background: #e74c3c;
        }

        .product-info {
            padding: 1.5rem;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .product-info h3 {
            color: #2c3e50;
            font-size: 1.3rem;
            margin-bottom: 0.8rem;
            min-height: 2.6rem;
            line-height: 1.3rem;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .product-description {
            color: #7f8c8d;
            font-size: 0.9rem;
            margin-bottom: 1rem;
            flex-grow: 1;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            line-height: 1.5;
        }

        .product-price {
            color: #e74c3c;
            font-size: 1.8rem;
            font-weight: bold;
            margin-bottom: 1rem;
        }

        .product-stock {
            color: #95a5a6;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        /* Add to Cart Form */
        .add-to-cart-form {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .quantity-input {
            width: 70px;
            padding: 0.6rem;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            text-align: center;
            transition: border-color 0.3s ease;
        }

        .quantity-input:focus {
            outline: none;
            border-color: #667eea;
        }

        .btn-add-cart {
            flex: 1;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 0.7rem 1rem;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-add-cart:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-add-cart:active {
            transform: translateY(0);
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

            .produits {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 1.5rem;
            }

            .product-image-container {
                height: 220px;
            }
        }

        @media (max-width: 480px) {
            .produits {
                grid-template-columns: 1fr;
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
        <h1>✨ Découvrez Nos Produits ✨</h1>
        <p>Des produits de qualité sélectionnés rien que pour vous</p>
    </div>

    <!-- Messages -->
    <c:if test="${not empty message}">
        <div class="message">✓ ${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="error">✗ ${error}</div>
    </c:if>

    <!-- Products Grid -->
    <div class="produits">
        <c:choose>
            <c:when test="${not empty produits}">
                <c:forEach var="produit" items="${produits}">
                    <div class="produit-card">
                        <div class="product-image-container">
                            <c:choose>
                                <c:when test="${not empty produit.image_produit}">
                                    <img src="${produit.image_produit}" alt="${produit.nom_produit}" />
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/images/default.jpg" alt="Image par défaut" />
                                </c:otherwise>
                            </c:choose>
                            <c:choose>
                                <c:when test="${produit.stock > 10}">
                                    <span class="stock-badge">En stock</span>
                                </c:when>
                                <c:when test="${produit.stock > 0}">
                                    <span class="stock-badge low">Stock limité</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="stock-badge low">Rupture</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="product-info">
                            <h3>${produit.nom_produit}</h3>
                            <p class="product-description">${produit.description_produit}</p>
                            <div class="product-price">${produit.prix_produit} DH</div>
                            <p class="product-stock">📦 Stock disponible: ${produit.stock}</p>

                            <c:if test="${produit.stock > 0}">
                                <form action="${pageContext.request.contextPath}/produit?action=addToCart" method="post" class="add-to-cart-form">
                                    <input type="hidden" name="produitId" value="${produit.id_produit}">
                                    <input type="number" name="quantite" value="1" min="1" max="${produit.stock}" class="quantity-input">
                                    <button type="submit" class="btn-add-cart">
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                            <circle cx="9" cy="21" r="1"></circle>
                                            <circle cx="20" cy="21" r="1"></circle>
                                            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
                                        </svg>
                                        Ajouter
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${produit.stock <= 0}">
                                <button class="btn-add-cart" disabled style="opacity: 0.5; cursor: not-allowed;">
                                    Indisponible
                                </button>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-state-icon">📦</div>
                    <h2>Aucun produit disponible</h2>
                    <p>Revenez bientôt pour découvrir nos nouveaux produits !</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>