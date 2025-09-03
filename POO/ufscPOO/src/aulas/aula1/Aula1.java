package aulas.aula1;

import java.util.Arrays;

public class Aula1 {

    public static void main(String[] args) {
        // variavéis - tipos primitivos

        int a = 10, b;
        float c = 20f;
        double d = 30;
        char e = 'a';
        b = 100;
        System.out.println("Valor de a: " + a + " - b: " + b);

        // variavéis - tipos não primitivos - objeto

        String s = "teste de texto";
        Integer i2 = 10; // wrapper class
        Float f2 = 20f;

        // igual ao C
        if (a <= 10) {
            System.out.println("a <= 10");
        } else {
            System.out.println("a > 10");
        }

        // if else

        int dia = 3;
        if (dia == 1) {
            System.out.println("Segunda-feira");
        } else if (dia == 2) {
            System.out.println("Terca-feira");
        } else if (dia == 3) {
            System.out.println("Quarta-feira");
        } else {
            System.out.println("Não sei");
        }

        //while
        int i = 0;
        while (i<10){
            System.out.println("Valor de i com while:" + i);
            i++;
        }

        //for

        for(int j = 0; j < 5; j++){
            System.out.println("Valor de j no for: " + j);
        }

        // subprograma -> métodos, comportamento
        int p = 10;
        p = quadrado(p);
        System.out.println("Valor de p: " + p);

        //vetor
        int[] v1 = new int[5];
        v1[0] = 20;
        v1[3] = 24;
        v1[4] = 25;
        float[] v2 = new float[5];
        String[] v3 = new String[3];

        System.out.println("Tamanho do v3:" + v3.length);

        for (int k = 0; k< v1.length; k++){
            System.out.println("v1["+k+"]: " + v1[k]);
        }
        //mostrar vetores
        System.out.println(Arrays.toString(v1));

        //objetos como parametros
        //objetos sao sempre passados por referência
        modificaV1(v1);
        System.out.println(Arrays.toString(v1));

        //referência de objetos
        int[] va = {1,2,3};
        int[] vb = va;
        va[1] = 100;
        System.out.println(Arrays.toString(vb));

        //matrizes
        int[][] m = new int[2][3];
        for (int line = 0; line < m.length; line++){
            for (int col = 0; col < m[line].length; col++){
                m[line][col] = line * col + 1;
            }
        }
        System.out.println(Arrays.deepToString(m));
        m[1] = new int[5];
        System.out.println(Arrays.deepToString(m));
    }

    private static void modificaV1(int[] v1) {
        v1[2] = 1000;
    }

    private static int quadrado(int p) {
        return (int)Math.pow(p,2);
    }
}

