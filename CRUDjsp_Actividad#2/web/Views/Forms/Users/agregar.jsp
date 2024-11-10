<%-- 
    Document   : agregar
    Created on : 5/11/2024, 11:46:44 p. m.
    Author     : Gustavo Ortega
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AGREGAR USUARIO</title>
    </head>
    <body>
        <h1>AGREGAR USUARIO</h1>       ﻿

        <%-- Mensajes de error o éxito --%>
        <% if (request.getAttribute("errorMessage") != null) {%>
        <p style="color:red;"><%= request.getAttribute("errorMessage")%></p>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) {%>
        <p style="color:green;"><%= request.getAttribute("successMessage")%></p>
        <% }%>
        <%-- Formulario para agregar usuario --%>
        <form action="<%= request.getContextPath()%>/Controllers/UserController.jsp?action=create" method="post"> 
            <label for="id">ID</label><br>
            <input type="number" id="id" name="id" required><br>

            <label for="password">PASSWORD</label><br>
            <input type="password" id="password" name="password" required><br>

            <label for="nombre">NOMBRE</label><br>
            <input type="text" id="nombre" name="nombre" required><br>

            <label for="apellido">APELLIDO</label><br>
            <input type="text" id="apellido" name="apellido" required><br>

            <label for="rol">ROL</label><br>
            <input type="password" id="rol" name="rol" required><br>

            <label for="email">EMAIL</label><br>
            <input type="email" id="email" name="email" required><br>

            <label for="telefono">TELEFONO</label><br>
            <input type="tel" id="telefono" name="telefono" required><br>

            <label for="estado">ESTADO</label><br>
            <input type="text" id="estado" name="estado" required><br>

            <label for="fechaRegistro">FECHA DE REGISTO</label><br>
            <input type="date" id="fechaRegistro" name="fechaRegistro" required><br>

            <input type="submit" value="Agregar Usuario">
        </form>
        <br>
        <a href="<%= request.getContextPath()%>/index.jsp">Menu Principal</a>
    </body>
</html>
