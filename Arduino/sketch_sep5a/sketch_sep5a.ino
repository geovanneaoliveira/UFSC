/*
   ESP32 - 4 Channel Relay Module Control
   Each relay is connected to one GPIO pin
   Relays are active LOW (most relay modules)
*/

#define RELAY1  25   // GPIO pin for relay 1
#define RELAY2  26   // GPIO pin for relay 2
#define RELAY3  27   // GPIO pin for relay 3
#define RELAY4  14   // GPIO pin for relay 4

void setup() {
  // Initialize serial monitor
  Serial.begin(115200);

  // Set relay pins as outputs
  pinMode(RELAY1, OUTPUT);
  pinMode(RELAY2, OUTPUT);
  pinMode(RELAY3, OUTPUT);
  pinMode(RELAY4, OUTPUT);

  // Initialize relays OFF (HIGH = off for active LOW modules)
  digitalWrite(RELAY1, HIGH);
  digitalWrite(RELAY2, HIGH);
  digitalWrite(RELAY3, HIGH);
  digitalWrite(RELAY4, HIGH);

  Serial.println("Relay control initialized!");
}

void loop() {
  // Example: sequentially turn on/off relays
  Serial.println("Relay 1 ON");
  digitalWrite(RELAY1, LOW);  // turn ON relay
  delay(1000);
  digitalWrite(RELAY1, HIGH); // turn OFF relay

  Serial.println("Relay 2 ON");
  digitalWrite(RELAY2, LOW);
  delay(1000);
  digitalWrite(RELAY2, HIGH);

  Serial.println("Relay 3 ON");
  digitalWrite(RELAY3, LOW);
  delay(1000);
  digitalWrite(RELAY3, HIGH);

  Serial.println("Relay 4 ON");
  digitalWrite(RELAY4, LOW);
  delay(1000);
  digitalWrite(RELAY4, HIGH);

  Serial.println("Cycle finished!\n");
  delay(2000);
}
