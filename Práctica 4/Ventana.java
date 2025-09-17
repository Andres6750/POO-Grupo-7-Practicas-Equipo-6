import java.awt.event.*;
import javax.swing.*;

class Ventana extends JFrame {
    JButton boton;
    Mensajes controlador;

    public Ventana(Mensajes controlador) {
        this.controlador = controlador;

        setTitle("Distancia entre puntos");
        setSize(300, 200);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        boton = new JButton("Pulsa aqui");
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