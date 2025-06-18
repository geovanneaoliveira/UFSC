#include <Ping.h>  //Imports the Ping Library

//Declare variables for the pins
int sensePin = 7;
int stepPin = 3;
int dirPin = 4;
int sleepPin = 8;
int emerStopPin = 2;
int ledPin = 13;

//Declare other global variables
int pos, oldPos = 100;
float MotorSpeed = .2;
long stepsToMove = 0;


Ping ping = Ping(sensePin);  //Creates a new Ping sensor class using pin 7

void setup(){
    Serial.begin(9600); //Starts a serial connection
    
    // Set in/out status of the pins, sensePin is set by the library
    pinMode(stepPin, OUTPUT);
    pinMode(dirPin, OUTPUT);
    pinMode(sleepPin, OUTPUT);
    pinMode(ledPin, OUTPUT);
    digitalWrite(sleepPin, LOW);
    digitalWrite(ledPin, LOW);
    // Attach a hardware interupt to the emergency stop pin
    attachInterrupt(0,emerStop, RISING); 
}

void loop(){
    // If data has been sent by the computer
    if (Serial.available()){
        //Read the data and get the return position
        pos = serial_reader();
    
        // Move the motor for valid positions
        if ((pos >= 0) && (pos <= 200)){
            stepsToMove = 8 * (pos - oldPos);
            if(stepsToMove != 0) {
                rotate(stepsToMove, MotorSpeed, dirPin, stepPin);
            }   
        }
        else{
            // Throw out invalid positions
            pos = oldPos;
        }
         // Get the data
         ping.fire(); // Coolest Line I have ever written
         
         oldPos = pos;  //Update the position holder
                
         // Send the data
         Serial.println(ping.centimeters());   
    }
}


// This function from www.bildr.org
void rotate(int steps, float motorSpeed, int dirPin, int stepPin){
    //rotate a specific number of microsteps (8 microsteps per step) - (negitive for reverse movement)
    //speed is any number from .01 -> 1 with 1 being fastest - Slower is stronger
    int dir = (steps > 0)? HIGH:LOW;
    steps = abs(steps);
  
    digitalWrite(dirPin,dir); //set the direction
  
    float usDelay = (1/motorSpeed) * 70;
  
    for(int i=0; i < steps; i++){  //one iteration for each motor step
        digitalWrite(stepPin, HIGH);
        delayMicroseconds(usDelay); 
  
        digitalWrite(stepPin, LOW);
        delayMicroseconds(usDelay);
        
    }
}


void emerStop(){
    //Stops all movement untill controller is reset
    digitalWrite(stepPin, LOW);
    digitalWrite(dirPin, LOW);
    digitalWrite(sleepPin, LOW);
    pinMode(sensePin, INPUT);
    Serial.print("Emergency Stop Activated");
    while (true){
      //Trapped in here forever, or untill you hit the reset button
    }
}

int serial_reader(){
    //interprits input from computer and returns a new motor position
    char data_buffer[3]; 
    int returnPos;
    char cmd = Serial.read();  //Read in the command charactor
    switch(cmd){
    case 'S': //  Emergency Stop
        emerStop();
        break;
    case 'D': // Go to Position and get data
        while(Serial.available() < 3){
        }
        for(int i=0;i<3;i++){
            data_buffer[i] = Serial.read();
        }
        returnPos = atoi(data_buffer);
        return returnPos;
    
    case 'E': // Enable motor
        digitalWrite(sleepPin, HIGH);
        digitalWrite(ledPin, HIGH);
        delay(10);
        return 201;
    case 'P': // Park Motor
        digitalWrite(sleepPin, LOW);
        digitalWrite(ledPin, LOW);
        return 201;
    default: //Bad command, throw out anything else in buffer
        Serial.flush();
        return 201;
    }
}
    
    
    
        
