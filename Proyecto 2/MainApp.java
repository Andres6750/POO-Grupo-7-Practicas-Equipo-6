public class MainApp {
    public static void main(String[] args) {
        Empleado e1;

        //Lo definimos como Empleado Asalariado

        e1 = new EmpleadoAsalariado("Alan", "Gael", 1001, 1000);

        e1.toString();

        //Lo sobreescribimos (polimorfismo)

        e1 = new EmpleadoPorHoras("Oswaldo", "Santos", 1002, 2000, 60);

        e1.toString();
    }
}
