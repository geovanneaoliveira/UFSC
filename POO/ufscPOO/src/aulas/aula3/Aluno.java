package aulas.aula3;

public class Aluno extends Pessoa{
    private String matricula;
    private String curso;

    public Aluno(String cpf, String nome, String matricula, String curso) {
        super(cpf, nome);
        this.matricula = matricula;
        this.curso = curso;
    }

    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getCurso() {
        return curso;
    }

    public void setCurso(String curso) {
        this.curso = curso;
    }

    @Override
    public String toString() {
        return "Aluno{" +
                "matricula='" + matricula + '\'' +
                ", curso='" + curso + '\'' +
                '}';
    }
}
