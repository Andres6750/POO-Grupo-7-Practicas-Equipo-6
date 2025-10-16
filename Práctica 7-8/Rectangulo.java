package mx.unam.fi.poo.p78;

import java.awt.Dimension;
import java.awt.Graphics2D;

public class Rectangulo extends Figura{
    private double alto, ancho;

    //Constructores

    public Rectangulo (double ancho, double alto){
            setAlto(alto);
            setAncho(ancho);
    }

    //Getters y Setters

    public double getAlto() {
        return alto;
    }

    public void setAlto(double alto) {
        this.alto = alto;
    }


    public double getAncho() {
        return ancho;
    }

    public void setAncho(double ancho) {
        this.ancho = ancho;
    }

    //Sobreescribiendo los métodos abstractos de Figura

    @Override 
    public double area(){
        return getAlto() * getAncho();
    }

    @Override 
    public double perimetro(){
        return (2*getAlto()) + (2*getAncho());
    }

    @Override
    public void dibujar(Graphics2D g, Dimension size) {
        double margen = 20;
        double maxW = size.width - 2 * margen;
        double maxH = size.height - 2 * margen;

        double escalaW = maxW / Math.max(getAncho(), 1.0);
        double escalaH = maxH / Math.max(getAlto(), 1.0);
        double escala = Math.min(escalaW, escalaH);

        int w = (int) Math.round(getAncho() * escala);
        int h = (int) Math.round(getAlto() * escala);
        int x = (size.width - w) / 2;
        int y = (size.height - h) / 2;

        g.drawRect(x, y, w, h);
    }
}
