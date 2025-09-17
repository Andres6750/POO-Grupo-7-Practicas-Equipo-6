import java.util.Scanner;

public class Proyecto {
    public static void main (String[] args){
        int clave = 0, opcion = 0, indice = 0;
        String autor, titulo;
        Scanner e = new Scanner(System.in);
        Libreria libreria = new Libreria();
        System.out.println("Bienvenido a la librería");

        do{
        System.out.println("Elige una opción");
        System.out.println("1. Ingresar libro");
        System.out.println("2. Eliminar libro");
        System.out.println("3. Imprimir librería");
        System.out.println("4. Salir");
        System.out.print("Opcion: ");
        opcion = e.nextInt();

        switch (opcion){
            case 1:
                //Ingresar libro
                System.out.print("Ingrese el titulo: ");
                titulo = e.next();
                System.out.print("Ingrese el autor: ");
                autor = e.next();

                Libro libro = new Libro(clave, titulo, autor);

                libreria.agregarLibro(libro);
                clave++;
            break;

            case 2:
                //Eliminar libro
                System.out.print("Ingrese la clave a eliminar: ");
                indice = e.nextInt();
                libreria.eliminarLibro(indice);
            break;
            
            case 3:
                libreria.imprimirLibreria();
            break;

            case 4:
                System.out.println("Saliendo...");
            break;

            default:
                    System.out.println("Elija una opcion correcta");
            break;

        }

    }while (opcion != 4);

    }
}
