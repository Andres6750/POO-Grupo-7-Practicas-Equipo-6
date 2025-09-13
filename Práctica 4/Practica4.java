public class Practica4{
    public static void main (String[] args){
        Punto p1 = new Punto(Integer.parseInt(args[0]), Integer.parseInt(args[1]));
        Punto p2 = new Punto(Integer.parseInt(args[2]), Integer.parseInt(args[3]));

        double distanciaPuntos = Math.hypot(p2.x - p1.x, p2.y - p1.y);

        Mensajes controlador = new Mensajes();
        controlador.distanciaPuntos = distanciaPuntos;
        controlador.x1 = p1.x;
        controlador.x2 = p1.y;
        controlador.y1 = p2.x;
        controlador.y2 = p2.y;

        Ventana ventana = new Ventana(controlador);
        ventana.setVisible(true);
    }

}
