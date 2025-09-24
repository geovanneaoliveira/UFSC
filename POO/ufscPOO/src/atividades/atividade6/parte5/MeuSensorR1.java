package atividades.atividade6.parte5;

import java.text.SimpleDateFormat;
import java.util.Date;

/** Sensor dummy que retorna sempre o valor 1 nas leituras
 * 
 * @author mauri
 *
 */

public class MeuSensorR1 implements Dispositivo {
	
	private String idDispositivo = "S1";

	@Override
	public Data getData() {
		
		String date = new SimpleDateFormat("dd-MM-yyyy hh:mm:ss").format(new Date());		
		return new Data(this.idDispositivo, date, 1f);
	}

}