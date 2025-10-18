<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Modifier un Produit - Administration</title>
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
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        .admin-header {
            background: linear-gradient(135deg, var(--warning) 0%, #ed8936 100%);
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

        /* Form Styles */
        .form-group {
            margin-bottom: 1.8rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.7rem;
            color: var(--text);
            font-weight: 600;
            font-size: 1rem;
        }

        .form-input {
            width: 100%;
            padding: 1rem 1.2rem;
            border: 2px solid var(--border);
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: var(--light);
        }

        .form-input:focus {
            outline: none;
            border-color: var(--warning);
            background: white;
            box-shadow: 0 0 0 3px rgba(237, 137, 54, 0.1);
            transform: translateY(-2px);
        }

        .form-input::placeholder {
            color: var(--text-light);
        }

        /* Button Styles */
        .btn {
            padding: 1rem 2rem;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: none;
            cursor: pointer;
        }

        .btn-warning {
            background: linear-gradient(135deg, var(--warning) 0%, #ed8936 100%);
            color: white;
            box-shadow: 0 8px 25px rgba(237, 137, 54, 0.3);
        }

        .btn-secondary {
            background: var(--light);
            color: var(--text);
            border: 2px solid var(--border);
        }

        .btn-warning:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(237, 137, 54, 0.4);
        }

        .btn-secondary:hover {
            background: white;
            border-color: var(--warning);
            transform: translateY(-2px);
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            margin-top: 2.5rem;
            flex-wrap: wrap;
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
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .admin-header {
                padding: 2rem 1.5rem;
            }

            .admin-header h1 {
                font-size: 1.8rem;
            }

            .admin-content {
                padding: 2rem 1.5rem;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
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

            .admin-header p {
                font-size: 1rem;
            }

            .form-input {
                padding: 0.8rem 1rem;
            }
        }
    </style>
</head>
<body>
<div class="admin-container">
    <div class="admin-header">
        <h1> Modifier le Produit</h1>
        <p>Mettez à jour les informations du produit #${produit.id_produit}</p>
    </div>

    <div class="admin-content">
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                ⚠️ ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/produit/edit" method="post">
            <input type="hidden" name="id" value="${produit.id_produit}">

            <div class="form-group">
                <label class="form-label"> Nom du produit</label>
                <input type="text" name="nom_produit" class="form-input" value="${produit.nom_produit}" required>
            </div>

            <div class="form-group">
                <label class="form-label"> Stock disponible</label>
                <input type="number" name="stock" class="form-input" value="${produit.stock}" required>
            </div>

            <div class="form-group">
                <label class="form-label"> Description</label>
                <input type="text" name="description_produit" class="form-input" value="${produit.description_produit}" required>
            </div>

            <div class="form-group">
                <label class="form-label"> URL de l'image</label>
                <input type="text" name="image_produit" class="form-input" value="${produit.image_produit}" required>
            </div>

            <div class="form-group">
                <label class="form-label"> Prix (€)</label>
                <input type="number" step="0.01" name="prix_produit" class="form-input" value="${produit.prix_produit}" required>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-warning">
                    Enregistrer les modifications
                </button>
                <a href="${pageContext.request.contextPath}/admin/produit/list" class="btn btn-secondary">
                     Annuler
                </a>
            </div>
        </form>
    </div>

    <div class="admin-nav">
        <a href="${pageContext.request.contextPath}/admin/produit/list" class="nav-link">
             Liste des produits
        </a>
        <a href="${pageContext.request.contextPath}/user?action=logout" class="nav-link">
            Déconnexion
        </a>
    </div>
</div>
</body>
</html>>