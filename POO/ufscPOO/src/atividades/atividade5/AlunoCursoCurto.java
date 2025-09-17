package atividades.atividade5;

public class AlunoCursoCurto extends Aluno {
    private int mesEntrada, anoEntrada;
    private double nota1, nota2;

    public AlunoCursoCurto(String matricula, String nome, int mesEntrada, int anoEntrada, double nota1, double nota2) {
        super(matricula, nome);
        this.mesEntrada = mesEntrada;
        this.anoEntrada = anoEntrada;
        this.nota1 = nota1;
        this.nota2 = nota2;
    }

    @Override
    public String calcularResultado() {
        double media = (nota1 + nota2) / 2.0;
        return String.format("Média: %.2f - %s", media, (media >= 5 ? "Aprovado" : "Reprovado"));
    }

    @Override
    public String toString() {
        return super.toString() + ", AlunoCursoCurto{" +
                "nota2=" + nota2 +
                ", nota1=" + nota1 +
                ", anoEntrada=" + anoEntrada +
                ", mesEntrada=" + mesEntrada +
                '}';
    }
}
