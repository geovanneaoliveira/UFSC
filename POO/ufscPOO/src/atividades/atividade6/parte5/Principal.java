package atividades.atividade6.parte5;

public class Principal {
	
	public static void main(String[] args) throws InterruptedException {
		
		Dispositivo d1 = new MeuSensorR1();
        Dispositivo d2 = new MeuSensorR2();
        Dispositivo d3 = new MeuSensorR3();
		
		for (int i = 0; i < 10; i++) {
			Data data1 = d1.getData();
            Data data2 = d2.getData();
            Data data3 = d3.getData();
			System.out.println(data1.toString());
            System.out.println(data2.toString());
            System.out.println(data3.toString());
            // espera 2 segundos
			Thread.sleep(2000);
		}
	}

}