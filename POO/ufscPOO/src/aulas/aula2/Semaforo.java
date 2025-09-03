package aulas.aula2;

public class Semaforo {
    private Lampada lampVermelha;
    private Lampada lampAmarela;
    private Lampada lampVerde;

    private int status = 0; // 0 - Desligado; 1- Fechado; 2 - Alerta; 3 - Aberto

    public Semaforo(){
        lampVermelha = new Lampada();
        lampAmarela = new Lampada();
        lampVerde = new Lampada();
    }

    public Semaforo(int status){
        lampVermelha = new Lampada();
        lampAmarela = new Lampada();
        lampVerde = new Lampada();
        if (status==1){
            this.fecha();
        } else if (status==2){
            this.alerta();
        } else if (status==3){
            this.abre();
        } else {
            this.desliga();
        }
    }

    public void abre() {
        this.lampVermelha.apaga();
        this.lampAmarela.apaga();
        this.lampVerde.acende();
        this.status = 3;
    }

    public void alerta() {
        this.lampVermelha.apaga();
        this.lampAmarela.acende();
        this.lampVerde.apaga();
        this.status = 2;
    }

    public void fecha() {
        this.lampVermelha.acende();
        this.lampAmarela.apaga();
        this.lampVerde.apaga();
        this.status = 1;
    }

    public void desliga() {
        this.lampVermelha.apaga();
        this.lampAmarela.apaga();
        this.lampVerde.apaga();
        this.status = 0;
    }

    public int getStatus() {
        return status;
    }

    @Override
    public String toString() {
        return "Semaforo{" +
                "lampVermelha=" + lampVermelha +
                ", lampAmarela=" + lampAmarela +
                ", lampVerde=" + lampVerde +
                ", status=" + status +
                '}';
    }
}
