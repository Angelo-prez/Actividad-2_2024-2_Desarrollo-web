/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Infrastructure.Persistence;

/**
 *
 * @author Gustavo Ortega
 */
import Business.Exceptions.DuplicateUserException;
import Business.Exceptions.UserNotFoundException;
import Domain.Model.User;
import Infrastructure.Database.ConnectionDbMysql;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserCRUD {

    // Método para obtener todos los usuarios de la tabla Usuario de la base datos en una lista. 
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM usuario";
        try {
            Connection con = ConnectionDbMysql.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                userList.add(
                        new User(
                                rs.getInt("id"),
                                rs.getString("password"),
                                rs.getString("nombre"),
                                rs.getString("apellido"),
                                rs.getString("rol"),
                                rs.getString("email"),
                                rs.getString("telefono"),
                                rs.getString("estado"),
                                rs.getString("fechaRegistro"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    // Método para agregar un nuevo registro en la tabla Usuario
    public void addUser(User user) throws SQLException, DuplicateUserException {
        String query = "INSERT INTO usuario (id , password, nombre, apellidos, rol, email , telefono, estado, fecha_registro) "
                + "VALUES (?, ?, ?, ?,?, ?, ?, ?, ?)";
        try (Connection con = ConnectionDbMysql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, user.getId());
            stmt.setString(2, user.getPassword());
            stmt.setString(3, user.getNombre());
            stmt.setString(4, user.getApellido());
            stmt.setString(5, user.getRol());
            stmt.setString(6, user.getEmail());
            stmt.setString(7, user.getTelefono());
            stmt.setString(8, user.getEstado());
            stmt.setString(9, user.getFechaRegistro());
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Aquí manejamos una posible excepción de clave duplicada
            if (e.getErrorCode() == 1062) { // Código de error de clave duplicada en MySQL 
                throw new DuplicateUserException("El usuario con el código o email ya existe.");
            } else {
            }
            throw e; // Propagamos la excepción SQLException para que la maneje el servicio
        }
    }

    // Método para actualizar los campos de la tabla Usuario
    public void updateUser(User user) throws SQLException, UserNotFoundException {
        String query = "UPDATE usuario SET password=?, nombre=?, apellidos=?, rol=?, email=?, telefono=?, estado=?, fecha_registro=? WHERE id=?";
        try (Connection con = ConnectionDbMysql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, user.getPassword());
            stmt.setString(2, user.getNombre());
            stmt.setString(3, user.getApellido());
            stmt.setString(4, user.getRol());
            stmt.setString(5, user.getEmail());
            stmt.setString(6, user.getTelefono());
            stmt.setString(7, user.getEstado());
            stmt.setString(8, user.getFechaRegistro());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
            }
            throw new UserNotFoundException("El usuario con el código " + user.getId() + " no existe.");
        } catch (SQLException e) {

            throw e; // Propagamos la excepción SQLException para que la maneje el servicio
        }

    }

    // Método para eliminar un usuario
    public void deleteUser(int id) throws SQLException, UserNotFoundException {
        String query = "DELETE FROM usuario WHERE id=?";
        try (Connection con = ConnectionDbMysql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
            }
            throw new UserNotFoundException("El usuario con el código" + id + "no existe.");
        } catch (SQLException e) {
            throw e; // Propagamos la excepción SQLException para que la maneje el servicio
        }
    }

    // Método para obtener un usuario por código
    public User getUserByCode(int id) throws SQLException, UserNotFoundException {
        String query = "SELECT * FROM usuario WHERE id=?";
        User user = null;
        try (Connection con = ConnectionDbMysql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User(rs.getInt("id"),
                        rs.getString("password"),
                        rs.getString("nombre"),
                        rs.getString("apellido"),
                        rs.getString("rol"),
                        rs.getString("email"),
                        rs.getString("telefono"),
                        rs.getString("estado"),
                        rs.getString("fechaRegistro"));
            } else {
                throw new UserNotFoundException("El usuario con el código" + id + " no existe.");
            }
        } catch (SQLException e) {
            throw e; // Propagamos la excepción SQLException para que la maneje el servicio
        }
        return user;
    }

    // Método para autenticar un usuario por email y contraseña en el (Login)
    public User getUserByEmailAndPassword(String email, String password) throws UserNotFoundException {
        User user = null;
        String query = "SELECT * FROM usuario WHERE email=? AND password=?";
        try {
            Connection con = ConnectionDbMysql.getConnection();
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("id"),
                        rs.getString("password"),
                        rs.getString("nombre"),
                        rs.getString("apellido"),
                        rs.getString("rol"),
                        rs.getString("email"),
                        rs.getString("telefono"),
                        rs.getString("estado"),
                        rs.getString("fechaRegistro")
                );
            } else {
                var message = "Credenciales incorrectas. --ERROR en el correo o contraseña solicitada.";
                throw new UserNotFoundException(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // Método para obtener un usuario por email
    public User getUserByEmail(String email) throws SQLException, UserNotFoundException {
        User user = null;
        String query = "SELECT * FROM usuario WHERE email=?";
        try (Connection con = ConnectionDbMysql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("id"),
                        rs.getString("password"),
                        rs.getString("nombre"),
                        rs.getString("apellido"),
                        rs.getString("rol"),
                        rs.getString("email"),
                        rs.getString("telefono"),
                        rs.getString("estado"),
                        rs.getString("fechaRegistro")
                );
            } else {
                throw new UserNotFoundException("El usuario con el email " + email + " no existe.");
            }
            return user;
        }
    }

    // Método para buscar usuarios por nombre o email
    public List<User> searchUsers(String searchTerm) {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM usuario WHERE nombre LIKE? OR email LIKE ?";
        try {
            Connection con = ConnectionDbMysql.getConnection();
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, "%" + searchTerm + "%");
            stmt.setString(2, "%" + searchTerm + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                userList.add(
                        new User(
                                rs.getInt("id"),
                                rs.getString("password"),
                                rs.getString("nombre"),
                                rs.getString("apellido"),
                                rs.getString("rol"),
                                rs.getString("email"),
                                rs.getString("telefono"),
                                rs.getString("estado"),
                                rs.getString("fechaRegistro")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }
}
