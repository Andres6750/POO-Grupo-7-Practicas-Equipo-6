package Reto;

public class Dvd extends Material{

    public Dvd(String titulo, String autor, int anio) {
        super(titulo, autor, anio);
    }

    @Override
    public void mostrarInformacion() {
    System.out.println("DVD");
    System.out.println("Título: " + getTitulo());
    System.out.println("Autor: " + getAutor());
    System.out.println("Año: " + getAnio());
    
    }
}