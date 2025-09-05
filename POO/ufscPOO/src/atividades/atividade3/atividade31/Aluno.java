package atividades.atividade3.atividade31;

public class Aluno {
    private String matricula;
    private String nome;
    private double nota1;
    private double nota2;
    private double notaTrabalho;

    public Aluno() {
        this.matricula = "0000000";
        this.nome = "Nome não definido";
        this.nota1 = 0;
        this.nota2 = 0;
        this.notaTrabalho = 0;
    }

    public Aluno(String matricula, String nome) {
        this.matricula = matricula;
        this.nome = nome;
        this.nota1 = 0;
        this.nota2 = 0;
        this.notaTrabalho = 0;
    }

    public Aluno(String matricula, String nome, double nota1, double nota2, double notaTrabalho) {
        this.matricula = matricula;
        this.nome = nome;
        this.nota1 = nota1;
        this.nota2 = nota2;
        this.notaTrabalho = notaTrabalho;
    }

    public String getMatricula() { return matricula; }
    public void setMatricula(String matricula) { this.matricula = matricula; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public double getNota1() { return nota1; }
    public void setNota1(double nota1) { this.nota1 = nota1; }

    public double getNota2() { return nota2; }
    public void setNota2(double nota2) { this.nota2 = nota2; }

    public double getNotaTrabalho() { return notaTrabalho; }
    public void setNotaTrabalho(double notaTrabalho) { this.notaTrabalho = notaTrabalho; }

    public double getMedia() {
        return (nota1 * 2.5 + nota2 * 2.5 + notaTrabalho * 5) / 10;
    }

    public double getNotaRec() {
        double media = getMedia();
        if (media >= 6.0) {
            return 0;
        } else {
            return 6.0 - media;
        }
    }

    @Override
    public String toString() {
        return "Aluno{" +
                "matricula='" + matricula + '\'' +
                ", nome='" + nome + '\'' +
                ", nota1=" + nota1 +
                ", nota2=" + nota2 +
                ", notaTrabalho=" + notaTrabalho +
                '}';
    }
}
