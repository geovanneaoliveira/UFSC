package aulas.aula4;

public class Funcionario implements ISalario, IMostra {
    private int codigo;
    private String nome;
    private float valorHora;

    public Funcionario(int codigo, String nome, float valorHora) {
        this.codigo = codigo;
        this.nome = nome;
        this.valorHora = valorHora;
    }

    @Override
    public float calculaSalario() {
        return this.valorHora * ISalario.horasTrabalhadas;
    }

    @Override
    public void mostra() {
        System.out.println(this.toString());
    }

    @Override
    public String toString() {
        return "Funcionario{" +
                "codigo=" + codigo +
                ", nome='" + nome + '\'' +
                ", valorHora=" + valorHora +
                '}';
    }
}
