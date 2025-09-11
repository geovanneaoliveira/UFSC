// Adiciona as bibliotecas utilizadas no código
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BMP280.h>
#define SEALEVELPRESSURE_HPA (1022.50)
// Cria um objeto para o sensor BMP280
Adafruit_BMP280 bmp;

void setup() {
 
  // Inicia a comunicação serial
  Serial.begin(115200);

  // Inicia o sensor BMP280
  if (!bmp.begin(0x76)) {
    Serial.println("Não foi possível encontrar um sensor BMP280 válido. Verifique a conexão!");
    while (1);
  }
}

void loop() {

  // Faz a leitura de pressão e temperatura
  float temperatura = bmp.readTemperature();
  float pressao = bmp.readPressure() / 100.0;

  Serial.print("Temperatura: ");
  Serial.print(temperatura);
  Serial.println(" °C");

  Serial.print("Pressão: ");
  Serial.print(pressao);
  Serial.println(" hPa");

  Serial.print("Approx. Altitude = ");
  Serial.print(bmp.readAltitude(SEALEVELPRESSURE_HPA));
  Serial.println(" m");
  delay(2000);
}