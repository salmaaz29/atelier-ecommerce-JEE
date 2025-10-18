<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <title>Modifier Commande - Admin ShopMaroc</title>
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
            max-width: 600px;
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

        /* Form Container */
        .form-container {
            max-width: 500px;
            margin: 0 auto;
            background: white;
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            animation: fadeInUp 0.8s ease;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin-bottom: 0.5rem;
            color: #2c3e50;
            font-weight: 600;
            font-size: 1rem;
        }

        input, select {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        /* Buttons */
        .btn {
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: none;
            cursor: pointer;
            font-size: 1rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            width: 100%;
            justify-content: center;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: #95a5a6;
            color: white;
        }

        .btn-secondary:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
            box-shadow: 0 3px 10px rgba(149, 165, 166, 0.3);
        }

        /* Navigation */
        .navigation {
            text-align: center;
            margin-top: 2rem;
            display: flex;
            justify-content: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        /* Commande Info */
        .commande-info {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            border-left: 4px solid #667eea;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid #e9ecef;
        }

        .info-item:last-child {
            margin-bottom: 0;
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #2c3e50;
        }

        .info-value {
            color: #7f8c8d;
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

            .form-container {
                padding: 2rem;
                margin: 0 1rem;
            }

            .navigation {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .form-container {
                padding: 1.5rem;
            }

            .commande-info {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
<!-- Page Header -->
<div class="page-header">
    <h1>✏️ Modifier Commande <span class="admin-badge">ADMIN</span></h1>
    <p>Mise à jour du statut de la commande</p>
</div>

<!-- Messages -->
<c:if test="${not empty error}">
    <div class="error">✗ ${error}</div>
</c:if>

<!-- Form Container -->
<div class="form-container">
    <!-- Commande Information -->
    <div class="commande-info">
        <div class="info-item">
            <span class="info-label">ID Commande:</span>
            <span class="info-value">#${commande.id_commande}</span>
        </div>
        <div class="info-item">
            <span class="info-label">Date:</span>
            <span class="info-value">${commande.dateCommande}</span>
        </div>
        <div class="info-item">
            <span class="info-label">Total:</span>
            <span class="info-value">${commande.total} DH</span>
        </div>
        <div class="info-item">
            <span class="info-label">Statut actuel:</span>
            <span class="info-value">${commande.statut}</span>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/admin/commande/edit" method="post">
        <input type="hidden" name="id" value="${commande.id_commande}">

        <div class="form-group">
            <label for="statut">Nouveau Statut :</label>
            <select name="statut" id="statut" required>
                <option value="EN_ATTENTE" ${commande.statut == 'EN_ATTENTE' ? 'selected' : ''}>⏳ En attente</option>
                <option value="CONFIRME" ${commande.statut == 'CONFIRME' ? 'selected' : ''}>✅ Confirmée</option>
                <option value="EXPEDIEE" ${commande.statut == 'EXPEDIEE' ? 'selected' : ''}>🚚 Expédiée</option>
                <option value="LIVREE" ${commande.statut == 'LIVREE' ? 'selected' : ''}>📦 Livrée</option>
                <option value="ANNULEE" ${commande.statut == 'ANNULEE' ? 'selected' : ''}>❌ Annulée</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path>
                <polyline points="17 21 17 13 7 13 7 21"></polyline>
                <polyline points="7 3 7 8 15 8"></polyline>
            </svg>
            Mettre à jour le statut
        </button>
    </form>
</div>

<!-- Navigation -->
<div class="navigation">
    <a href="${pageContext.request.contextPath}/admin/commande/list" class="btn btn-secondary">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M19 12H5M12 19l-7-7 7-7"/>
        </svg>
        Retour à la liste
    </a>
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
            <polyline points="9 22 9 12 15 12 15 22"></polyline>
        </svg>
        Dashboard Admin
    </a>
</div>
</body>
</html>