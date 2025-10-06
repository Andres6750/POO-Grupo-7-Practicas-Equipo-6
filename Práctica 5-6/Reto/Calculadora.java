//Empaquetado
package Reto;

//Clase calculadora
public class Calculadora {
    //Atributos encapsulados
    //Primer miembro de la operación
    private double num1;
    //Segundo miembro de la operación
    private double num2;
    //Operación a realizar (+,-,*,/)
    private String operacion;

    //Getters
    //Solo usamos este, pero por convención se hacen los demás
    public String getOperacion() {
        return operacion;
    }

    public double getNum1() {
        return num1;
    }

    public double getNum2() {
        return num2;
    }

    //Setters
    public void setNum1(double num1){ 
        this.num1 = num1; 
    }

    public void setNum2(double num2){ 
        this.num2 = num2; 
    }

    public void setOperacion(String operacion){ 
        this.operacion = operacion; 
    }

    //Corazón de la calculadora
    public double calcular() {
        //Switch en base a operación
        switch (operacion) {
            case "+": return num1 + num2;
            case "-": return num1 - num2;
            case "*": return num1 * num2;
            case "/":
                if (num2 != 0) return num1 / num2;
                else {;
                    return Double.MAX_VALUE; //Valor arbitrario para marcar un error (división entre 0)
                }
            default: return 0;
        }
    }
}
