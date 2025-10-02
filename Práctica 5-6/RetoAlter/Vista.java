//Empaquetado
package RetoAlter;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;
import javax.swing.*;

//Extiende la clase JFrame (hereda sus propiedades)
public class Vista extends JFrame {
    //Atributos encapsulados de la clase Vista
    //Pantalla que mostrará los números (display)
    private final JTextField pantalla;

    //Pad númerico para ingresar números
    //Se declara un panel de fondo para mostrar los números
    private final JPanel padNumerico;
    //Convierte los paneles en botones
    private final JButton[] botones;

    //Constructor de la clase Vista (recibe el titulo de la ventana)
    public Vista(String titulo) {
        super(titulo); //Herencia

        //Inicialización de la pantalla ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

        //Inicializa la pantalla en 0
        pantalla = new JTextField("0");

        //Es un textField (muestra o permite ingresar datos). Lo cambiamos a que no se pueda editar clickeando sobre él.
        //Solo funciona como pantalla
        pantalla.setEditable(false);

        //Añade el JTextField a la vista en el "norte" (arriba del todo)
        add(pantalla, BorderLayout.NORTH);

        //Inicialización del pad numérico ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

        // Panel de etiquetas (en una grilla de 4 filas, 4 columnas, 5px y 5px de márgen entre los elementos)
        padNumerico = new JPanel(new GridLayout(4, 4, 5, 5));
        String[] etiquetas = {
            "7","8","9","/",
            "4","5","6","*",
            "1","2","3","-",
            "0","C","=","+"
        };

        //Asigna un botón a cada etiqueta
        //Crea un arreglo de botones con las respectivas etiquetas
        //Hacerlo de esta forma permite agregar nuevos botones y no revolvernos con 19 botones distintos.
        botones = new JButton[etiquetas.length];
        for (int i = 0; i < etiquetas.length; i++) {
            botones[i] = new JButton(etiquetas[i]);
            padNumerico.add(botones[i]);
        }

        //Añade el pad en el centro de la vista
        add(padNumerico, BorderLayout.CENTER);

        //Configuración de la vista ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        
        //Permite que se cierre la ventana al dar click en la X de cerrar
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        //Dimensión de la ventana
        setPreferredSize(new Dimension(300, 400));

        //Método de Swing para que ajuste todo lo de dentro a la dimensión
        pack();

        //Centra la ventana en la pantalla
        setLocationRelativeTo(null);
    }

    //Getters para uso del MainApp
    public JTextField getPantalla() { return pantalla; }
    public JButton[] getBotones() { return botones; }
}
