package atividades.atividade4;

public class Aluno {
    private String nome;
    private String  matricula;
    private double nota1;
    private double nota2;
    private double notaTrabalho;
    private Data nascimento;

    public Aluno(String nome, String matricula, double nota1, double nota2, double notaTrabalho, Data nascimento) {
        this.nome = nome;
        this.matricula = matricula;
        this.nota1 = nota1;
        this.nota2 = nota2;
        this.notaTrabalho = notaTrabalho;
        this.nascimento = nascimento;
    }
    public Aluno() {
        this.matricula = "0000000";
        this.nome = "Nome não definido";
        this.nota1 = 0;
        this.nota2 = 0;
        this.notaTrabalho = 0;
    }

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


    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public double getNota1() {
        return nota1;
    }

    public void setNota1(double nota1) {
        this.nota1 = nota1;
    }

    public double getNota2() {
        return nota2;
    }

    public void setNota2(double nota2) {
        this.nota2 = nota2;
    }

    public double getNotaTrabalho() {
        return notaTrabalho;
    }

    public void setNotaTrabalho(double notaTrabalho) {
        this.notaTrabalho = notaTrabalho;
    }

    public Data getNascimento() {
        return nascimento;
    }

    public void setNascimento(Data nascimento) {
        this.nascimento = nascimento;
    }

    @Override
    public String toString() {
        return "Aluno{" +
                "nome='" + nome + '\'' +
                ", matricula='" + matricula + '\'' +
                ", nota1=" + nota1 +
                ", nota2=" + nota2 +
                ", notaTrabalho=" + notaTrabalho +
                ", Media=" + this.getMedia() +
                ", Nota Rec=" + this.getNotaRec() +
                ", nascimento=" + nascimento +
                '}';
    }
}

