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
                        System.out.println("Ingrese el número que desea procesar");
                        n = inp.nextInt();
                        System.out.println("El factorial de "+ n +" es: "+ FactorialR(n));
                        break;
                    case 2:
                        System.out.println("Ingrese el número que desea procesar");
                        n = inp.nextInt();
                        System.out.println("La sucesión de Fibonacci hasta "+ n +" es:");
                        System.out.println(Fibonacci(n));
                        break;
                    case 3:
                        System.out.println("Ingrese el número que desea procesar");
                        n = inp.nextInt();
                        System.out.println("La sucesión generada es la siguiente:");
                        System.out.println(Collatz(n));
                        break;               
                    default:
                        break;
                }
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

    public static String Fibonacci(int n) { //Método para la serie de Fibonacci
        int ant = 0, fib = 1;
        String serie = "1"; // Declaro una cadena para mostrar la sucesión de Fibonacci
        for(int i = 0; i < n; i++) {
            int aux = fib;
            fib += ant;
            ant = aux;
            serie = serie + "->" + String.valueOf(fib); // Agrega el término a la sucesión de retorno 
        }
        return serie;   
    }

    public static String Collatz(int n) { //Método para la conjetura de Collatz
        String collatz = String.valueOf(n);
        while(n != 1){ //Verifica que la sucesión no entre en un bucle infinito 
            if(n%2 == 0) { //Condición para pares
                n /= 2;
            }else { // Condición para impares
                n = 3*n + 1;
            }       
            collatz = collatz + "->" + String.valueOf(n); // Agrega el término a la sucesión de retorno  
        }
        return collatz;
    }
}
