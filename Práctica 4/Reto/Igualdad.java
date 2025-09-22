public class Igualdad {
    static final double tolerancia = 0.1;
     public static boolean comparar(double distancia1, double distancia2, double distancia3) {
        
        double d1Redondeado = Math.round(distancia1 * 10.0) / 10.0;
        double d2Redondeado = Math.round(distancia2 * 10.0) / 10.0;
        double d3Redondeado = Math.round(distancia3 * 10.0) / 10.0;

        return (d1Redondeado == d2Redondeado) && (d2Redondeado == d3Redondeado);
    }
}
