<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mon Panier</title>
    <style>
        .ligne-card { border: 1px solid #ccc; padding: 10px; margin: 10px; }
        .error { color: red; }
        .message { color: green; }
    </style>
</head>
<body>
<h1>Mon Panier</h1>

<c:if test="${not empty message}">
    <p class="message">${message}</p>
</c:if>
<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<div class="lignes">
    <c:choose>
        <c:when test="${not empty lignes}">
            <table border="1">
                <tr>
                    <th>Produit</th>
                    <th>Quantité</th>
                    <th>Prix Unitaire</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
                <c:forEach var="ligne" items="${lignes}">
                    <tr>
                        <td>${ligne.produit.nom_produit}</td>
                        <td>${ligne.quantite}</td>
                        <td>${ligne.produit.prix_produit} €</td>
                        <td>${ligne.quantite * ligne.produit.prix_produit} €</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/panier?action=removeLine&ligneId=${ligne.id_ligne}"
                               onclick="return confirm('Supprimer ${ligne.produit.nom_produit} du panier ?')">Supprimer</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <p>Total du panier: <c:out value="${total}"/> €</p>
            <form action="${pageContext.request.contextPath}/panier?action=validate" method="post">
                <input type="submit" value="Valider la commande">
            </form>
        </c:when>
        <c:otherwise>
            <p>Votre panier est vide.</p>
        </c:otherwise>
    </c:choose>
</div>

<a href="${pageContext.request.contextPath}/produit?action=list">Retour aux produits</a> |
<a href="${pageContext.request.contextPath}/user?action=logout">Déconnexion</a>
</body>
</html>