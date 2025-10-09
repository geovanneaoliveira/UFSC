package atividades.atividade7;

public class Funcionario extends Pessoa {
    private float salario;

    public Funcionario(String nome, Data nascimento, float salario) {
        super(nome, nascimento);
        this.salario = salario;
    }

    public float getSalario() {
        return salario;
    }

    public float calculaImposto() {
        return salario * 0.03f; // imposto base de 3%
    }

    @Override
    public void imprimeDados() {
        System.out.println("=== Funcionário ===");
        System.out.println("Nome: " + getNome());
        System.out.println("Nascimento: " + getNascimento());
        System.out.println("Salário: " + salario);
        System.out.println("Imposto: " + calculaImposto());
        System.out.println();
    }
}
