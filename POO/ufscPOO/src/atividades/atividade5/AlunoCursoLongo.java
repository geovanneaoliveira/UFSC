package atividades.atividade5;

public class AlunoCursoLongo extends Aluno {
    private int anoEntrada, duracaoMeses;
    private double nota1, nota2, nota3;

    public AlunoCursoLongo(String matricula, String nome, int anoEntrada, int duracaoMeses, double nota1, double nota2, double nota3) {
        super(matricula, nome);
        this.anoEntrada = anoEntrada;
        this.duracaoMeses = duracaoMeses;
        this.nota1 = nota1;
        this.nota2 = nota2;
        this.nota3 = nota3;
    }

    @Override
    public String calcularResultado() {
        double media = (nota1 + nota2 + nota3) / 3.0;
        String conceito;
        if (media >= 9.01) {
            conceito = "A";
        } else if (media >= 7.01) {
            conceito = "B";
        } else if (media >= 5.01) {
            conceito = "C";
        } else {
            conceito = "D";
        }
        String status = (conceito.equals("A") || conceito.equals("B")) ? "Aprovado" : "Reprovado";
        return String.format("Média: %.2f - Conceito: %s - %s", media, conceito, status);
    }

    @Override
    public String toString() {
        return super.toString() + ", AlunoCursoLongo{" +
                "anoEntrada=" + anoEntrada +
                ", duracaoMeses=" + duracaoMeses +
                ", nota1=" + nota1 +
                ", nota2=" + nota2 +
                ", nota3=" + nota3 +
                '}';
    }
}
