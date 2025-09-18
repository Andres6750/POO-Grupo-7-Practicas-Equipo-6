import javax.swing.*;
import java.awt.event.*;

public class Ventana extends JFrame {

    JButton boton;
    Mensaje controlador;

    public Ventana(Mensaje controlador){
        this.controlador = controlador;

        setTitle("Triangulo equilatero");
        setSize(400, 200);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        boton = new JButton("Haga clic para ver si el triangulo es equilatero");
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
