<%-- 
    Document   : index
    Created on : 5/11/2024, 11:49:40 p. m.
    Author     : Gustavo Ortega
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %> 
<%@ page import="Domain.Model.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pagina de inicio de sesión</title>
    </head>
    <body>
        <h1>Bienvenido ala Gestion de la tabla Usuario y Suscripcion By Gustavo Ortega!</h1>
        <%-- verificamos si el ususario ha iniciado sesion --%>
        <% User loggedInUser = (User) session.getAttribute("loggedInUser"); %>
        <% if (loggedInUser == null) {%>
            <%-- Sino ha iniciado session, mostraremos la opcion de loggin --%>
            <h3>--Aun no has iniciado seSsion--</h3>
            <a href="<%= request.getContextPath()%>/Controllers/UserController.jsp?action=login">INICIAR SESIÓN</a>
        <% } else {%>
            <%-- Si ha iniciado session, mostrara el menú de gestión de usuarios y suscripción --%>
            <h3>HOLA, <%= loggedInUser.getNombre()%>( Has iniciado sesión )</h3>
            <ul>
                <li><a href="<%= request.getContextPath()%>/Controllers/UserController.jsp?action=showCreateForm">AGREGAR USUARIO</a></li>
                <li><a href="<%= request.getContextPath()%>/Controllers/UserController.jsp?action=showFindForm">BUSCAR USUARIO</a></li>
                <li><a href="<%= request.getContextPath()%>/Controllers/UserController.jsp?action=listAll">lISTAR TODOS LOS USUARIOS</a></li>
            </ul>
            <br>
            <a href="<%= request.getContextPath()%>/Controllers/UserController.jsp?action=logout">CERRAR SESIÓN</a>
        <% }%>

    </body>
</html>
