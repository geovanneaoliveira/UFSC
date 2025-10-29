package atividades.atividade8;
import java.util.Arrays;
import java.util.Scanner;

public class VetorOrdenacaoBusca {

    public static void main(String[] args) {
        // Vetor com 10 números inteiros em ordem aleatória
        int[] numeros = {25, 3, 17, 42, 8, 19, 33, 1, 14, 6};

        // Exibe o vetor original
        System.out.println("Vetor original: " + Arrays.toString(numeros));

        // Ordena o vetor usando Arrays.sort()
        Arrays.sort(numeros);

        // Exibe o vetor ordenado
        System.out.println("Vetor ordenado: " + Arrays.toString(numeros));

        Scanner scanner = new Scanner(System.in);
        System.out.print("Digite um número para buscar no vetor: ");
        int valorBusca = scanner.nextInt();

        int posicao = Arrays.binarySearch(numeros, valorBusca);

        // Verifica se o valor foi encontrado
        if (posicao >= 0) {
            System.out.println("Valor " + valorBusca + " encontrado na posição " + posicao + ".");
        } else {
            System.out.println("Valor " + valorBusca + " não encontrado no vetor.");
        }

        scanner.close();
    }
}

