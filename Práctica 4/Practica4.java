import javax.swing.*;
import java.awt.event.*;
import java.math.*;
import java.util.Scanner;

class Mensajes {
    public double distanciaPuntos;
    public String mensaje() {
        return "La distancia entre los vectores es: " + distanciaPuntos + ".";
    }   
}

class Ventana extends JFrame {
    JButton boton;
    Mensajes controlador;

    public Ventana(Mensajes controlador) {
        this.controlador = controlador;

        setTitle("Distancia entre puntos");
        setSize(600, 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        boton = new JButton("Haz clic aqui para saber la distancia entre los puntos");
        boton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String mensaje = controlador.mensaje();
                JOptionPane.showMessageDialog(null, mensaje);
            }
        });

        add(boton);
    }
}

public class Practica4 {
    public static void main(String[] args) {
        Scanner inp = new Scanner(System.in);
        System.out.println("Ingresa el primer componente del primer vector (x)");
        double x1 = inp.nextDouble();
        System.out.println("Ingresa el segundo componente del primer vector (y)");
        double y1 = inp.nextDouble();
        System.out.println("Ingresa el primer componente del segundo vector (x)");
        double x2 = inp.nextDouble();
        System.out.println("Ingresa el segundo componente del segundo vector (y)");
        double y2 = inp.nextDouble();
        double distanciaPuntos = distancia(x1, y1, x2, y2);
        Mensajes controlador = new Mensajes();
        controlador.distanciaPuntos = distanciaPuntos;

        Ventana ventana = new Ventana(controlador);
        ventana.setVisible(true);
    }

    public static double distancia (double x1 , double y1 , double x2 , double y2){
        double distanciaPuntos = Math.hypot(x2 - x1, y2 - y1);
        return distanciaPuntos;
    }
}
