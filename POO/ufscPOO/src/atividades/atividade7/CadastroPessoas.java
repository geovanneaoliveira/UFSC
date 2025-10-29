package atividades.atividade7;

public class CadastroPessoas {
    private Pessoa[] pessoas;
    private int qtdAtual;

    public CadastroPessoas(int tamanho) {
        pessoas = new Pessoa[tamanho];
        qtdAtual = 0;
    }

    public void cadastraPessoa(Pessoa p) {
        if (qtdAtual < pessoas.length) {
            pessoas[qtdAtual] = p;
            qtdAtual++;
        } else {
            System.out.println("Cadastro cheio!");
        }
    }

    public void imprimeCadastro() {
        System.out.println("\n=== Cadastro de Pessoas ===");
        for (int i = 0; i < qtdAtual; i++) {
            pessoas[i].imprimeDados();
        }
    }
}
