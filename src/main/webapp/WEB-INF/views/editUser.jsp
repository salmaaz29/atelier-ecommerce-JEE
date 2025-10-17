<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier un utilisateur</title>
</head>
<body>
<h1>Modifier un utilisateur</h1>
<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>
<form action="${pageContext.request.contextPath}/admin/user/edit" method="post">
    <input type="hidden" name="id" value="${user.id_user}">
    <label>Nom :</label><br>
    <input type="text" name="nom" value="${user.nom}" required><br>
    <label>Email :</label><br>
    <input type="email" name="email" value="${user.email}" required><br>
    <label>Mot de passe :</label><br>
    <input type="password" name="motdepasse" value="${user.motdepasse}" required><br>
    <label>Adresse :</label><br>
    <input type="text" name="adresse" value="${user.adresse}" required><br>
    <input type="submit" value="Modifier">
</form>
<a href="${pageContext.request.contextPath}/admin/user/list">Retour à la liste</a>
</body>
</html>