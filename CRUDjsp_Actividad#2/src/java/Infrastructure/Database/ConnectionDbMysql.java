/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Infrastructure.Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Gustavo Ortega
 */
public class ConnectionDbMysql {

    private static final String URL = "jdbc:mysql://localhost:3308/crud_mvc";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    private static final String DRIVER = "com.mysql.jdbc.Driver";

    //Metodo que devuelve la conexión a la base de datos.
    public static Connection getConnection() throws SQLException {
        Connection connection = null;
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(USER, URL, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("--Error-- Driver MySql no ha sido encontrado.");
        } catch (SQLException e) {
            e.printStackTrace();
            var message = "--Error-- Nose ah podido establecer la conexion hacia la base de datos.";
            throw new SQLException(message);
        }
        return connection;
    }
}
