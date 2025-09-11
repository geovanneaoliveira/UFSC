const int sensorPinInicio = 6; 
const int sensorPinLuz = 7; // Pino onde o sensor está conectado 
const int PINO_IN1 = 8;  // Pino responsável pelo controle no sentido horário
const int PINO_IN2 = 9;  // Pino responsável pelo controle no sentido anti-horário
  
void setup() { 
  pinMode(sensorPinInicio, INPUT); Serial.begin(9600);
  pinMode(sensorPinLuz, INPUT); Serial.begin(9600); 
} 
void loop() { 
    if (Serial.available()) {
    String input = Serial.readStringUntil('\n');
    int steps = input.toInt();
    myStepper.step(steps);
    Serial.println("DONE");
    }
  int estadoSensorInicio = digitalRead(sensorPinInicio);
  int estadoSensorLuz = digitalRead(sensorPinLuz);
  if (estadoSensorInicio == LOW) { 
     Serial.println("Ovo posicao inicial");
  } 
  else
  { 
     Serial.println("Nenhum objeto na área."); 
  } 
  if (estadoSensorLuz == LOW) { 
     Serial.println("Ovo posicao Luz");
  } 
  else
  { 
     Serial.println("Nenhum objeto na área."); 
  }
  int valor_pwm = 0;  // Variável para armazenar o valor PWM (0-255)

  // Aumenta a velocidade gradualmente de 0% a 100% no sentido horário
  for (valor_pwm = 0; valor_pwm < 256; valor_pwm++) {
    analogWrite(PINO_IN1, valor_pwm);  // Aplica o valor PWM no pino IN1
    delay(10);  // Espera 100 ms antes de aumentar a velocidade
  }
 
  // Diminui a velocidade gradualmente de 100% a 0% no sentido horário
  for (valor_pwm = 255; valor_pwm >= 0; valor_pwm--) {
    analogWrite(PINO_IN1, valor_pwm);  // Reduz o valor PWM no pino IN1
    delay(10);  // Espera 100 ms antes de diminuir mais a velocidade
  }
  delay(200); // Pequeno intervalo para evitar leituras rápidas demais
}