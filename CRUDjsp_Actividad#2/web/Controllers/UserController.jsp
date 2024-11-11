<%-- 
    Document   : UserController
    Created on : 5/11/2024, 11:44:52 p. m.
    Author     : Gustavo Ortega
--%>

<%@page import="javax.print.DocFlavor.STRING"%>
<%@page import="java.text.ParseException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="java.sql.SQLException" %>
<%@page import="Business.Exceptions.DuplicateUserException" %>
<%@page import="java.io.IOException" %>
<%@page import="jakarta.servlet.ServletException" %>
<%@page import="jakarta.servlet.http.HttpServletRequest" %>
<%@page import="jakarta.servlet.http.HttpServletResponse" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="Business.Services.UserService" %>
<%@page import="Domain.Model.User" %>
<%@page import="Business.Exceptions.UserNotFoundException" %>
<%@page import="Business.Exceptions.DuplicateUserException" %>

<%
    UserService userService = new UserService();
    String action = request.getParameter("action");

    if (action == null) {
        action = "list";
    }

    switch (action) {
        case "login":
            handleLogin(request, response, session);
            break;
        case "authenticate":
            handleAuthenticate(request, response, session, userService);
            break;
        case "showCreateForm":
            showCreateUserForm(request, response);
            break;
        case "create":
            handleCreateUser(request, response, userService);
            break;
        case "showFindForm":
            showFindForm(request, response, session, userService);
            break;
        case "search":
            handleSearch(request, response, session, userService);
            break;
        case "update":
            handleUpdateUser(request, response, session, userService);
            break;
        case "delete":
            handleDeleteUser(request, response, session, userService);
            break;
        case "deletefl":
            handleDeleteUserFromList(request, response, session, userService);
            break;
        case "listAll":
            handleListAllUsers(request, response, userService);
            break;
        case "logout":
            handleLogout(request, response, session);
            break;
        default:
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            break;
%>

<%!
    // Metodo para mostrar el formulario de login
    private void handleLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {
        session.invalidate(); // Cerramos la sesión existente
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/login.jsp");
    }

    // Metodo para autenticar el usuario
    private void handleAuthenticate(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        try {
            User loggedInUser = userService.loginUser(email, password);
            session.setAttribute("loggedInUser", loggedInUser); // Guardamos el usuario en la sesi'n 
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/login.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos. Intentelo de nuevo.");
            request.getRequestDispatcher("/Views/Forms/Users/login.jsp").forward(request, response);
        }
    }

    // Mostrar el formulario para crear un usuario
    private void showCreateUserForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/create.jsp");
    }

    // M'todo para crear un nuevo usuario (despu's de enviar el formulario)
    private void handleCreateUser(HttpServletRequest request, HttpServletResponse response, UserService userService) throws ServletException, IOException {
        String code = request.getParameter("id");
        int id = Integer.parseInt("code");
        String password = request.getParameter("password");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String rol = request.getParameter("rol");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String estado = request.getParameter("estado");
        String fechaRegistro = request.getParameter("fechaRegistro");

        try {
            userService.createUser(id, password, nombre, apellido, rol, email, telefono, estado, fechaRegistro);
            request.setAttribute("successMessage", "Usuario creado exitosamente.");
            handleListAllUsers(request, response, userService);
        } catch (DuplicateUserException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/create.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos. Intentelo de nuevo.");
            request.getRequestDispatcher("/Views/Forms/Users/create.jsp").forward(request, response);
        }
    }

    // Mostrar el formulario para editar un usuario
    private void showFindForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService) throws ServletException, IOException {
        request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
    }

    // Metodo para buscar un usuario
    private void handleSearch(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService) throws ServletException, IOException {
        String searchCode = request.getParameter("id");
        try {
            User user = userService.getUserByCode(Integer.parseInt(searchCode));
            session.setAttribute("searchedUser", user); // Guardamos el usuario en la sesión
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (UserNotFoundException e) {
            session.removeAttribute("searchedUser"); // Limpiamos la sesión si no se encuentra el usuario request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        }
    }

    // Mostrar el formulario para editar un usuario
    private void showEditUserForm(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService) throws ServletException, IOException {
        String code = request.getParameter("id");
        try {
            User user = userService.getUserByCode(Integer.parseInt(code));
            session.setAttribute("userToEdit", user); // Guardamos el usuario en sesi'n 
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
        }
    }

    // Metodo para actualizar los datos del usuario
    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService) throws ServletException, IOException {
        User searchedUser = (User) session.getAttribute("searchedUser");
        if (searchedUser == null) {
        }
        request.setAttribute("errorMessage", "Primero debe buscar un usuario para editar.");
        request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        return;
        //Usamos el codigo del usuario buscad
        
        int id = searchedUser.getId();

        String password = request.getParameter("password");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String rol = request.getParameter("rol");
        String email = request.getParameter("email");
        String telefono = request.getParameter("telefono");
        String estado = request.getParameter("estado");
        String fechaRegistro = request.getParameter("fechaRegistro");
        try {
            userService.updateUser(id, password, nombre, apellido, rol, email, telefono, estado, fechaRegistro);
            request.setAttribute("successMessage", "Usuario actualizado exitosamente.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        }
    }

    private void handleDeleteUserFromList(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService) throws ServletException, IOException {
        String code = request.getParameter("id");
        if (code == null || code.trim().isEmpty()) {
            request.setAttribute("errorMessage", "El codigo es requerido");
            request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
            return;
        }
        try {
            userService.deleteUser(Integer.parseInt(code));
            session.removeAttribute("searchedUser");
            request.setAttribute("successMessage", "Usuario eliminado exitosamente.");
            handleListAllUsers(request, response, userService);
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            handleListAllUsers(request, response, userService);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            handleListAllUsers(request, response, userService);
        }
    }

    // Metodo para eliminar un usuario
    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response, HttpSession session, UserService userService) throws ServletException, IOException {
        User searchedUser = (User) session.getAttribute("searchedUser");
        if (searchedUser == null) {
        }
        request.setAttribute("errorMessage", "Primero debe buscar un usuario para eliminar.");
        request.getRequestDispatcher("/views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        return;

        int id = searchedUser.getId();

        // Usamos el codigo del usuario buscado
        try {
            userService.deleteUser(id);
            session.removeAttribute("searchedUser");
            request.setAttribute("successMessage", "Usuario eliminado exitosamente.");
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (UserNotFoundException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/Views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos.");
            request.getRequestDispatcher("/views/Forms/Users/find_edit_delete.jsp").forward(request, response);
        }
    }

    // Metodo para listar todos los usuarios
    private void handleListAllUsers(HttpServletRequest request, HttpServletResponse response, UserService userService) throws ServletException, IOException {
        try {
            List<User> users = userService.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/Views/Forms/Users/list_all.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error de base de datos al listar usuarios.");
            request.getRequestDispatcher("/views/Forms/Users/list_all.jsp").forward(request, response);
        }
    }

    // Metodo para cerrar sesion
    private void handleLogout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        session.invalidate(); // Invalida la sesion actual
        response.sendRedirect(request.getContextPath() + "/Views/Forms/Users/login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
