public class EmpleadoPorHoras extends Empleado {
    private double salario = 0;
    private int horas = 0;

    public EmpleadoPorHoras(String nombre, String aPaterno, int nss, double salario, int horas){
        super (nombre, aPaterno, nss);
        setSalario(salario);
        setHoras(horas);
    }

    //Getters
    public double getSalario() {
        return salario;
    }

    public int getHoras() {
        return horas;
    }

    //Setter
    public void setSalario(double salario) {
        //Condición para que no exista salario < 0
        if (salario >= 0){
            this.salario = salario;
        }
        
        else {
            System.out.println("Salario inválido");
        }
    }

    public void setHoras(int horas) {
        //Condición para que las horas sean mayor que cero y menos que 180
        if (horas > 0 && horas <= 180){
            this.horas = horas;
        }
        else {
            System.out.println("Horas inválidas");
        }
    }

    //Sobreescribir ingresos

     @Override
     public double ingresos(){
        salario = getSalario();
        horas = getHoras();

        double salarioFinal = 0;

        int horasE;
        if (horas <= 40){
            salarioFinal += (salario * horas);
        }

        else {
            horasE = horas - 40;

            salarioFinal += (salario * 40);
            salarioFinal += (salario * horasE * 2);
        }

        return salarioFinal;
     }

     @Override
     public String toString(){
        return "----Empleado Por Horas----\nNombre: " + getNombre() + "\n Apellido Paterno: " + getaPaterno() + "\nNSS: " + getNss() + "\nSalario por hora: " + getSalario() + "\n Horas trabajadas: " + getHoras() + "\n Ingresos: " + ingresos();
    }
}
