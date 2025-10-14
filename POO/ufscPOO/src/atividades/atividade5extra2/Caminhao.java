package atividades.atividade5extra2;

public class Caminhao extends Transporte {

    private double capacidadeKg;
    private int nroDeEixos;

    public Caminhao(String codigo, String nome, double tempoLocacao, double kmRodados, double capacidadeKg, int nroDeEixos) {
        super(codigo, nome, tempoLocacao, kmRodados);
        this.capacidadeKg = capacidadeKg;
        this.nroDeEixos = nroDeEixos;
    }

    @Override
    public double fatorCustoDaLocacao() {
        return this.getTempoLocacao() * this.getKmRodados() * this.getNroDeEixos();
    }

    public double getCapacidadeKg() {
        return capacidadeKg;
    }

    public void setCapacidadeKg(double capacidadeKg) {
        this.capacidadeKg = capacidadeKg;
    }

    public int getNroDeEixos() {
        return nroDeEixos;
    }

    public void setNroDeEixos(int nroDeEixos) {
        this.nroDeEixos = nroDeEixos;
    }

    @Override
    public String toString() {
        return super.toString() + "Caminhao{" +
                "capacidadeKg=" + capacidadeKg +
                ", nroDeEixos=" + nroDeEixos +
                '}';
    }
}
