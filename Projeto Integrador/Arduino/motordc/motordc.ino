// Programa: Controle de velocidade e direção de um motor Dc utilizando o módulo L298D

// Define os pinos de controle do motor ligados ao Arduino
#define PINO_IN1 6  // Pino responsável pelo controle no sentido horário
#define PINO_IN2 7  // Pino responsável pelo controle no sentido anti-horário
  
void setup(){ 
  // Configura os pinos de controle como saída
  pinMode(PINO_IN1, OUTPUT);  // Define o pino IN1 como saída
  pinMode(PINO_IN2, OUTPUT);  // Define o pino IN2 como saída
}
  
void loop() { 
  int valor_pwm = 127;  // Variável para armazenar o valor PWM (0-255)
  analogWrite(PINO_IN1, valor_pwm);  // Aplica o valor PWM no pino IN1
  // // Aumenta a velocidade gradualmente de 0% a 100% no sentido horário
  // for (valor_pwm = 0; valor_pwm < 127; valor_pwm++) {
  //   analogWrite(PINO_IN1, valor_pwm);  // Aplica o valor PWM no pino IN1
  //   delay(10);  // Espera 100 ms antes de aumentar a velocidade
  // }
 
  // // Diminui a velocidade gradualmente de 100% a 0% no sentido horário
  // for (valor_pwm = 127; valor_pwm >= 0; valor_pwm--) {
  //   analogWrite(PINO_IN1, valor_pwm);  // Reduz o valor PWM no pino IN1
  //   delay(10);  // Espera 100 ms antes de diminuir mais a velocidade
  // }


  // // Aumenta a velocidade gradualmente de 0% a 100% no sentido anti-horário
  // for (valor_pwm = 0; valor_pwm < 127; valor_pwm++) {
  //   analogWrite(PINO_IN2, valor_pwm);  // Aplica o valor PWM no pino IN2
  //   delay(10);  // Espera 100 ms antes de aumentar a velocidade
  // }
 
  // // Diminui a velocidade gradualmente de 100% a 0% no sentido anti-horário
  // for (valor_pwm = 127; valor_pwm >= 0; valor_pwm--) {
  //   analogWrite(PINO_IN2, valor_pwm);  // Reduz o valor PWM no pino IN2
  //   delay(10);  // Espera 100 ms antes de diminuir mais a velocidade
  // } 
}