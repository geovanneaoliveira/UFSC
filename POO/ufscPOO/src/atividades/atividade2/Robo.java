package atividades.atividade2;

public class Robo {
    private int id;
    private double coordenadaX;
    private double coordenadaY;

    public Robo(int id, double coordenadaX, double coordenadaY) {
        this.setId(id);
        this.setCoordenadaX(coordenadaX);
        this.setCoordenadaY(coordenadaY);
    }

    public Robo() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getCoordenadaX() {
        return coordenadaX;
    }

    public void setCoordenadaX(double coordenadaX) {
        this.coordenadaX = coordenadaX;
    }

    public double getCoordenadaY() {
        return coordenadaY;
    }

    public void setCoordenadaY(double coordenadaY) {
        this.coordenadaY = coordenadaY;
    }

    @Override
    public String toString() {
        return "Robo{" +
                "id=" + id +
                ", coordenadaX=" + coordenadaX +
                ", coordenadaY=" + coordenadaY +
                '}';
    }
}
