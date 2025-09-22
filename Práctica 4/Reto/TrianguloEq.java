public class TrianguloEq {
    public static void main(String[] args){

        double x1 = Double.parseDouble(args[0]);
        double y1 = Double.parseDouble(args[1]);
        double x2 = Double.parseDouble(args[2]);
        double y2 = Double.parseDouble(args[3]);
        double x3 = Double.parseDouble(args[4]);
        double y3 = Double.parseDouble(args[5]);

        Punto P1 = new Punto(x1, y1);
        Punto P2 = new Punto(x2, y2);
        Punto P3 = new Punto(x3, y3);

        double distancia1 = P1.distancia(P2);
        double distancia2 = P2.distancia(P3);
        double distancia3 = P3.distancia(P1);

        boolean Equilatero = Igualdad.comparar(distancia1, distancia2, distancia3);

        Mensaje controlador = new Mensaje(Equilatero, P1, P2, P3, distancia1, distancia2, distancia3);
        Ventana ventana = new Ventana(controlador);
        ventana.setVisible(true);
    }
}
