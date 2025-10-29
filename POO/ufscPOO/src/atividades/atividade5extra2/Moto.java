package atividades.atividade5extra2;

public class Moto extends Transporte {
    private double capacidadeKG;
    private int cilindradas;

    public Moto(String codigo, String nome, double tempoLocacao, double kmRodados, double capacidadeKG, int cilindradas) {
        super(codigo, nome, tempoLocacao, kmRodados);
        this.capacidadeKG = capacidadeKG;
        this.cilindradas = cilindradas;
    }

    @Override
    public double fatorCustoDaLocacao() {
        return this.getTempoLocacao() * this.getKmRodados() * this.getCilindradas();
    }

    public double getCapacidadeKG() {
        return capacidadeKG;
    }

    public void setCapacidadeKG(double capacidadeKG) {
        this.capacidadeKG = capacidadeKG;
    }

    public int getCilindradas() {
        return cilindradas;
    }

    public void setCilindradas(int cilindradas) {
        this.cilindradas = cilindradas;
    }

    @Override
    public String toString() {
        return super.toString() + "Moto{" +
                "capacidadeKG=" + capacidadeKG +
                ", cilindradas=" + cilindradas +
                '}';
    }
}
