//Empaquetado
package Reto;

import javax.swing.*;

public class MainApp {

    //Variable boolean para controlar si después de un resultado se debe limpiar la pantalla
    //esta fuera del main para que sea "global" y nos deje usarla sin crear un objeto MainApp
    static boolean limpiarPantalla = false;

    public static void main(String[] args) {
        // Sin excepciones; SwingUtilities no requiere try/catch
        SwingUtilities.invokeLater(() -> {

            //Crea un objeto tipo Vista = Una ventana nueva con nombre Calculadora
            Vista vista = new Vista("Calculadora");

            //Crea un objeto Calculadora para hacer las operaciones
            Calculadora calc = new Calculadora();

            //Inicializa la pantalla en 0
            vista.getPantalla().setText("0");

            //Recorre todos los botones de la calculadora esperando que se pulse alguno
            for (JButton b : vista.getBotones()) {
                //El ActionListener es el que espera que se haga click en algún botón
                //Una vez se pulse el botón, haz...
                b.addActionListener(e -> {

                    //Extrae el valor que se encuentra en el botón
                    //Si se pulsa 5, se extrae 5. Si se pulsa /, se extrae el /.
                    String txt = b.getText();

                    //Se extrae lo que se ve en pantalla en el momento
                    String actual = vista.getPantalla().getText();

                    //Switch dependiendo que se extrajo
                    switch (txt) { 
                        //Si es C, se limpia la pantalla. Es decir, se coloca en 0
                        case "C":
                            vista.getPantalla().setText("0");
                            limpiarPantalla = false;
                            break;
                        //Para cualquiera de los casos: +, -, *, /, se hace...
                        case "+":
                        case "-":
                        case "*":
                        case "/":
                            //Lo que hay en pantalla, el número que ingresamos y que extraemos con actual, lo manda al objeto calc
                            //para que guarde el primer miembro de la operación
                            calc.setNum1(Double.parseDouble(actual));

                            //La operación que ingresamos (+, -, *, /) la manda al Setter de la calc.
                            calc.setOperacion(txt);

                            //Limpiamos la pantalla para que el usuario ingrese el segundo miembro de la operación
                            vista.getPantalla().setText("0");
                            limpiarPantalla = false;
                            break;
                        //Si es =...
                        case "=":
                            //Se extrae el segundo miembro de la operación
                            calc.setNum2(Double.parseDouble(actual));

                            //Declara y asigna el valor del resultado a res
                            double res = calc.calcular();

                            //La calculadora detecta cuando el resultado no existe (división entre 0)
                            //Para esto, en la clase Calculadora, al momento de dividir se corroborá
                            //Si se divide entre 0, la calculadora devuelve el valor máximo de double, un valor imposible de obtener
                            //en condiciones normales. Cuando al pulsar =, se detecta que el resultado es el valor máximo de double
                            //salta el mítico mensaje de "Syntax Error"
                            if (res == Double.MAX_VALUE) {
                                vista.getPantalla().setText("Syntax Error");
                                limpiarPantalla = true;
                            
                            //Si no se está dividiendo entre 0, se devuelve el resultado en pantalla
                            } else {
                                vista.getPantalla().setText(String.valueOf(res));
                                limpiarPantalla = true; // activa bandera
                            }
                            break;
                        //Si no suceden los casos anteriores, significa que estamos ingresando un valor número 0-9
                        default:
                            //Extrae el valor de la pantalla, si era un 0 (es decir, la pantalla estaba limpia) o es Syntax Error, o la bandera 
                            //limpiarpantalla esta en true (lo último que nos dio la calculadora es un resultado),
                            //no agrega ese cero y resetea la pantalla. Esto evita ceros antes de números, después de un resultado, o de un error
                            if (actual.equals("0") || actual.equals("Syntax Error") || limpiarPantalla) {
                                vista.getPantalla().setText(txt);
                                limpiarPantalla = false; // resetea la bandera (false)
                            } else {
                                //Concatena el número presionado
                                vista.getPantalla().setText(actual + txt);
                            }
                            break;
                    }
                });
            }

            //Marca la vista como visible (salta la ventana)
            vista.setVisible(true);
        });
    }
}
