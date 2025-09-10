package atividades.atividade4;

public class Data {
    private int dia;
    private int mes;
    private int ano;

    public Data(int dia, int mes, int ano) {
        if (validarData(dia, mes, ano)) {
            this.dia = dia;
            this.mes = mes;
            this.ano = ano;
        } else {
            this.dia = 1;
            this.mes = 1;
            this.ano = 1;
        }
    }

    public Data(String data) {
        try {
            String[] partes = data.split("/");
            int d = Integer.parseInt(partes[0]);
            int m = Integer.parseInt(partes[1]);
            int a = Integer.parseInt(partes[2]);
            if (validarData(d, m, a)) {
                this.dia = d;
                this.mes = m;
                this.ano = a;
            } else {
                this.dia = 1;
                this.mes = 1;
                this.ano = 1;
            }
        } catch (Exception e) {
            this.dia = 1;
            this.mes = 1;
            this.ano = 1;
        }
    }

    public Data(int ano) {
        this.dia = 1;
        this.mes = 1;
        this.ano = ano;
    }

    public int getDia() { return dia; }
    public int getMes() { return mes; }
    public int getAno() { return ano; }

    public String getMesExtenso() {
        String[] meses = {"Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho",
                "Agosto","Setembro","Outubro","Novembro","Dezembro"};
        return meses[mes - 1];
    }

    public String getAno2Dig() {
        return String.format("%02d", ano % 100);
    }

    public boolean isBissexto() {
        return (ano % 4 == 0 && ano % 100 != 0) || (ano % 400 == 0);
    }

    @Override
    public String toString() {
        return String.format("%02d/%02d/%04d", dia, mes, ano);
    }

    public Data clone() {
        return new Data(dia, mes, ano);
    }

    private boolean validarData(int d, int m, int a) {
        if (a < 1 || m < 1 || m > 12 || d < 1) return false;
        int[] diasMes = {31, (isBissexto(a)?29:28), 31,30,31,30,31,31,30,31,30,31};
        return d <= diasMes[m-1];
    }

    private boolean isBissexto(int a) {
        return (a % 4 == 0 && a % 100 != 0) || (a % 400 == 0);
    }
}
