<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Vitrine Produits</title>
    <style>
        .produit-card { border: 1px solid #ccc; padding: 10px; margin: 10px; display: inline-block; }
        .error { color: red; }
        .message { color: green; }
    </style>
</head>
<body>
<h1>Nos Produits</h1>

<c:if test="${not empty message}">
    <p class="message">${message}</p>
</c:if>
<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<div class="produits">
    <c:choose>
        <c:when test="${not empty produits}">
            <c:forEach var="produit" items="${produits}">
                <div class="produit-card">
                    <h3>${produit.nom_produit}</h3>
                    <p>${produit.description_produit}</p>
                    <p>Prix: ${produit.prix_produit} €</p>
                    <p>Stock: ${produit.stock}</p>
                    <form action="${pageContext.request.contextPath}/produit?action=addToCart" method="post" style="display: inline;">
                        <input type="hidden" name="produitId" value="${produit.id_produit}">
                        <input type="number" name="quantite" value="1" min="1" max="${produit.stock}" style="width: 60px;">
                        <button type="submit">Ajouter au panier</button>
                    </form>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p>Aucun produit disponible.</p>
        </c:otherwise>
    </c:choose>
</div>

<a href="${pageContext.request.contextPath}/panier?action=view">Voir mon panier</a> |
<a href="${pageContext.request.contextPath}/user?action=logout">Déconnexion</a>
</body>
</html>