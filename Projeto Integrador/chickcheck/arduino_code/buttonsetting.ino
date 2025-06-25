const int button1Pin = 2;
const int button2Pin = 3;

void setup() {
  pinMode(button1Pin, INPUT_PULLUP);
  pinMode(button2Pin, INPUT_PULLUP);
  Serial.begin(9600);
}

void loop() {
  if (digitalRead(button1Pin) == LOW) {
    Serial.println("BUTTON_1");
    delay(300);
  }

  if (digitalRead(button2Pin) == LOW) {
    Serial.println("STOP");
    delay(300);
  }
}
