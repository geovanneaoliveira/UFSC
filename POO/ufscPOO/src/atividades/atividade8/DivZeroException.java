package atividades.atividade8;
import java.util.Scanner;
import java.util.InputMismatchException;

public class DivZeroException {

    // demonstra o lançamento de uma exceção quando ocorre uma divisão por zero
    public static int quotient(int numerator, int denominator) {
        return numerator / denominator; // possível divisão por zero
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        try {
            System.out.print("Please enter an integer numerator: ");
            int numerator = scanner.nextInt();

            System.out.print("Please enter an integer denominator: ");
            int denominator = scanner.nextInt();

            int result = quotient(numerator, denominator);
            System.out.printf("%nResult: %d / %d = %d%n", numerator, denominator, result);

        } catch (ArithmeticException e) {
            System.out.println("Erro: Denominador não pode ser 0!!");
        } catch (InputMismatchException e) {
            System.out.println("Erro: Insira apenas números inteiros.");
        } finally {
            System.out.println("Execução finalizada.");
            scanner.close();
        }
    }
}

