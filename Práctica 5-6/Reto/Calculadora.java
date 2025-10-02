package Reto;

public class Calculadora {
    private double num1;
    private double num2;
    private String operacion;

    // Getters y Setters
    public void setNum1(double num1) {
        this.num1 = num1;
    }

    public void setNum2(double num2) {
        this.num2 = num2;
    }

    public void setOperacion(String operacion) {
        this.operacion = operacion;
    }

    // Método público para el cálculo
    public double calcular() {
        switch (operacion) {
            case "+": return num1 + num2;
            case "-": return num1 - num2;
            case "*": return num1 * num2;
            case "/": 
                if (num2 != 0) return num1 / num2;
                else throw new ArithmeticException("División entre cero");
            default: return 0;
        }
    }
}
