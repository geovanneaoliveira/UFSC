package atividades.atividade7;

public class TestaCadastro {
    public static void main(String[] args) {
        CadastroPessoas cadastro = new CadastroPessoas(3);

        Cliente c1 = new Cliente("Geovanne", new Data(8, 11, 2002), 101);
        Funcionario f1 = new Funcionario("Lucca", new Data(10, 1, 2001), 3000.0f);
        Gerente g1 = new Gerente("Rodrigo", new Data(14, 6, 2002), 8000.0f, "Vendas");

        cadastro.cadastraPessoa(c1);
        cadastro.cadastraPessoa(f1);
        cadastro.cadastraPessoa(g1);

        cadastro.imprimeCadastro();
    }
}

