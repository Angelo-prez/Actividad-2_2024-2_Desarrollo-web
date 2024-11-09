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
            <input type="text" id="ID" name="ID" required value="<%= session.getAttribute("searchedUser") != null ? ((User)%>">
            session.getAttribute("searchedUser")).getID()
            <br><br>

            <%-- Detalles del usuario (después de la búsqueda) --%>
            <% User sessionUser = (User) session.getAttribute("searchedUser");%>

        </form>
    </body>
</html>
