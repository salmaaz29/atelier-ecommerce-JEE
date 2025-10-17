<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Administration - Liste des Produits</title>
    <style>
        .produit-card { border: 1px solid #ccc; padding: 10px; margin: 10px; display: inline-block; }
        .error { color: red; }
        .message { color: green; }
    </style>
</head>
<body>
<h1>Liste des Produits (Administration)</h1>

<c:if test="${not empty message}">
    <p class="message">${message}</p>
</c:if>
<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<div>
    <a href="${pageContext.request.contextPath}/admin/produit/add-product">Ajouter un nouveau produit</a>
</div>

<div class="produits">
    <c:choose>
        <c:when test="${not empty produits}">
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                    <th>Description</th>
                    <th>Stock</th>
                    <th>Prix</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
                <c:forEach var="produit" items="${produits}">
                    <tr>
                        <td>${produit.id_produit}</td>
                        <td>${produit.nom_produit}</td>
                        <td>${produit.description_produit}</td>
                        <td>${produit.stock}</td>
                        <td>${produit.prix_produit} €</td>
                        <td>${produit.image_produit}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/produit/edit/${produit.id_produit}">Modifier</a> |
                            <a href="${pageContext.request.contextPath}/admin/produit/delete/${produit.id_produit}"
                               onclick="return confirm('Confirmer la suppression de ${produit.nom_produit} ?')">Supprimer</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:when>
        <c:otherwise>
            <p>Aucun produit disponible.</p>
        </c:otherwise>
    </c:choose>
</div>

<a href="${pageContext.request.contextPath}/user?action=logout">Déconnexion</a>
</body>
</html>