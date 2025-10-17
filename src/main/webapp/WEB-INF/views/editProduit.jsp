<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier un Produit</title>
</head>
<body>
<h1>Modifier un Produit</h1>
<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>

<form action="${pageContext.request.contextPath}/admin/produit/edit"  method="post">
    <input type="hidden" name="id" value="${produit.id_produit}">
    <label>Nom: <input type="text" name="nom_produit" value="${produit.nom_produit}" required></label><br><br>
    <label>Stock: <input type="number" name="stock" value="${produit.stock}" required></label><br><br>
    <label>Description: <input type="text" name="description_produit" value="${produit.description_produit}" required></label><br><br>
    <label>Image: <input type="text" name="image_produit" value="${produit.image_produit}" required></label><br><br>
    <label>Prix: <input type="number" step="0.01" name="prix_produit" value="${produit.prix_produit}" required></label><br><br>
    <button type="submit">Modifier</button>
</form>

<a href="${pageContext.request.contextPath}/produit/list">Retour à la liste</a>
</body>
</html>