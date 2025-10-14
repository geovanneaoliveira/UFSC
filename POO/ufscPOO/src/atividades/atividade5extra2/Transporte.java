package atividades.atividade5extra2;

public abstract class Transporte {
    private String codigo;
    private String nome;
    private double tempoLocacao;
    private double kmRodados;

    public Transporte(String codigo, String nome, double tempoLocacao, double kmRodados) {
        this.codigo = codigo;
        this.nome = nome;
        this.tempoLocacao = tempoLocacao;
        this.kmRodados = kmRodados;
    }

    public abstract double fatorCustoDaLocacao();

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public double getTempoLocacao() {
        return tempoLocacao;
    }

    public void setTempoLocacao(double tempoLocacao) {
        this.tempoLocacao = tempoLocacao;
    }

    public double getKmRodados() {
        return kmRodados;
    }

    public void setKmRodados(double kmRodados) {
        this.kmRodados = kmRodados;
    }

    @Override
    public String toString() {
        return "Transporte{" +
                "codigo='" + codigo + '\'' +
                ", nome='" + nome + '\'' +
                ", tempoLocacao=" + tempoLocacao +
                ", kmRodados=" + kmRodados +
                ", custoLocacao=" + this.fatorCustoDaLocacao()+
                "} - ";
    }
}
