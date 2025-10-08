package atividades.atividade5extra;

public class Automovel extends Transporte{
    private int nroMaximoDePessoas;
    private boolean arCondicionado;

    public Automovel(String codigo, String nome, double tempoLocacao, double kmRodados, int nroMaximoDePessoas, boolean arCondicionado) {
        super(codigo, nome, tempoLocacao, kmRodados);
        this.nroMaximoDePessoas = nroMaximoDePessoas;
        this.arCondicionado = arCondicionado;
    }


    @Override
    public double fatorCustoDaLocacao() {
        if (this.hasArCondicionado()){
            return this.getTempoLocacao() * this.getKmRodados() * this.getNroMaximoDePessoas() * 1.2;
        } else {
            return this.getTempoLocacao() * this.getKmRodados() * this.getNroMaximoDePessoas();
        }
    }

    public int getNroMaximoDePessoas() {
        return nroMaximoDePessoas;
    }

    public void setNroMaximoDePessoas(int nroMaximoDePessoas) {
        this.nroMaximoDePessoas = nroMaximoDePessoas;
    }

    public boolean hasArCondicionado() {
        return arCondicionado;
    }

    public void setArCondicionado(boolean arCondicionado) {
        this.arCondicionado = arCondicionado;
    }

    @Override
    public String toString() {
        return super.toString() + "Automovel{" +
                "nroMaximoDePessoas=" + nroMaximoDePessoas +
                ", arCondicionado=" + arCondicionado +
                '}';
    }
}
