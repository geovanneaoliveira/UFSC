// Programa: Controlando um servo motor com Arduino (servo motor arduino code)
#include <Servo.h> // Inclui a biblioteca Servo para controlar servos
const int SENSOR_START = 6;     // Proximity sensor 1
const int SENSOR_LUZ  = 7;  
Servo meuServo; // Cria um objeto Servo para controlar o servo motor
int pos = 360; // Declara uma variável para controlar a posição do servo motor 

void setup() {
    Serial.begin(9600);  // Start serial communication at 9600 baud
    pinMode(SENSOR_START, INPUT);
    pinMode(SENSOR_LUZ, INPUT);
    meuServo.write(pos);
    meuServo.attach(5); // Associa o servo motor ao pino digital 6 do Arduino
     // Define a posição inicial do servo motor para 0 graus
}

void loop() {
    // meuServo.write(180);

    int posit =80 ;
    bool sensorStartDetected = digitalRead(SENSOR_START) == LOW;
    bool sensorLuzDetected  = digitalRead(SENSOR_LUZ)  == LOW;
    // Serial.println()
    // Serial.println()
    // Movimento do servo de 0 a 90 graus
    for (posit = 80; posit <= 190; posit++) {
        Serial.println(posit);
        meuServo.write(posit); // Define a posição atual do servo
        delay(40); // Aguarda 15 milissegundos antes de mover para a próxima posição
    }
    for (posit = 190; posit >= 0; posit--) {
        Serial.println(posit);
        meuServo.write(posit); // Define a posição atual do servo
        delay(40); // Aguarda 15 milissegundos antes de mover para a próxima posição
    }
     // Aguarda 1 segundo antes de iniciar o próximo moviment
}