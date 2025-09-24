package atividades.atividade6.parte2;

interface IOperacaoMatematica {
    float calcula();
}

interface Apresentacao {
    String mostraOpName();
    String mostraOpSimbolo();
}

class Soma implements IOperacaoMatematica, Apresentacao {
    private float a;
    private float b;

    public Soma(float a, float b) {
        this.a = a;
        this.b = b;
    }

    @Override
    public float calcula() {
        return a + b;
    }

    @Override
    public String mostraOpName() {
        return "Soma";
    }

    @Override
    public String mostraOpSimbolo() {
        return "+";
    }
}

class Subtracao implements IOperacaoMatematica, Apresentacao {
    private float a;
    private float b;

    public Subtracao(float a, float b) {
        this.a = a;
        this.b = b;
    }

    @Override
    public float calcula() {
        return a - b;
    }

    @Override
    public String mostraOpName() {
        return "Subtração";
    }

    @Override
    public String mostraOpSimbolo() {
        return "-";
    }
}

class Multiplicacao implements IOperacaoMatematica, Apresentacao {
    private float a;
    private float b;

    public Multiplicacao(float a, float b) {
        this.a = a;
        this.b = b;
    }

    @Override
    public float calcula() {
        return a * b;
    }

    @Override
    public String mostraOpName() {
        return "Multiplicação";
    }

    @Override
    public String mostraOpSimbolo() {
        return "*";
    }
}

class Divisao implements IOperacaoMatematica, Apresentacao {
    private float a;
    private float b;

    public Divisao(float a, float b) {
        this.a = a;
        this.b = b;
    }

    @Override
    public float calcula() {
        if (b == 0) {
            throw new ArithmeticException("Divisão por zero não permitida!");
        }
        return a / b;
    }

    @Override
    public String mostraOpName() {
        return "Divisão";
    }

    @Override
    public String mostraOpSimbolo() {
        return "/";
    }
}

public class Main {
    public static void main(String[] args) {
        int a = 8;
        int b = 10;
        Apresentacao[] operacoes = {
                new Soma(a, b),
                new Subtracao(a, b),
                new Multiplicacao(a, b),
                new Divisao(a, b)
        };

        for (Apresentacao op : operacoes) {
            IOperacaoMatematica operacao = (IOperacaoMatematica) op;
            System.out.println(op.mostraOpName() + " (" + op.mostraOpSimbolo() + "): " + operacao.calcula());
        }
    }
}
