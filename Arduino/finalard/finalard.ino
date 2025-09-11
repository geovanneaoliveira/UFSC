#include <Servo.h>

// === Pin Definitions ===
const int SENSOR_START = 6;     // Proximity sensor 1
const int SENSOR_LUZ  = 7;      // Proximity sensor 2
const int PINO_IN1     = 8;     
const int PINO_IN2     = 9;     // Motor driver input (PWM-capable)
const int valor_pwm    = 150;   // PWM duty cycle
const int PINO_SERVO = 5;
Servo myservo;
// === State Variables ===
bool serialStartCommand = false;
bool motorLigado = false;
String serialInput = "";
String lastCommand = "";
void startMotor();
void stopMotor();
void resetMotor();
void resetAntiMotor();

void setup() {
  pinMode(SENSOR_START, INPUT);
  pinMode(SENSOR_LUZ, INPUT);
  pinMode(PINO_IN1, OUTPUT);
  analogWrite(PINO_IN1, 0);
  analogWrite(PINO_IN2, 0);
  myservo.attach(PINO_SERVO);  // attaches the servo on pin 9 to the servo object
  Serial.begin(9600);
  Serial.println("Aguardando comando e sensor para iniciar motor...");
}

void loop() {
  // === Check Serial Input ===
  bool sensorStartDetected = digitalRead(SENSOR_START) == LOW;
  bool sensorLuzDetected  = digitalRead(SENSOR_LUZ)  == LOW;
  if (Serial.available()) {
    String serialInput = Serial.readStringUntil('\n');
    Serial.println(serialInput);
    if (serialInput.equalsIgnoreCase("start motor")) {
        Serial.println("Comando serial recebido: start motor");
        lastCommand = "start motor";
        serialStartCommand = true;
        if (serialStartCommand && sensorStartDetected && !motorLigado) {
          Serial.println("Motor iniciara");
          startMotor();
        } else {
          lastCommand = "";
          Serial.println("Ovo não está na posicao inicial");
        }
        
    } else if (serialInput.equalsIgnoreCase("force embriao")) {
        Serial.println("Comando serial recebido: force embriao");
        lastCommand = "force embriao";
        serialStartCommand = true;
        if (serialStartCommand && sensorStartDetected && !motorLigado) {
          Serial.println("Motor iniciara force");
          startMotor();
        } else {
          lastCommand = "";
          Serial.println("Ovo não está na posicao inicial");
        }
    } else if (serialInput.equalsIgnoreCase("stop motor")) {
        lastCommand = "stop motor";
        if (motorLigado) {
          stopMotor();
        }
        serialStartCommand = false;
        Serial.println("Comando serial recebido: stop motor");
    } else if (serialInput.equalsIgnoreCase("reset motor")) {
        lastCommand = "reset motor";
        resetMotor();
        serialStartCommand = false;
        Serial.println("Comando serial recebido: reset motor");
    } else if (serialInput.equalsIgnoreCase("ovo improprio")) {
        lastCommand = "ovo improprio";
        resetMotor();
        Serial.println("Comando serial recebido: ovo improrio");
    } else if (serialInput.equalsIgnoreCase("ovo para incubar")) {
        lastCommand = "ovo para incubar";
        resetAntiMotor();
        Serial.println("Comando serial recebido: ovo para incubar");
    } else if (serialInput.equalsIgnoreCase("ovo para consumo")) {
        lastCommand = "ovo para consumo";
        resetMotor();
        Serial.println("Comando serial recebido: ovo para consumo");
    } else {
        Serial.print("Comando inválido: ");
        Serial.println(serialInput);
      }
    }
    if (lastCommand.equalsIgnoreCase("start motor") && sensorLuzDetected){
        Serial.println("Ovo chegou, parando motor");
        lastCommand = "";
        stopMotor();
    }
}

void atuaServo(int sentido) {

}

// === Motor control functions ===
void startMotor() {
  analogWrite(PINO_IN1, valor_pwm);
  motorLigado = true;
  Serial.println("Motor LIGADO");
}

void stopMotor() {
  analogWrite(PINO_IN1, 0);
  motorLigado = false;
  Serial.println("Motor DESLIGADO");
}

void resetMotor() {
  bool sensorStartDetected = digitalRead(SENSOR_START) == LOW;
  while(!sensorStartDetected) {
    motorLigado = true;
    analogWrite(PINO_IN1, valor_pwm);
    sensorStartDetected = digitalRead(SENSOR_START) == LOW;
  }
  analogWrite(PINO_IN1, 0);
  Serial.println("Esteira resetou");
  motorLigado = false;
  Serial.println("Motor DESLIGADO");
}

void resetAntiMotor() {
  bool sensorStartDetected = digitalRead(SENSOR_START) == LOW;
  while(!sensorStartDetected) {
    motorLigado = true;
    analogWrite(PINO_IN2, valor_pwm);
    sensorStartDetected = digitalRead(SENSOR_START) == LOW;
  }
  analogWrite(PINO_IN2, 0);
  Serial.println("Esteira resetou");
  motorLigado = false;
  Serial.println("Motor DESLIGADO");
}