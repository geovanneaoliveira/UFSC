package atividades.atividade5extra2;

public class Automovel extends Transporte implements Descontavel{
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

    @Override
    public double fatorCustoLocacaoComDesconto(int n) {
        double desconto = 0.0;
        if (n >= 2 && n < 5) desconto = 0.05;
        else if (n >= 5 && n < 10) desconto = 0.10;
        else if (n >= 10) desconto = 0.15;
        return fatorCustoDaLocacao() * (1 - desconto);
    }
}
