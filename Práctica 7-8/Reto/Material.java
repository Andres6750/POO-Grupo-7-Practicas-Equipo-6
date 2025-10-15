package Reto;

public abstract class Material {
    //Atributos
    private String titulo;
    private String autor;
    private int anio;

    //Getters
    public String getTitulo() {
        return titulo;
    }

    public String getAutor() {
        return autor;
    }

    public int getAnio() {
        return anio;    
    }

    //Setters
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public void setAnio(int anio) {
        this.anio = anio;
    }

    //Constructores (uno vacío y otro completo)

    //Constructor
    public Material() {
    }

    public Material(String titulo, String autor, int anio) {
        this.titulo = titulo;
        this.autor = autor;
        this.anio = anio;
    }

    //Método mostrarInformación
    public abstract void mostrarInformacion();
}