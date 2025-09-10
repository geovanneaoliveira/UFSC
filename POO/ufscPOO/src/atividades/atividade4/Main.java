package atividades.atividade4;

public class Main {
    public static void main(String[] args) {
        Data d1 = new Data(10, 9, 2002);
        Data d2 = new Data(27, 6, 2004);

        Aluno a1 = new Aluno("Geovanne", "21100935", 9.8, 6.7, 6, d1);
        Aluno a2 = new Aluno("Julio", "232472389", 4, 6, 6.4, d2);

        Turma t = new Turma("BLU3023", "POO");
        t.adicionaAluno(a1);
        t.adicionaAluno(a2);

        System.out.println(t.toString());
        System.out.println("----ALUNOS----");
        t.mostraAlunos();
        System.out.println("----APROVADOS----");
        t.mostraAlunosAprovados();
        System.out.println("Nro de Alunos: " + t.getNumAlunos());
    }
}
