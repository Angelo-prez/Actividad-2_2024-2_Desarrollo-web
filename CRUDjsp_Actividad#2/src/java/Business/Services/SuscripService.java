/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Business.Services;

/**
 *
 * @author Gustavo Ortega
 */
import Domain.Model.Suscrip;
import Business.Exceptions.UserNotFoundException;
import Business.Exceptions.DuplicateUserException;
import Infrastructure.Persistence.SuscripCRUD;
import Infrastructure.Persistence.UserCRUD;
import java.sql.SQLException;

import java.util.List;

public class SuscripService {

    private SuscripCRUD suscripCrud;

    //contructor suscripcion
    public SuscripService() {
        this.suscripCrud = new SuscripCRUD();
    }

    // Método para obtener todos las suscripciones
    public List<Suscrip> getAllSuscrip() throws SQLException {
        return suscripCrud.getAllSuscrip();
    }

    // Método para agregar un nnuevo registro suscripcion
    public void createSuscrip(int id, String tipo, float costo, int duracion, String fecha_inicio, int usuario_id) throws DuplicateUserException, SQLException {
        Suscrip suscrip = new Suscrip(id, tipo, costo, duracion, fecha_inicio, usuario_id);
        suscripCrud.addSuscrip(suscrip);
    }

    // Método para actualizar un registro de suscripcion
    public void updateSuscrip(int id, String tipo, float costo, int duracion, String fecha_inicio, int usuario_id) throws UserNotFoundException, SQLException {
        Suscrip suscrip = new Suscrip(id, tipo, costo, duracion, fecha_inicio, usuario_id);
        suscripCrud.updateSuscrip(suscrip);
    }

    // Método para eliminar un registro
    public void deleteSuscrip(int id) throws UserNotFoundException, SQLException {
        suscripCrud.deleteSuscrip(id);
    }

    // Método para obtener un registro suscripcion por id de la tabla usuario
    public Suscrip getSuscripByCode(int id) throws UserNotFoundException, SQLException {
        return suscripCrud.getSuscripByCode(id);
    }

    // Método para buscar usuarios por nombre o email
    public List<Suscrip> searchSuscrip(String searchTerm) {
        return suscripCrud.searchSuscrip(searchTerm);
    }
}
