#include <WiFi.h>
#include "esp_wpa2.h"  // Necessário para WPA2-Enterprise

const char* ssid = "eduroam";
const char* EAP_IDENTITY = "";  // Substitua pelo seu IdUFSC
const char* EAP_PASSWORD = "";            // Substitua pela sua senha

void setup() {
  Serial.begin(115200);
  delay(1000);

  WiFi.disconnect(true);
  WiFi.mode(WIFI_STA);

  Serial.print("MAC: ");
  Serial.println(WiFi.macAddress());
  Serial.printf("Conectando ao %s...\n", ssid);

  // Configuração do WPA2-Enterprise sem certificado
  esp_wifi_sta_wpa2_ent_set_identity((uint8_t*)EAP_IDENTITY, strlen(EAP_IDENTITY));
  esp_wifi_sta_wpa2_ent_set_username((uint8_t*)EAP_IDENTITY, strlen(EAP_IDENTITY));
  esp_wifi_sta_wpa2_ent_set_password((uint8_t*)EAP_PASSWORD, strlen(EAP_PASSWORD));
  esp_wifi_sta_wpa2_ent_enable();

  WiFi.begin(ssid);
}

void loop() {
  if (WiFi.status() == WL_CONNECTED) {
    Serial.print("Conectado! IP: ");
    Serial.println(WiFi.localIP());
    delay(60000);  // Apenas para evitar prints contínuos
  } else {
    Serial.print(".");
    delay(500);
  }
}
