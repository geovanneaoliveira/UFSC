package atividades.atividade5extra2;

import java.util.*;

public class Main {
    public static void main(String[] args) {
        // Lista com todos os transportes
        List<Transporte> transportes = new ArrayList<>();
        transportes.add(new Automovel("auto1","auto1",14,200,5,true));
        transportes.add(new Bicicleta("bic1", "bic1",10,20,15,true));
        transportes.add(new Caminhao("cam1","cam1",10,100,1000,1));
        transportes.add(new Onibus("oni1","oni1",10,100,30,10,2));

        System.out.println("=== Lista geral de transportes ===");
        for (Transporte t : transportes) {
            System.out.println(t.getNome());
        }

        List<Descontavel> descontos = new ArrayList<>();
        descontos.add(new Automovel("auto1","auto1",14,200,5,true));
        descontos.add(new Bicicleta("bic1", "bic1",10,20,15,true));

        System.out.println("\n=== Teste de desconto ===");
        for (Descontavel d : descontos) {
            System.out.println("Novo fator: " + d.fatorCustoLocacaoComDesconto(6));
        }
    }
}
