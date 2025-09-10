package atividades.atividade4;

import java.util.Arrays;
import java.util.Objects;

public class Turma {
    private String codigo;
    private String nome;
    private Aluno[] alunos;
    private int numAlunos;

    public Turma(String codigo, String nome) {
        this.codigo = codigo;
        this.nome = nome;
        this.alunos = new Aluno[50];
        this.numAlunos = 0;
    }

    public void adicionaAluno(Aluno a) {
        if (numAlunos < 50) {
            alunos[numAlunos] = a;
            numAlunos++;
        }
    }

    public int getNumAlunos() {
        return numAlunos;
    }

    public void mostraAlunos() {
        for (int i = 0; i < numAlunos; i++) {
            System.out.println(alunos[i]);
        }
    }

    public void mostraAlunosAprovados() {
        for (int i = 0; i < numAlunos; i++) {
            if (alunos[i].getMedia()>=6) {
                System.out.println(alunos[i]);
            }
        }
    }

    @Override
    public String toString() {
        return "Turma{" +
                "codigo='" + codigo + '\'' +
                ", nome='" + nome + '\'' +
                ", alunos=" + Arrays.toString(
                Arrays.stream(alunos)
                        .filter(Objects::nonNull) // remove nulos
                        .toArray()
                ) +
                ", numAlunos=" + numAlunos +
                '}';
    }
}

