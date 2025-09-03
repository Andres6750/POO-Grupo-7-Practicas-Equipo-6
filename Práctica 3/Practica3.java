//código de la práctica 3
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

public class Practica3 {

    public static void main(String[] args) {
        // Opcional: mal uso de argumentos en la entrada indicar uso correcto

        ArrayList<String> list = new ArrayList<String>();// Definir objeto ArrayList
        HashMap<String, String> map = new HashMap<String, String>();// Definir objeto HashMap
    
        for(int i = 0; i < args.length; i++){
            list.add(args [i]);
        }// Recorrido sobre ArrayList para agregar las entradas
        
        for(int i = 0; i < list.size(); i++){
            String code = generaHash(list.get(i));
            map.put(list.get(i), code);
        }// Mandamos las entradas a la función digestiva
        // Mandamos al HashMap las entradas donde las llaves van asociadas a cada entrada
        
        String inp = "";
        String out = "";
        for(int i = 0; i < list.size(); i++){
            inp += list.get(i) + " ";
            out += map.get(list.get(i)) + " ";
        }
        System.out.println("La encriptación relacionada a tu frase es:");
        System.out.println("Frase: "+ inp);
        System.out.println("Encriptación: "+ out);
        // Presentamos resultados con base en el HashMap
    
    }
    public static String generaHash(String texto) {
        // Variable para crear semilla a partir de la suma de los caracteres
        int semilla = 0;
        for (char c : texto.toCharArray()) {
            semilla += c;
        }

        Random random = new Random(semilla);

        //Para generar 32 caracteres hexadecimales (investigar a quien se parece)
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 32; i++) {
            int valor = random.nextInt(16); //0 - 15
            sb.append(Integer.toHexString(valor));
        }

        return sb.toString();
    }
}