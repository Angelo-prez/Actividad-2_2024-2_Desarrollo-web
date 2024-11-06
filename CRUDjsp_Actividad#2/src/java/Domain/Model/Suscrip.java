/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Domain.Model;

/**
 *
 * @author Gustavo Ortega
 */
public class Suscrip {

    private int id;
    private String tipo;
    private float costo;
    private int duracion;
    private String fechaInicio;
    private int usuarioId;

    public Suscrip() {
    }

    public Suscrip(int id, String tipo, float costo, int duracion, String fechaInicio, int usuarioId) {
        this.id = id;
        this.tipo = tipo;
        this.costo = costo;
        this.duracion = duracion;
        this.fechaInicio = fechaInicio;
        this.usuarioId = usuarioId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public float getCosto() {
        return costo;
    }

    public void setCosto(float costo) {
        this.costo = costo;
    }

    public int getDuracion() {
        return duracion;
    }

    public void setDuracion(int duracion) {
        this.duracion = duracion;
    }

    public String getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(String fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public int getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }

}
