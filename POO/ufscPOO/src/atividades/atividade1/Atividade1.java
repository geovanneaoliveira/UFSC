package atividades.atividade1;
/*
Usando Java, faça um programa para inicializar um vetor A(6) = {a1,a2,...,a6} e em seguida produzir a matriz

M(6,6) =  a1*a1    a1*a2    a1*a3    a1*a4    a1*a5    a1*a6
          a2*a1    a2*a2    a2*a3    a2*a4    a2*a5    a2*a6
          ...
          a6*a1    a6*a2    a6*a3    a6*a4    a6*a5    a6*a6

Ao final, apresentar o vetor A, a matriz M, e a soma de todos os elementos da matriz M cujo o valor é maior do que a média de todos os elementos de M.
Para calcular a média dos elementos de M deverá ser criado um metodo (função). As variáveis devem ser locais.

Use como valores para o vetor A a série {1,3,5,6,8,9}.
 */


import java.util.Arrays;

public class Atividade1 {
    public static void main(String[] args) {
        int[] a = {1,3,5,6,8,9};
        int[][] m = new int[6][6];
        for (int lin = 0; lin < m.length; lin++){
            for (int col = 0; col < m[lin].length; col++){
                m[lin][col] = a[lin] * a[col];
            }
        }
        System.out.println("Vetor A: " + Arrays.toString(a));
        System.out.println("Matriz M: " + Arrays.deepToString(m));
        double media = calculaMedia(m);
        int soma = 0;
        for (int lin = 0; lin < m.length; lin++){
            for (int col = 0; col < m[lin].length; col++){
                if(m[lin][col]>media){
                    soma += m[lin][col];
                }
            }
        }
        System.out.println("Soma: " + soma);
    }

    private static double calculaMedia(int[][] m) {
        int soma = 0;
        for (int lin = 0; lin < m.length; lin++) {
            for (int col = 0; col < m[lin].length; col++) {
                soma += m[lin][col];
            }
        }
        double mean = (double) soma /36;
        System.out.println(mean);
        return mean;
    }
}
