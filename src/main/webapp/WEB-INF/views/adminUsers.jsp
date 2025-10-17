<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Administration - Liste des Utilisateurs</title>
    <style>
        .user-card { border: 1px solid #ccc; padding: 10px; margin: 10px; display: inline-block; }
        .error { color: red; }
        .message { color: green; }
    </style>
</head>
<body>
<h1>Liste des Utilisateurs (Administration)</h1>

<c:if test="${not empty message}">
    <p class="message">${message}</p>
</c:if>
<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<div>
    <a href="${pageContext.request.contextPath}/admin/user/add-user">Ajouter un nouvel utilisateur</a>
</div>

<div class="users">
    <c:choose>
        <c:when test="${not empty users}">
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                    <th>Email</th>
                    <th>Adresse</th>
                    <th>Actions</th>
                </tr>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.id_user}</td>
                        <td>${user.nom}</td>
                        <td>${user.email}</td>
                        <td>${user.adresse}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/user/edit/${user.id_user}">Modifier</a> |
                            <a href="${pageContext.request.contextPath}/admin/user/delete/${user.id_user}"
                               onclick="return confirm('Confirmer la suppression de ${user.nom} ?')">Supprimer</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </c:when>
        <c:otherwise>
            <p>Aucun utilisateur disponible.</p>
        </c:otherwise>
    </c:choose>
</div>

<a href="${pageContext.request.contextPath}/user?action=logout">Déconnexion</a>
</body>
</html>