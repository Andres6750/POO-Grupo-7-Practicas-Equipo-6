import java.util.Scanner;

public class PascalMatricial{
    public static void main(String[] args) {
        Scanner e = new Scanner(System.in);
        System.out.println("Hola usuario, este código crea el triangulo de Pascal");
        System.out.println("Ingresa el numero de filas:");
        int filas = e.nextInt();
        System.out.println("");
        System.out.println("El triangulo con " + filas + "filas es: ");
        System.out.println("");

        int[][] arreglo = new int[filas][(filas * 2) + 1];
        
        // Inicializar todo con ceros
        for (int i = 0; i < filas; i++) {
            for (int j = 0; j < (filas * 2 + 1); j++) {
                arreglo[i][j] = 0;
            }
        }
        
        arreglo[0][filas] = 1; // punta del triangulo

        for (int i = 1; i < filas; i++) {
            // Lógica para calcular los valores
            for (int k = 1; k < (filas * 2); k++) {
                if (arreglo[i-1][k-1] != 0 || arreglo[i-1][k+1] != 0) {
                    arreglo[i][k] = arreglo[i-1][k-1] + arreglo[i-1][k+1];
                }
            }
        }

        // Imprimir resultado
        for (int m = 0; m < filas; m++) {
            for (int n = 0; n < (filas * 2 + 1); n++) {
                if (arreglo[m][n] == 0) {
                    System.out.print(" ");
                } else {
                    System.out.print(arreglo[m][n]);
                }
            }
            System.out.println(""); // Siguiente fila en el triangulo
        }
    }
}