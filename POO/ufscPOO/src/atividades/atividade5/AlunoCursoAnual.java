package atividades.atividade5;

public class AlunoCursoAnual extends Aluno {
    private int anoEntrada;
    private double nota1, nota2, nota3, nota4;

    public AlunoCursoAnual(String matricula, String nome, int anoEntrada, double nota1, double nota2, double nota3, double nota4) {
        super(matricula, nome);
        this.anoEntrada = anoEntrada;
        this.nota1 = nota1;
        this.nota2 = nota2;
        this.nota3 = nota3;
        this.nota4 = nota4;
    }

    @Override
    public String calcularResultado() {
        // nota2 e nota4 têm peso maior (80%)
        double media = (nota1 + 4 * nota2 + nota3 + 4 * nota4) / 10.0;
        return String.format("Média: %.2f - %s", media, (media >= 7 ? "Aprovado" : "Reprovado"));
    }

    @Override
    public String toString() {
        return super.toString() + ", AlunoCursoAnual{" +
                "anoEntrada=" + anoEntrada +
                ", nota1=" + nota1 +
                ", nota2=" + nota2 +
                ", nota3=" + nota3 +
                ", nota4=" + nota4 +
                '}';
    }
}
