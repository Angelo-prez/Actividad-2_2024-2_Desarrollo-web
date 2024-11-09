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
import Domain.Model.Suscrip;
import Infrastructure.Database.ConnectionDbMysql;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SuscripCRUD {

    // Método para obtener todos las suscripciones de la tabla suscripcion de la base datos en una lista. 
    public List<Suscrip> getAllSuscrip() {
        List<Suscrip> suscripList = new ArrayList<>();
        String query = "SELECT * FROM suscripcion";
        try {
            Connection con = ConnectionDbMysql.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                suscripList.add(
                        new Suscrip(
                                rs.getInt("id"),
                                rs.getString("tipo"),
                                rs.getFloat("costo"),
                                rs.getInt("duracion"),
                                rs.getString("fechaInicio"),
                                rs.getInt("usuarioId"))
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suscripList;
    }

    // Método para agregar un nuevo registro en la tabla Usuario
    public void addSuscrip(Suscrip suscrip) throws SQLException, DuplicateUserException {
        String query = "INSERT INTO suscripcion (id , tipo, costo, duracion, fecha_inicio, usuario_id) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = ConnectionDbMysql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, suscrip.getId());
            stmt.setString(2, suscrip.getTipo());
            stmt.setFloat(3, suscrip.getCosto());
            stmt.setInt(4, suscrip.getDuracion());
            stmt.setString(5, suscrip.getFechaInicio());
            stmt.setInt(6, suscrip.getUsuarioId());
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

    // Método para actualizar los campos de la tabla suscripcion
    public void updateSuscrip(Suscrip suscrip) throws SQLException, UserNotFoundException {
        String query = "UPDATE suscripcion SET tipo=?, costo=?, duracion=?, fecha_inicio=?, WHERE id=?";
        try (Connection con = ConnectionDbMysql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, suscrip.getTipo());
            stmt.setFloat(2, suscrip.getCosto());
            stmt.setInt(3, suscrip.getDuracion());
            stmt.setString(4, suscrip.getFechaInicio());
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
            }
            throw new UserNotFoundException("El usuario con el código " + suscrip.getId() + " no existe.");
        } catch (SQLException e) {

            throw e; // Propagamos la excepción SQLException para que la maneje el servicio
        }
    }

    // Método para eliminar un registro de la tabla suscripcion por id
    public void deleteSuscrip(int id) throws SQLException, UserNotFoundException {
        String query = "DELETE FROM suscripcion WHERE id=?";
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

    // Método para obtener un registro suscripcion por id.
    public Suscrip getSuscripByCode(int id) throws SQLException, UserNotFoundException {
        String query = "SELECT * FROM suscripcion WHERE id=?";
        Suscrip suscrip = null;
        try (Connection con = ConnectionDbMysql.getConnection(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                suscrip = new Suscrip(rs.getInt("id"),
                        rs.getString("tipo"),
                        rs.getFloat("costo"),
                        rs.getInt("duracion"),
                        rs.getString("fechaInicio"),
                        rs.getInt("usuarioId"));
            } else {
                throw new UserNotFoundException("El usuario con el código" + id + " no existe.");
            }
        } catch (SQLException e) {
            throw e; // Propagamos la excepción SQLException para que la maneje el servicio
        }
        return suscrip;
    }

    // Método para buscar una suscripcion por id o por la id del usuario
    public List<Suscrip> searchUsers(String searchTerm) {
        List<Suscrip> suscripList = new ArrayList<>();
        String query = "SELECT * FROM suscripcion WHERE id LIKE? OR usuario_id  LIKE ?";
        try {
            Connection con = ConnectionDbMysql.getConnection();
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, "%" + searchTerm + "%");
            stmt.setString(2, "%" + searchTerm + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                suscripList.add(
                        new Suscrip(rs.getInt("id"),
                                rs.getString("tipo"),
                                rs.getFloat("costo"),
                                rs.getInt("duracion"),
                                rs.getString("fechaInicio"),
                                rs.getInt("usuarioId")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suscripList;
    }

}
