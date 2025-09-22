public class Punto {
    double x;
    double y;
    
    public Punto(double x, double y){
        this.x = x;
        this.y = y;
    }

    public double distancia(Punto apoyo){
        return Math.hypot(apoyo.x - this.x, apoyo.y - this.y);
    }

    public String toString(){
        return "(" + x + "," + y + ")";
    }
}
