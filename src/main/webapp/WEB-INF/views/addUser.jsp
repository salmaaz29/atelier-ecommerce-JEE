<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Ajouter un utilisateur</title>
</head>
<body>
<h1>Ajouter un nouvel utilisateur</h1>
<c:if test="${not empty error}">
  <p style="color:red">${error}</p>
</c:if>
<form action="${pageContext.request.contextPath}/admin/user/add-user" method="post">
  <label>Nom :</label><br>
  <input type="text" name="nom" required><br>
  <label>Email :</label><br>
  <input type="email" name="email" required><br>
  <label>Mot de passe :</label><br>
  <input type="password" name="motdepasse" required><br>
  <label>Adresse :</label><br>
  <input type="text" name="adresse" required><br>
  <input type="submit" value="Ajouter">
</form>
<a href="${pageContext.request.contextPath}/admin/user/list">Retour à la liste</a>
</body>
</html>