<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mes Commandes</title>
    <style>
        .commande-card { border: 1px solid #ccc; padding: 10px; margin: 10px; }
        .error { color: red; }
        .message { color: green; }
    </style>
</head>
<body>
<h1>Mes Commandes</h1>

<c:if test="${not empty message}">
    <p class="message">${message}</p>
</c:if>
<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<div class="commandes">
    <c:choose>
        <c:when test="${not empty commandes}">
            <c:forEach var="commande" items="${commandes}">
                <div class="commande-card">
                    <p>Date: ${commande.dateCommande}</p>
                    <p>Total: ${commande.total} €</p>
                    <c:forEach var="ligne" items="${commande.lignes}">
                        <p>Produit: ${ligne.produit.nom_produit}, Quantité: ${ligne.quantite}, Prix: ${ligne.quantite * ligne.produit.prix_produit} €</p>
                    </c:forEach>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>Aucune commande effectuée.</p>
        </c:otherwise>
    </c:choose>
</div>

<a href="${pageContext.request.contextPath}/produit?action=list">Retour aux produits</a> |
<a href="${pageContext.request.contextPath}/user?action=logout">Déconnexion</a>
</body>
</html>