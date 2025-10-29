package atividades.atividade5extra;

public class Main {
    public static void main(String[] args) {
        Transporte automovelAr = new Automovel("auto1","auto1",14,200,5,true);
        Transporte automovelSemAr = new Automovel("auto2","auto2",14,200,5,false);
        System.out.println(automovelAr);
        System.out.println(automovelSemAr);
        Transporte bicicletaElet = new Bicicleta("bic1", "bic1",10,20,15,true);
        Transporte bicicletaNaoElet = new Bicicleta("bic2", "bic2",10,20,15,false);
        System.out.println(bicicletaElet);
        System.out.println(bicicletaNaoElet);
        Transporte caminhao1eixo = new Caminhao("cam1","cam1",10,100,1000,1);
        Transporte caminhao2eixo = new Caminhao("cam2","cam2",10,100,1000,2);
        System.out.println(caminhao1eixo);
        System.out.println(caminhao2eixo);
        Transporte moto150 = new Moto("mot1","mot1",10,100,200,150);
        Transporte moto200 = new Moto("mot1","mot1",10,100,200,200);
        System.out.println(moto150);
        System.out.println(moto200);
        Transporte onibus10pessoas = new Onibus("oni1","oni1",10,100,30,10,2);
        Transporte onibus20pessoas = new Onibus("oni2","oni2",10,100,30,20,2);
        System.out.println(onibus10pessoas);
        onibus20pessoas.set
        System.out.println(onibus20pessoas);
    }
}
