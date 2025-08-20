import java.util.Scanner;

public class Menu{
    public static void main(String[] args) {

        Scanner inp = new Scanner(System.in);
        int option, n; //Varibles para escojer la opción en el menú y el número a procesar

        System.out.println("Bienvenido usuario");
        do {
            System.out.println("1.- Factorial de un número");
            System.out.println("2.- Serie de Fibonacci");
            System.out.println("3.- Conjetura de Collatz");
            System.out.println("4.- Salir");
            System.out.println("Por favor ingrese una de las opciones mencionadas");
            option = inp.nextInt();

            if (option > 4) {
                System.out.println("Opcion no valida"); //Mensaje en caso de opción no valida
            }else{

                switch (option) { // Menú de opciones
                    case 1:
                        System.out.println("Ingrese el número del que desea conocer el factorial:");
                        n = inp.nextInt();
                        System.out.println("El factorial de "+ n +" es: "+ FactorialR(n));
                        break;
                    case 2:
                        System.out.println("Ingrese el número de terminos de la sucesión de Fibonacci:");
                        n = inp.nextInt();
                        System.out.println("La sucesión de Fibonacci hasta "+ n +" es:");
                        Fibonacci(n);
                        break;
                    case 3:
                        System.out.println("Ingrese el número desde que iniciara la sucesión:");
                        n = inp.nextInt();
                        System.out.println("La sucesión generada es la siguiente:");
                        Collatz(n);
                        break;               
                    default:
                        break;
                }
                System.out.println("");
            }

        } while (option != 4);  
    }

    public static int FactorialR(int n){ //Método para la operación del Factorial
        if(n == 0) {
            return 1; // Caso base
        }else {
            return n * FactorialR(n-1); // Caso recursivo
        }
    }

    public static void Fibonacci(int n) { //Método para la serie de Fibonacci
        int ant = 0, fib = 1;
        for(int i = 0; i < n; i++) {
            System.out.print(fib + "->");
            int aux = fib;
            fib += ant;
            ant = aux;
        }
        System.out.println("Fin."); // Indica que la sucesión termino
  
    }

    public static void Collatz(int n) { //Método para la conjetura de Collatz
        while(n != 1){
            System.out.print(n + "->"); //Verifica que la sucesión no entre en un bucle infinito 
            if(n%2 == 0) { //Condición para pares
                n /= 2;
            }else { // Condición para impares
                n = 3*n + 1;
            }       
        }
        System.out.print(1); //Imprime el número donde termina la sucesión
    }
}