package Reto;

import java.util.ArrayList;
import java.util.Scanner;

public class MainApp {
    public static void main(String[] args) {
        Scanner e = new Scanner(System.in);
        ArrayList<Material> materiales = new ArrayList<>();
        String titulo, autor;
        int anio;
        int opcion;

        do {
            System.out.println("\nMENÚ DE BIBLIOTECA");
            System.out.println("1. Agregar Libro");
            System.out.println("2. Agregar Revista");
            System.out.println("3. Agregar DVD");
            System.out.println("4. Mostrar información de todos los materiales");
            System.out.println("5. Salir");
            System.out.print("Selecciona una opción: ");
            opcion = e.nextInt();

            Material material = null;

            switch (opcion) {
                case 1:
                    System.out.print("Título: ");
                    titulo = e.nextLine();
                    System.out.print("Autor: ");
                    autor = e.nextLine();
                    System.out.print("Año: ");
                    anio = e.nextInt();
                    e.nextLine();
                    material = new Libro(titulo, autor, anio);
                    break;

                case 2:
                    System.out.print("Título: ");
                    titulo = e.nextLine();
                    System.out.print("Autor: ");
                    autor = e.nextLine();
                    System.out.print("Año: ");
                    anio = e.nextInt();
                    e.nextLine();
                    material = new Revista(titulo, autor, anio);
                    break;

                case 3:
                    System.out.print("Título: ");
                    titulo = e.nextLine();
                    System.out.print("Autor: ");
                    autor = e.nextLine();
                    System.out.print("Año: ");
                    anio = e.nextInt();
                    e.nextLine();
                    material = new Dvd(titulo, autor, anio);
                    break;

                case 4:
                    System.out.println("\nMATERIALES REGISTRADOS:");
                    for (Material m : materiales) {
                        m.mostrarInformacion();
                        System.out.println("--------------------------");
                    }
                    break;

                case 5:
                    System.out.println("Saliendo...");
                    break;

                default:
                    System.out.println("Opción inválida.");
                    break;
            }

            if (material != null) {
                materiales.add(material);
                System.out.println("Material agregado correctamente\n");
            }

        } while (opcion != 5);

        e.close();
    }
}
