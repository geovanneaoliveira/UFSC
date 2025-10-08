package atividades.atividade5extra;

public class Onibus extends Transporte{
    private int nroMaximoDePessoas;
    private int nroDePessoasTransportadas;
    private int nroDeEixos;

    public Onibus(String codigo, String nome, double tempoLocacao, double kmRodados, int nroMaximoDePessoas, int nroDePessoasTransportadas, int nroDeEixos) {
        super(codigo, nome, tempoLocacao, kmRodados);
        this.nroMaximoDePessoas = nroMaximoDePessoas;
        this.nroDePessoasTransportadas = nroDePessoasTransportadas;
        this.nroDeEixos = nroDeEixos;
    }

    @Override
    public double fatorCustoDaLocacao() {
        return this.getTempoLocacao() * this.getKmRodados() * this.getNroDeEixos() *
                ((double) this.getNroDePessoasTransportadas() / this.getNroMaximoDePessoas());
    }

    public int getNroMaximoDePessoas() {
        return nroMaximoDePessoas;
    }

    public void setNroMaximoDePessoas(int nroMaximoDePessoas) {
        this.nroMaximoDePessoas = nroMaximoDePessoas;
    }

    public int getNroDePessoasTransportadas() {
        return nroDePessoasTransportadas;
    }

    public void setNroDePessoasTransportadas(int nroDePessoasTransportadas) {
        this.nroDePessoasTransportadas = nroDePessoasTransportadas;
    }

    public int getNroDeEixos() {
        return nroDeEixos;
    }

    public void setNroDeEixos(int nroDeEixos) {
        this.nroDeEixos = nroDeEixos;
    }

    @Override
    public String toString() {
        return super.toString() + "Onibus{" +
                "nroMaximoDePessoas=" + nroMaximoDePessoas +
                ", nroDePessoasTransportadas=" + nroDePessoasTransportadas +
                ", nroDeEixos=" + nroDeEixos +
                '}';
    }
}
