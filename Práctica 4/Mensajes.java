class Mensajes {
    public double distanciaPuntos;
    int x1;
    int x2;
    int y1;
    int y2;
    
    public String mensaje() {
        return "La distancia entre los puntos " + "(" + x1 + ", " + y1 + ")" + " y " + "(" + x2 + ", " + y2 + ") " + "es: " + distanciaPuntos;
    }       
}