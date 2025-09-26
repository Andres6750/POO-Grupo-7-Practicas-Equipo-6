package Reto;

import java.awt.event.*;

public class BotonListener implements ActionListener {
    private CalculadoraGUI gui;
    private String texto;

    public BotonListener(CalculadoraGUI gui, String texto) {
        this.gui = gui;
        this.texto = texto;
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (texto.matches("[0-9]")) { 
            if (gui.isNuevaOperacion()) {
                gui.getPantalla().setText(texto);
                gui.setNuevaOperacion(false);
            } else {
                gui.getPantalla().setText(gui.getPantalla().getText() + texto);
            }
        } else if (texto.equals("Borrar")) {
            gui.getPantalla().setText("0");
            gui.setNuevaOperacion(true);
        } else if (texto.equals("=")) {
            gui.getCalculadora().setNum2(Double.parseDouble(gui.getPantalla().getText()));
            double resultado = gui.getCalculadora().calcular();
            gui.getPantalla().setText("" + resultado);
            gui.setValorActual(resultado);
            gui.setNuevaOperacion(true);
        } else { 
            gui.getCalculadora().setNum1(Double.parseDouble(gui.getPantalla().getText()));
            gui.getCalculadora().setOperacion(texto);
            gui.setNuevaOperacion(true);
        }
    }
}
