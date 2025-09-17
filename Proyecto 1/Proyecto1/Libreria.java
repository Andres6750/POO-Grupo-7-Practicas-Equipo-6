import java.util.ArrayList;

public class Libreria {

    ArrayList<Libro> libreria = new ArrayList<Libro>();

    public void agregarLibro(Libro libro){
        libreria.add(libro);
        System.out.println("Agregado.");
    }

    public void eliminarLibro(int indice){
        libreria.remove(indice);
        System.out.println("Eliminado.");
    }

    public void imprimirLibreria(){
        System.out.println("Clave | Titulo | Autor");
        for (Libro libro: libreria){
            System.out.println((libro.clave) + " | " + libro.titulo + " | " + libro.autor);
        }
    }
}
