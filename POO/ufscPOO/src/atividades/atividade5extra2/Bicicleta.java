package atividades.atividade5extra2;

public class Bicicleta extends Transporte implements Descontavel{
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

    @Override
    public double fatorCustoLocacaoComDesconto(int n) {
        double desconto = 0.0;
        if (n >= 2 && n < 5) desconto = 0.05;
        else if (n >= 5 && n < 10) desconto = 0.10;
        else if (n >= 10) desconto = 0.15;
        return fatorCustoDaLocacao() * (1 - desconto);
    }
}
