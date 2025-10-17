<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Ajouter un produit</title>
</head>
<body>
<h1>Ajouter un nouveau produit</h1>
<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>
<form action="${pageContext.request.contextPath}/admin/produit/add-product" method="post">
    <label>Nom du produit :</label><br>
    <input type="text" name="nom_produit" required><br>
    <label>Stock :</label><br>
    <input type="number" name="stock" required><br>
    <label>Description :</label><br>
    <input type="text" name="description_produit" required><br>
    <label>Image :</label><br>
    <input type="text" name="image_produit" required><br>
    <label>Prix :</label><br>
    <input type="number" step="0.01" name="prix_produit" required><br>
    <input type="submit" value="Ajouter">
</form>
<a href="${pageContext.request.contextPath}/admin/produit/list">Retour à la liste</a>
</body>
</html>