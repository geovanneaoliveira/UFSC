package atividades.atividade7;

public abstract class Pessoa {
    private String nome;
    private Data nascimento;

    public Pessoa(String nome, Data nascimento) {
        this.nome = nome;
        this.nascimento = nascimento;
    }

    public String getNome() {
        return nome;
    }

    public Data getNascimento() {
        return nascimento;
    }

    public abstract void imprimeDados();
}
