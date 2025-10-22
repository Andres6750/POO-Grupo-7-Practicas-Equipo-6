public class MainApp {
    public static void main(String[] args) {
        Empleado e1;

        System.out.println("Empleado 1");

        //Lo definimos como Empleado Asalariado

        e1 = new EmpleadoAsalariado("Alan", "Gael", 1001, 1000);

        System.out.println(e1.toString());

        //Lo sobreescribimos (polimorfismo)

        e1 = new EmpleadoPorHoras("Oswaldo", "Santos", 1002, 2000, 60);

        System.out.println(e1.toString());
    }
}
