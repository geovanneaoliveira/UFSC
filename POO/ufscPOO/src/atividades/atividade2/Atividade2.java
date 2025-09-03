package atividades.atividade2;

/*
(Prática) Usando Java, defina uma classe para armazenar os dados de robôs em um plano cartesiano de duas dimensões.
Para cada robô deverá ser armazenado o seu identificador (valor inteiro) as suas coordenadas x e y (valores reais).
Os atributos da classe devem ser privados e para acesso aos mesmos deverão ser criados métodos no padrão setter/getter.
Crie uma classe com o mét-odo main e instancie alguns objetos da classe definida.Compile e execute o programa.
 */

public class Atividade2 {
    public static void main(String[] args) {
        int id = 1;
        double coordX = 10;
        double coordY = 5;

        Robo robo1 = new Robo();
        robo1.setId(id);
        robo1.setCoordenadaX(coordX);
        robo1.setCoordenadaY(coordY);

        System.out.println(robo1.toString());

        Robo robo2 = new Robo(2, 4, 6);
        System.out.println(robo2.toString());
    }
}
