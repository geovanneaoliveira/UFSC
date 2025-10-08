package atividades.atividade5extra;

public class Bicicleta extends Transporte{
    private double capacidadeKG;
    private boolean eletrica;

    public Bicicleta(String codigo, String nome, double tempoLocacao, double kmRodados, double capacidadeKG, boolean eletrica) {
        super(codigo, nome, tempoLocacao, kmRodados);
        this.capacidadeKG = capacidadeKG;
        this.eletrica = eletrica;
    }

    @Override
    public double fatorCustoDaLocacao() {
        if (this.eletrica){
            return this.getTempoLocacao() * this.getKmRodados() * 2;
        } else {
            return this.getTempoLocacao() * this.getKmRodados();
        }
    }

    public double getCapacidadeKG() {
        return capacidadeKG;
    }

    public void setCapacidadeKG(double capacidadeKG) {
        this.capacidadeKG = capacidadeKG;
    }

    public boolean isEletrica() {
        return eletrica;
    }

    public void setEletrica(boolean eletrica) {
        this.eletrica = eletrica;
    }

    @Override
    public String toString() {
        return super.toString() + "Bicicleta{" +
                "capacidadeKG=" + capacidadeKG +
                ", eletrica=" + eletrica +
                '}';
    }
}
