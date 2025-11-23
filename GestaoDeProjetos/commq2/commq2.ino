#include <Arduino.h>
#include "DHT.h"

// --- Pin definitions ---
#define DHTPIN 23
#define DHTTYPE DHT11

#define PIR_PIN 22
#define LED_PIN 21
#define MQ2_PIN 34

// --- DHT setup ---
DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(115200);
  delay(1000);
  Serial.println("Initializing sensors...");

  // Initialize pins
  pinMode(LED_PIN, OUTPUT);
  pinMode(PIR_PIN, INPUT);
  pinMode(MQ2_PIN, INPUT);

  // LED always ON
  digitalWrite(LED_PIN, HIGH);

  // Initialize DHT sensor
  dht.begin();

  Serial.println("Setup complete.");
}

void loop() {
  // --- Read DHT11 ---
  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature();

  if (isnan(humidity) || isnan(temperature)) {
    Serial.println("⚠️ Failed to read from DHT11 sensor!");
  } else {
    Serial.print("🌡 Temperature: ");
    Serial.print(temperature);
    Serial.print(" °C  |  💧 Humidity: ");
    Serial.print(humidity);
    Serial.println(" %");
  }

  // --- Read PIR sensor ---
  int motion = digitalRead(PIR_PIN);
  if (motion == HIGH) {
    Serial.println("🚶 Motion detected!");
  } else {
    Serial.println("No motion.");
  }

  // --- Read MQ2 gas sensor ---
  int gasValue = analogRead(MQ2_PIN);
  Serial.print("🔥 MQ2 Value: ");
  Serial.println(gasValue);

  Serial.println("-----------------------------");
  delay(2000);  // read every 2 seconds
}
