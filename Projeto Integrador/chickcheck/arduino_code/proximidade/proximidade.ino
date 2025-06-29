const int sensorPin = 2; // Pino onde o sensor está conectado 
void setup() { 
  pinMode(sensorPin, INPUT); Serial.begin(9600); 
} 
void loop() { 
  int estadoSensor = digitalRead(sensorPin);
  if (estadoSensor == LOW) { 
     Serial.println("Objeto detectado!");
  } 
  else
  { 
     Serial.println("Nenhum objeto na área."); 
  } 
  delay(200); // Pequeno intervalo para evitar leituras rápidas demais
}