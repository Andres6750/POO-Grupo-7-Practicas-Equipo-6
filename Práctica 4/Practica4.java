import javax.swing.*;
import java.awt.event.*;

class Mensajes {
    public String mensaje() {
        return "Hola! tengo vida! c:";
    }   
}

class Ventana extends JFrame {
    JButton boton;
    Mensajes controlador;

    public Ventana(Mensajes controlador) {
        this.controlador = controlador;

        setTitle("Ejemplo");
        setSize(300, 200);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        boton = new JButton("Haz clic aqui");
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
        Mensajes controlador = new Mensajes();

        Ventana ventana = new Ventana(controlador);
        ventana.setVisible(true);
    }
}
