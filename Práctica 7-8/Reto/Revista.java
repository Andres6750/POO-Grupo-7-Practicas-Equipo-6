package Reto;

public class Revista extends Material{
    @Override
    public void mostrarInformacion() {
    System.out.println("📘 LIBRO");
    System.out.println("Título: " + getTitulo());
    System.out.println("Autor: " + getAutor());
    System.out.println("Año: " + getAnio());
}

}
