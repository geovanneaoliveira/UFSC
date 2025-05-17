#include <Stepper.h>

const int stepsPerRevolution = 200;
Stepper myStepper(stepsPerRevolution, 8, 9, 10, 11);

void setup() {
  Serial.begin(9600);
  myStepper.setSpeed(60); // RPM
}

void loop() {
  if (Serial.available()) {
    String input = Serial.readStringUntil('\n');
    int steps = input.toInt();
    myStepper.step(steps);
    Serial.println("DONE");
  }
}