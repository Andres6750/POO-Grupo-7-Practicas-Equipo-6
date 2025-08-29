import java.util.Scanner;

public class PascalRecursivo{
    public static void main(String[] args) {
        Scanner e= new Scanner(System.in);
        System.out.println("Hola usuario, este codigo crea el triangulo de Pascal a partir de una entrada");
        System.out.println("Ingresa el numero de filas con el que quieres que se creé el triangulo");
        int filas = e.nextInt();
        System.out.println("");
        System.out.println("El triangulo con " + filas + " filas es: ");
        System.out.println("");

        for (int i=0; i<filas;i++){ // Crea el triangulo y lo va imprimiendo 
            for (int j=0; j<filas-i;j++){ //Imprime los espacios al inicio de cada fila para darle forma al triangulo
                System.out.print(" ");
            }

            for (int k=0; k<=i; k++){ // Imprime los digitos del triangulo con un espacio para separar los terminos
                System.out.print(Pascal(i,k) + " ");

            }

            System.out.println(""); //Salto de linea para la siguiente fila del triangulo
         }

     }

     public static int Pascal(int i, int k){ //Función recursiva
        if (k==0 || k==i){ //Caso base 
            return 1;
        } else {
            return Pascal(i-1,k-1) + Pascal(i-1, k); //Obtención del digito a partir de la suma de los dos de la fila anterior
        }

    }

}
