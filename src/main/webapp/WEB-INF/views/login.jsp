<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Connexion</title>
</head>
<body>
<h1>Connexion</h1>
<c:if test="${not empty error}">
    <p style="color: red;">${error}</p>
</c:if>

<form action="user?action=login" method="post">
    <label>Email: <input type="email" name="email" required></label><br><br>
    <label>Mot de passe: <input type="password" name="motdepasse" required></label><br><br>
    <button type="submit">Se connecter</button>
</form>

<p>Pas de compte ? <a href="user?action=register">S'inscrire</a></p>
</body>
</html>