package atividades.atividade5;

public class Main {
    public static void main(String[] args) {
        Aluno a1 = new AlunoCursoCurto("21100935", "Geovanne", 6, 2025, 9, 4.5);
        Aluno a2 = new AlunoCursoSemestral("123012801", "Julio", 1, 2025, 6, 10, 5);
        Aluno a3 = new AlunoCursoAnual("124124871", "Erika", 2025, 5, 6, 7, 8);
        Aluno a4 = new AlunoCursoLongo("412486192", "Rodrigo", 2025, 36, 5, 4, 5);

        Aluno[] alunos = {a1, a2, a3, a4};

        for (Aluno aluno : alunos) {
            System.out.println(aluno);
            System.out.println(aluno.calcularResultado());
            System.out.println("------------------------");
        }
    }
}
