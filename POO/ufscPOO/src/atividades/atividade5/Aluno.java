package atividades.atividade5;

public abstract class Aluno {
    protected String matricula;
    protected String nome;

    public Aluno(String matricula, String nome) {
        this.matricula = matricula;
        this.nome = nome;
    }

    public abstract String calcularResultado();

    @Override
    public String toString() {
        return "Matrícula: " + matricula + ", Nome: " + nome;
    }
}
