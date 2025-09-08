public class Token3 {
    public static void main(String [] args) {
        System.out.print("La solución a la ecuacion de segundo grado: ");
        System.out.println(args[0]+"x^2 + "+args[1]+"x + "+args[2]);
        double a = Double.parseDouble(args[0]);
        double b = Double.parseDouble(args[1]);
        double c = Double.parseDouble(args[2]);

        double zero1 = 0, zero2 = 0;
        double discriminante = b*b-4*a*c;
        if (discriminante < 0) {
            discriminante *= -1;
            double re = -b/(2*a);
            double im = root(discriminante)/(2*a);
            System.out.println("x1 = "+ re + "+" + im + "i");
            System.out.println("x2 = "+ re + "-" + im + "i");
        } else {
            zero1 = (-b + root(discriminante))/(2*a);
            zero2 = (-b - root(discriminante))/(2*a);
            System.out.println("x1 = "+ zero1);
            System.out.println("x2 = "+ zero2);
        }
    }
    
    public static double root(double arg){
        double newroot = arg/2;
        for (int i = 0; i < 5; i++) {
            if(newroot == 0){
                return 0;
            }
            newroot = 0.5*(newroot + arg/newroot);
        }
        return newroot;
    }
}