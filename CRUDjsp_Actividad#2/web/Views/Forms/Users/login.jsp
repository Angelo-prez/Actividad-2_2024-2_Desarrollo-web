<%-- 
    Document   : login
    Created on : 5/11/2024, 11:48:58 p. m.
    Author     : Gustavo Ortega
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login(Iniciaer sesión)</title>
    </head>
    <body>
        <h1>BIENVENIDO AL INICIA DE SESIÓN</h1>

        <%-- Mensaje de error en caso de credenciales incorrectas --%>
        <% if (request.getAttribute("errorMessage") != null) {%>
        <p style="color:red;"><%= request.getAttribute("errorMessage")%></p>
        <% }%>
        <%-- Formulario de iniacio de sesion(login) --%>
        <form action="<%= request.getContextPath()%>/Controllers/UserController.jsp?action=authenticate" method="post"> 
            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" required><br><br>

            <label for="password">Contraseña:</label><br>
            <input type="password" id="password" name="password" required><br><br>

            <input type="submit" value="Iniciar Sesión">
        </form>
        <br>        
        <a href="<%= request.getContextPath()%>/index.jsp">Volver a la página de inicio</a>
    </body>
</html>
