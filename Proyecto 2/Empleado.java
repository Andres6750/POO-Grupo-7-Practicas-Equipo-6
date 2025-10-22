public abstract class Empleado {
    private String nombre = "";
    private String aPaterno = "";
    private int nss = 0;

    //Setters

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setaPaterno(String aPaterno) {
        this.aPaterno = aPaterno;
    }

    public void setNss(int nss) {
        this.nss = nss;
    }

    //Getters

    public String getaPaterno() {
        return aPaterno;
    }

    public String getNombre() {
        return nombre;
    }

    public int getNss() {
        return nss;
    }

    //Constructores

    public Empleado (){

    }

    public Empleado (String nombre, String aPaterno, int nss){
        setNombre(nombre);
        setaPaterno(aPaterno);
        setNss(nss);
    }

    public String toString(){
        return "----Empleado----\nNombre: " + getNombre() + "\n Apellido Paterno: " + getaPaterno() + "\nNSS: " + getNss();
    }
    
    public abstract double ingresos();

}
