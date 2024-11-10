<%-- 
    Document   : find_edit_delete
    Created on : 5/11/2024, 11:47:38 p. m.
    Author     : Gustavo Ortega
--%>

<%@ page import="Domain.Model.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BUSCAR , EDITAR Y ELIMINAR REGISTROS DE USUARIO</title>
        ﻿
        // Función: habilitar botones, Editar y Eliminar
        <script>
            function enableButtons() {
                document.getElementById("editBtn").disabled = false;
                document.getElementById("deleteBtn").disabled = false;
            }
            // Función para deshabilitar los botones de Editar y Eliminar 
            function disableButtons() {
                document.getElementById("editBtn").disabled = true;
                document.getElementById("deleteBtn").disabled = true;
            }
            // Función: cambiar acción del formulario y confirmar la eliminación 
            function setActionAndSubmit(action, confirmMessage) {
                if (confirmMessage) {
                    if (!confirm(confirmMessage)) {
                        return;
                    }
                }
                document.getElementById("actionInput").value = action;
                document.getElementById("userForm").submit();
            }
        </script>
    </head>
    <body ﻿onload="<%= (session.getAttribute("searchedUser") != null) ? "enableButtons()" : "disableButtons()"%>">
        <h1>BUSCAR, EDITAR O ELIMINAR USUARIO.</h1>        ﻿

        <%-- Mensajes de error o éxito --%>
        <% if (request.getAttribute("errorMessage") != null) {%>
        <p style="color:red;"><%= request.getAttribute("errorMessage")%></p> 
        <% } %>
        <% if (request.getAttribute("successMessage") != null) {%>
        <p style="color:green;"><%= request.getAttribute("successMessage")%></p> 
        <% }%>

        <%-- Formulario para buscar, editar y eliminar --%>
        <form id="userForm" action="<%= request.getContextPath()%>/Controllers/UserController.jsp?" method="post">">
            ﻿<!-- El valor cambiará dinámicamente -->
            <input type="hidden" id="actionInput" name="action" value="search">

            <label for="searchCode">ID del usuario:</label><br> 
            <input type="text" id="ID" name="ID" required value="
                   <%= session.getAttribute("searchedUser") != null
                           ? ((User) session.getAttribute("searchedUser")).getId() : ""%>"> 
            <br><br>

            <%-- Detalles del usuario (después de la búsqueda) --%>
            <% User sessionUser = (User) session.getAttribute("searchedUser");%>

            ﻿

            <% if (sessionUser != null) {%>
            <h3>Detalles del Usuario</h3>
            <p><strong>ID:</strong> <%= sessionUser.getId()%></p> 
            <p><strong>PASSWORD:</strong> <%= sessionUser.getPassword()%></p> 
            <p><strong>NOMBRE:</strong> <%= sessionUser.getNombre()%></p>
            <p><strong>APELLIDO</strong> <%= sessionUser.getApellido()%></p> 
            <p><strong>ROL:</strong> <%= sessionUser.getRol()%></p> 
            <p><strong>Email:</strong> <%= sessionUser.getEmail()%></p>
            <p><strong>TELEFONO</strong> <%= sessionUser.getTelefono()%></p> 
            <p><strong>ESTADO</strong> <%= sessionUser.getEstado()%></p> 
            <p><strong>FECHA DE REGISTRO</strong> <%= sessionUser.getFechaRegistro()%></p>

            ﻿<label for="password">Nueva Contraseña</label><br>
            <input type="password" id="password" name="password" value="<%= sessionUser.getPassword()%>" required>
            <br>
            <label for="nombre">Nuevo Nombre</label><br>
            <input type="text" id="nombre" name="nombre" value="<%= sessionUser.getNombre()%>" required> 
            <br>
            ﻿<label for="apellido">Nuevo Apellido</label><br>
            <input type="text" id="apellido" name="apellido" value="<%= sessionUser.getApellido()%>" required>
            <br>
            <label for="rol">Asignar Rol</label><br>
            <input type="text" id="rol" name="rol" value="<%= sessionUser.getRol()%>" required> 
            <br>
            ﻿<label for="email">Nuevo Email</label><br>
            <input type="email" id="email" name="email" value="<%= sessionUser.getEmail()%>" required>
            <br>
            <label for="telefono">Nuevo Telefono</label><br>
            <input type="tel" id="telefono" name="telefono" value="<%= sessionUser.getTelefono()%>" required> 
            <br>
            ﻿<label for="estado">Nuevo Estado</label><br>
            <input type="text" id="estado" name="estado" value="<%= sessionUser.getEstado()%>" required>
            <br>
            <br>
            <label for="fechaRegistro">Nueva Fecha De Registro</label><br>
            <input type="date" id="fechaRegistro" name="fechaRegistro" value="<%= sessionUser.getFechaRegistro()%>" required> 
            <br>          ﻿

            <% } else { %>
            <p>No se ha buscado ningún usuario aún o el usuario no fue encontrado.</p>
            <% }%>
            <br>         ﻿

            <%-- Botones en la misma fila --%>
            <button type="submit" onclick="setActionAndSubmit('search')" id="searchBtn">Buscar Usuario</button>
            <button type="button" id="editBtn" disabled onclick="setActionAndSubmit('update', '¿Seguro que deseas editar este usuario?')">Editar Usuario</button>
            <button type="button" id="deleteBtn" disabled onclick="setActionAndSubmit('delete', '¿Seguro que deseas eliminar este usuario?')">Eliminar Usuario</button>
        </form>
        <br><!-- comment -->
        <a href="<%= request.getContextPath()%>/index.jsp">Menu Principal</a>
    </body>
</html>
