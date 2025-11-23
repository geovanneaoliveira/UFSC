#include <Arduino.h>
#include "DHT.h"

// --- Definições de pinos ---
#define LED1  2    // LED interno (ou externo)
#define LED2  4
#define LED3  16
#define LED4  17

#define PIR1  32   // Sensor de presença 1
#define PIR2  33   // Sensor de presença 2

#define DHTPIN  23  // Pino do DHT11
#define DHTTYPE DHT11

// --- Objetos e variáveis ---
DHT dht(DHTPIN, DHTTYPE);
unsigned long lastDHTRead = 0;
const unsigned long DHT_INTERVAL = 5000; // 5 segundos

void setup() {
  Serial.begin(115200);
  dht.begin();

  // Configura LEDs
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
  pinMode(LED4, OUTPUT);

  // Configura sensores PIR
  pinMode(PIR1, INPUT);
  pinMode(PIR2, INPUT);

  Serial.println("Sistema iniciado!");
}

void loop() {
  // --- Leitura dos sensores de presença ---
  int pir1State = digitalRead(PIR1);
  int pir2State = digitalRead(PIR2);

  // Aciona LEDs com base nos sensores PIR
  digitalWrite(LED1, pir1State);
  digitalWrite(LED2, pir2State);

  // LED3 pisca se qualquer movimento for detectado
  if (pir1State || pir2State) {
    digitalWrite(LED3, HIGH);
    delay(100);
    digitalWrite(LED3, LOW);
  }

  // --- Leitura periódica do DHT11 ---
  if (millis() - lastDHTRead >= DHT_INTERVAL) {
    lastDHTRead = millis();
    float temp = dht.readTemperature();
    float hum  = dht.readHumidity();

    if (isnan(temp) || isnan(hum)) {
      Serial.println("Erro ao ler o DHT11!");
    } else {
      Serial.print("Temperatura: ");
      Serial.print(temp);
      Serial.print(" °C | Umidade: ");
      Serial.print(hum);
      Serial.println(" %");

      // LED4 acende se estiver quente demais
      if (temp < 30) {
        digitalWrite(LED4, HIGH);
      } else {
        digitalWrite(LED4, LOW);
      }
    }
  }

  delay(100);
}
