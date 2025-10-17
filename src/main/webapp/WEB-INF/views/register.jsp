<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Inscription</title>
</head>
<body>
<h1>Inscription</h1>
<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>

<form action="user?action=register" method="post">
    <label>Nom: <input type="text" name="nom" required></label><br><br>
    <label>Email: <input type="email" name="email" required></label><br><br>
    <label>Mot de passe: <input type="password" name="motdepasse" required></label><br><br>
    <label>Adresse: <input type="text" name="adresse" required></label><br><br>
    <button type="submit">S'inscrire</button>
</form>

<p>Déjà un compte ? <a href="user?action=login">Se connecter</a></p>
</body>
</html>