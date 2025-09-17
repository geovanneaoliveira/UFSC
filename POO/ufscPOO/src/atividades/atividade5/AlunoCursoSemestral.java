package atividades.atividade5;

public class AlunoCursoSemestral extends Aluno {
    private int semestre, anoEntrada;
    private double nota1, nota2, nota3;

    public AlunoCursoSemestral(String matricula, String nome, int semestre, int anoEntrada, double nota1, double nota2, double nota3) {
        super(matricula, nome);
        this.semestre = semestre;
        this.anoEntrada = anoEntrada;
        this.nota1 = nota1;
        this.nota2 = nota2;
        this.nota3 = nota3;
    }

    @Override
    public String calcularResultado() {
        double media = (nota1 + nota2 + 2 * nota3) / 4.0;
        return String.format("Média: %.2f - %s", media, (media >= 6 ? "Aprovado" : "Reprovado"));
    }

    @Override
    public String toString() {
        return super.toString() + ", AlunoCursoSemestral{" +
                "semestre=" + semestre +
                ", anoEntrada=" + anoEntrada +
                ", nota1=" + nota1 +
                ", nota2=" + nota2 +
                ", nota3=" + nota3 +
                '}';
    }
}
