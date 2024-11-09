/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Business.Services;

/**
 *
 * @author Gustavo Ortega
 */
import Domain.Model.User;
import Business.Exceptions.UserNotFoundException;
import Business.Exceptions.DuplicateUserException;
import Infrastructure.Persistence.UserCRUD;
import java.sql.SQLException;

import java.util.List;

public class UserService {

    private UserCRUD userCrud;

    //Metodo constructor
    public UserService() {
        this.userCrud = new UserCRUD();
    }

    // Método para obtener todos los usuarios
    public List<User> getAllUsers() throws SQLException {
        return userCrud.getAllUsers();
    }

    // Método para agregar un nuevo usuario
    public void createUser(int id, String password, String nombre, String apellido, String rol, String email, String telefono, String estado, String fechaRegistro) throws DuplicateUserException, SQLException {
        User user = new User(id, password, nombre, apellido, rol, email, telefono, estado, fechaRegistro);
        userCrud.addUser(user);
    }

    // Método para actualizar un usuario
    public void updateUser(int id, String password, String nombre, String apellido, String rol, String email, String telefono, String estado, String fechaRegistro) throws UserNotFoundException, SQLException {
        User user = new User(id, password, nombre, apellido, rol, email, telefono, estado, fechaRegistro);
        userCrud.updateUser(user);
    }

    // Método para eliminar un usuario
    public void deleteUser(int id) throws UserNotFoundException, SQLException {
        userCrud.deleteUser(id);
    }

    // Método para obtener un usuario por id de la tabla usuario
    public User getUserByCode(int id) throws UserNotFoundException, SQLException {
        return userCrud.getUserByCode(id);
    }

    // Método para autenticar un usuario (login)
    public User loginUser(String email, String password) throws UserNotFoundException, SQLException {
        // Usamos el nuevo método getUserByEmail en lugar de obtener todos los usuarios
        User user = userCrud.getUserByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        } else {
            throw new UserNotFoundException("Credenciales incorrectas.");
        }
    }

    // Método para buscar usuarios por nombre o email
    public List<User> searchUsers(String searchTerm) {
        return userCrud.searchUsers(searchTerm);
    }

}
