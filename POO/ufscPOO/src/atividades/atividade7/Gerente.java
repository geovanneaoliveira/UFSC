package atividades.atividade7;

public class Gerente extends Funcionario {
    private String area;

    public Gerente(String nome, Data nascimento, float salario, String area) {
        super(nome, nascimento, salario);
        this.area = area;
    }

    @Override
    public float calculaImposto() {
        return getSalario() * 0.05f; // imposto de 5%
    }

    @Override
    public void imprimeDados() {
        System.out.println("=== Gerente ===");
        System.out.println("Nome: " + getNome());
        System.out.println("Nascimento: " + getNascimento());
        System.out.println("Salário: " + getSalario());
        System.out.println("Área: " + area);
        System.out.println("Imposto: " + calculaImposto());
        System.out.println();
    }
}

