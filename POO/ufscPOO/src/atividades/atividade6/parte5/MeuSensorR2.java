package atividades.atividade6.parte5;

import java.text.SimpleDateFormat;
import java.util.Date;

public class MeuSensorR2 implements Dispositivo {
	
	private String idDispositivo = "S2";

	@Override
	public Data getData() {
		
		String date = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss").format(new Date());		
		return new Data(this.idDispositivo, date, 2f);
	}

}