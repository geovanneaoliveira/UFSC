package atividades.atividade3.atividade31;

public class Main {
    public static void main(String[] args) {
        Aluno aluno1 = new Aluno();
        Aluno aluno2 = new Aluno("21100935", "Geovanne");
        Aluno aluno3 = new Aluno("24187124", "João", 7, 4, 6);

        System.out.println(aluno1.toString());
        System.out.println(aluno2.toString());
        System.out.println(aluno3.toString());
        System.out.println("Aluno3: " + aluno3.getNome() + " - Média: " + aluno3.getMedia() + " - Nota Rec: " + aluno3.getNotaRec());
    }
}
