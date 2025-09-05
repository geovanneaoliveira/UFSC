package atividades.atividade3.atividade33;

public class Main {
    public static void main(String[] args) {
        Data d1 = new Data(20, 7, 2028);
        Data d2 = new Data("04/09/2025");
        Data d3 = new Data(2025);

        System.out.println(d1 + " - Bissexto? " + d1.isBissexto());
        System.out.println(d2 +
                " - Dia: " + d2.getDia() +
                " - Mês numerico: " + d2.getMes() +
                " - Mês extenso: " + d2.getMesExtenso() +
                " - Ano: " + d2.getAno());
        System.out.println(d3 + " - Ano 2 dígitos: " + d3.getAno2Dig());

        Data dClone = d1.clone();
        System.out.println("Clone de d1: " + dClone);
    }
}

