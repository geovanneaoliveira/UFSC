package atividades.atividade6.parte5;

import java.text.SimpleDateFormat;
import java.util.Date;

public class MeuSensorR3 implements Dispositivo {
	
	private String idDispositivo = "S3";

	@Override
	public Data getData() {
		
		String date = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss").format(new Date());		
		return new Data(this.idDispositivo, date, 3f);
	}

}