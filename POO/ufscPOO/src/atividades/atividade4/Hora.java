package atividades.atividade4;

public class Hora {
    private int hora;
    private int minuto;
    private int segundo;

    public Hora(int hora, int minuto, int segundo) {
        this.hora = hora;
        this.minuto = minuto;
        this.segundo = segundo;
    }

    public Hora(int hora, int minuto) {
        this(hora, minuto, 0);
    }

    // Getters e Setters
    public int getHora() { return hora; }
    public void setHora(int hora) { this.hora = hora; }

    public int getMinuto() { return minuto; }
    public void setMinuto(int minuto) { this.minuto = minuto; }

    public int getSegundo() { return segundo; }
    public void setSegundo(int segundo) { this.segundo = segundo; }

    @Override
    public String toString() {
        return String.format("%02d:%02d:%02d", hora, minuto, segundo);
    }
}

