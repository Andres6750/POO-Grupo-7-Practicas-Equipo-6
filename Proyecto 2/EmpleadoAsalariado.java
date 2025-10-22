public class EmpleadoAsalariado extends Empleado {
    private double salarioSemanal = 0;

    public EmpleadoAsalariado(String nombre, String aPaterno, int nss, double salarioSemanal){
        super (nombre, aPaterno, nss);
        setSalarioSemanal(salarioSemanal);
    }

    //Getter
    public double getSalarioSemanal() {
        return salarioSemanal;
    }

    //Setter
    public void setSalarioSemanal(double salarioSemanal) {
        //Condición para que no exista salario < 0
        if (salarioSemanal >= 0){
            this.salarioSemanal = salarioSemanal;
        }
        
        else {
            System.out.println("Salario inválido");
        }
    }

    //Sobreescribir ingresos

     @Override
     public double ingresos(double salarioSemanal){
        double ingresos;
        ingresos = salarioSemanal;

        return ingresos;
     }

     @Override
     public String toString(){
        return "----Empleado Asalariado----\nNombre: " + getNombre() + "\n Apellido Paterno: " + getaPaterno() + "\nNSS: " + getNss() + "\n Ingresos: " + ingresos(getSalarioSemanal());
    }
}
