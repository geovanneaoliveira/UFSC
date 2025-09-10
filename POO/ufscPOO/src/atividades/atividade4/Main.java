package atividades.atividade4;

public class Main {
    public static void main(String[] args) {
        Data d1 = new Data(10, 9, 2002);
        Aluno a1 = new Aluno("Geovanne", 21100935, 9.8, d1);
        Aluno a2 = new Aluno("Julio", 232429392, 5.0, new Data(5, 4, 2001));

        Turma t = new Turma("T001", "POO");
        t.adicionaAluno(a1);
        t.adicionaAluno(a2);

        System.out.println("Todos os alunos:");
        t.mostraAlunos();

        System.out.println("\nAprovados:");
        t.mostraAlunosAprovados();

    }
}
