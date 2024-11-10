<%-- 
    Document   : list_all
    Created on : 5/11/2024, 11:48:35 p. m.
    Author     : Gustavo Ortega
--%>

<%@page import="java.util.List"%>
<%@page import="Domain.Model.User" %>
<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Usuarios</title>
    </head>
    <body>
        <h1>Lista de todos los usuarios!</h1>
        <%-- Mensajes de error o éxito --%>
        <% if (request.getAttribute("errorMessage") != null) {%>
        <p style="color:red;"><%= request.getAttribute("errorMessage")%></p> <% } %>
        <% if (request.getAttribute("successMessage") != null) {%>
        <p style="color:green;"><%= request.getAttribute("successMessage")%></p> <% }%>
        <%-- Tabla para mostrar la lista de usuarios --%>
        <table border="1">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Password</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Rol</th>
                    <th>Email</th>
                    <th>Telefono</th>
                    <th>Estado</th>
                    <th>Fecha De Registro</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                ﻿<% List<User> users = (List<User>) request.getAttribute("users"); %> 
                <% if (users != null && !users.isEmpty()) { %>
                    <% for (User user : users) {%>
                        <tr>
                            <td><%= user.getId()%></td>
                            <td><%= user.getPassword()%></td>
                            <td><%= user.getNombre()%></td>
                            <td><%= user.getApellido()%></td>
                            <td><%= user.getRol()%></td>
                            <td><%= user.getEmail()%></td>
                            <td><%= user.getTelefono()%></td>
                            <td><%= user.getEstado()%></td>
                            <td><%= user.getFechaRegistro()%></td>
                            <td>
                                <a href="UserController.jsp?action=search&code=<%= user.getId()%>">Editar</a> |
                                <a href="UserController.jsp?action=deletefl&code=<%= user.getId()%>" onclick="return confirm('¿Seguro que deseas eliminar este usuario?');">Eliminar</a>
                            </td>
                        </tr>
                    <% } %>
                <% } else { %>
                    <tr>
                        <td colspan="4">No hay usuarios disponibles.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>
            <br>
            <a href="<%= request.getContextPath() %>/Controllers/UserController.jsp?action=create">Agregar Nuevo Usuario.</a>
    </body>
</html>
