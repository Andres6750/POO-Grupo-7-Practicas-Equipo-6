public class Mensaje {
    public boolean Equilatero;
    public Punto p1, p2, p3;
    public double distancia1, distancia2, distancia3;

    public Mensaje(boolean Equilatero, Punto p1, Punto p2, Punto p3, double distancia1, double distancia2, double distancia3){
        this.Equilatero = Equilatero;
        this.p1 = p1;
        this.p2 = p2;
        this.p3 = p3;
        this.distancia1 = distancia1;
        this.distancia2 = distancia2;
        this.distancia3 = distancia3;
    }
    
    public String mensaje(){
        String mensaje = "Puntos: \n";
        mensaje += "P1: " + p1 + "\n";
        mensaje += "P2: " + p2 + "\n";
        mensaje += "P3: " + p3 + "\n\n";
        mensaje += "Distancias: \n";
        mensaje += "Distancia entre P1 y P2: " + distancia1 + "\n";
        mensaje += "Distancia entre P2 y P3: " + distancia2 + "\n";
        mensaje += "Distancia entre P1 y P3: " + distancia3 + "\n\n";
        
        if(Equilatero){
            mensaje += "El triangulo es equilatero";
        } else {
            mensaje += "El triangulo no es equilatero";
        }
        return mensaje;
    }
}
