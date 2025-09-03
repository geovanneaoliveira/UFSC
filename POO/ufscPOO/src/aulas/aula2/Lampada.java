package aulas.aula2;

public class Lampada {
    private boolean status;

    private int potencia;

    public Lampada(boolean status, int potencia){
        this.status = status;
        this.potencia = potencia;
    }

    public Lampada(Semaforo semaforo){
        this.status = status;
        this.potencia = potencia;
    }

    public Lampada() {

    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getPotencia() {
        return potencia;
    }

    public void setPotencia(int potencia) {
        this.potencia = potencia;
    }

    public void apaga() {
        this.status = false;
    }

    public void acende() {
        this.status = true;
    }

    @Override
    public String toString() {
        return "Lampada{" +
                "status=" + status +
                ", potencia=" + potencia +
                '}';
    }
}
