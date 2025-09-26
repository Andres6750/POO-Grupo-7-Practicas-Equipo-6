package Reto;

import javax.swing.*;
import java.awt.*;

public class CalculadoraGUI extends JFrame {
    private JTextField pantalla;
    private Calculadora calculadora;
    private double valorActual = 0;
    private boolean nuevaOperacion = true;

    public CalculadoraGUI() {
        calculadora = new Calculadora();

        setTitle("Calculadora Gráfica");
        setSize(300, 400);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        pantalla = new JTextField("0");
        pantalla.setEditable(false);
        add(pantalla, BorderLayout.NORTH);

        JPanel panelBotones = new JPanel(new GridLayout(4,4));
        String[] botones = {
            "7","8","9","/",
            "4","5","6","*",
            "1","2","3","-",
            "0","C","=","+"
        };

        for (String texto : botones) {
            JButton boton = new JButton(texto);
            boton.addActionListener(new BotonListener(this, texto));
            panelBotones.add(boton);
        }

        add(panelBotones, BorderLayout.CENTER);
        setVisible(true);
    }

    // Getters y Setters públicos para acceso controlado
    public JTextField getPantalla() {
        return pantalla;
    }

    public Calculadora getCalculadora() {
        return calculadora;
    }

    public double getValorActual() {
        return valorActual;
    }

    public void setValorActual(double valorActual) {
        this.valorActual = valorActual;
    }

    public boolean isNuevaOperacion() {
        return nuevaOperacion;
    }

    public void setNuevaOperacion(boolean nuevaOperacion) {
        this.nuevaOperacion = nuevaOperacion;
    }
}
