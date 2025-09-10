package atividades.atividade4;

public class Aluno {
    private String nome;
    private int matricula;
    private double nota;
    private Data nascimento; // novo atributo

    public Aluno(String nome, int matricula, double nota, Data nascimento) {
        this.nome = nome;
        this.matricula = matricula;
        this.nota = nota;
        this.nascimento = nascimento;
    }

    // Getters e Setters
    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public int getMatricula() { return matricula; }
    public void setMatricula(int matricula) { this.matricula = matricula; }

    public double getNota() { return nota; }
    public void setNota(double nota) { this.nota = nota; }

    public Data getNascimento() { return nascimento; }
    public void setNascimento(Data nascimento) { this.nascimento = nascimento; }

    public boolean aprovado() {
        return nota >= 6.0;
    }

    @Override
    public String toString() {
        return "Aluno: " + nome + " | Matrícula: " + matricula +
                " | Nota: " + nota + " | Nascimento: " + nascimento;
    }
}

