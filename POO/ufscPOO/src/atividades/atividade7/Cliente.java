package atividades.atividade7;

public class Cliente extends Pessoa {
    private int codigo;

    public Cliente(String nome, Data nascimento, int codigo) {
        super(nome, nascimento);
        this.codigo = codigo;
    }

    @Override
    public void imprimeDados() {
        System.out.println("=== Cliente ===");
        System.out.println("Nome: " + getNome());
        System.out.println("Nascimento: " + getNascimento());
        System.out.println("Código: " + codigo);
        System.out.println("Imposto: " + calcularImposto());
        System.out.println();
    }

    public float calcularImposto() {
        return 0.03f; // 3% do salário (aplicação simbólica)
    }
}
