package aulas.aula2;

public class Main {
    public static void main(String[] args) {
        Semaforo s1 = new Semaforo(1);
        System.out.println(s1.toString());

        s1.alerta();;
        System.out.println(s1.toString());

        s1.abre();
        System.out.println(s1.toString());
    }
}
