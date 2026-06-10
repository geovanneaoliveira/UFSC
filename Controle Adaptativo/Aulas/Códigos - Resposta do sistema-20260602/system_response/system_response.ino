void ADC_Init(void);
void ADC_TIMER_Init(void);
uint16_t ADC_Read(void);

void PWM_Init(void);
void PWM_DutyCycle(uint16_t duty_cycle);

void Start_Sampling(void);
void Stop_Sampling(void);

// Sampling frequency = 40 Hz
#define PRESCALER 64
#define TOP 6249

// PWM frequency = 2000 Hz
#define PWM_PRESCALER 1
#define PWM_RESOLUTION 7999

// Input signal
#define N 200
float x[N] = {1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000,
1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000,
1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000,
1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000,
1.0392, 1.0787, 1.1146, 1.0111, 0.8652, 1.1065, 1.0813, 0.9147, 1.3597, 1.0379,
0.9951, 1.0838, 1.0305, 0.9954, 0.9292, 0.9461, 0.9852, 1.1178, 0.8647, 1.0009,
1.0597, 1.0865, 0.7569, 0.9839, 0.9124, 0.9985, 1.0426, 1.0336, 1.1112, 1.0889,
0.9273, 1.0316, 0.9717, 0.9889, 0.9026, 1.0354, 0.9749, 0.9002, 1.0086, 1.0736,
1.0371, 0.8950, 0.9143, 1.0548, 1.1980, 1.0440, 1.0119, 1.0529, 0.9101, 0.8781,
1.0457, 0.8753, 0.9345, 0.9217, 1.0345, 1.0785, 0.9991, 0.8746, 0.9949, 1.0508,
1.1040, 1.0605, 1.0910, 0.9921, 0.9673, 1.0508, 1.1468, 0.9938, 1.0169, 0.8838,
1.0732, 1.0646, 1.1638, 1.0337, 1.0171, 1.0190, 0.9441, 1.1853, 1.1440, 0.9641,
0.9304, 0.9264, 0.9070, 0.9867, 1.0263, 0.9250, 0.8451, 0.9706, 0.9697, 0.8695,
0.7599, 1.0229, 0.9360, 1.0931, 1.0386, 1.1000, 1.0216, 0.9707, 0.8356, 0.9104,
1.0296, 0.7841, 1.0998, 0.8738, 1.1363, 1.1791, 1.0639, 1.0468, 1.0094, 1.0269,
1.0541, 1.0797, 0.9637, 1.1467, 0.7538, 0.9858, 0.9114, 1.0231, 0.9819, 1.1309,
0.9695, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000,
1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000,
1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000,
1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000};

uint8_t en[N] = { 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
 1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
 1,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 0,  0,  0,  0,  0,  0,  0,  0,  0,  0};


uint8_t NEW_SAMPLE = 0;
float y[N], b1[N], a1[N];
uint16_t samples_obtained = 0;
uint8_t rx_buffer[10];

// ---------------------------------------------------------------------
void setup() {

  // Configures LED
  PORTB &= B01111111;
  DDRB |= B10000000;

  ADC_Init();
  PWM_Init();

  Serial.begin(115200);
  Serial.flush();
}

void loop() {
  
  // Checks if new data has arrived (and reads it is so)
  if (Serial.available() > 0) {

    // Checks if the command sent is to start sampling processing
    Serial.readBytes(rx_buffer, 2);
    if (rx_buffer[0] == 0x00 & rx_buffer[1] == 0x01) {
      samples_obtained = 0;
      Start_Sampling();
    }
  }

  if(NEW_SAMPLE = 1) {
    NEW_SAMPLE = 0;
    int n = samples_obtained -1;
    if (en[n] == 1) {
      //algoritmo rls
      // x[n], x[n-1], x[n-2], ..., y[n], y[n-1]
      b1 = 0.75;
      a1 = 0.5;

    } else {
      if(n == 0){
        b1[n] = 0;
        a1[n] = 0;
      } else {
        b1[n] = b1[n-1];
        a1[n] = a1[n-1];
      }
      
    }

  }

  if (samples_obtained == N) {
    // Stop sampling and turn off PWM signal
    Stop_Sampling();
    PWM_DutyCycle(0);
          
    // Turn off led
    PORTB &= B01111111;

    // Send data to PC
    Serial.write((uint8_t *)y, 4*N);
    Serial.write((uint8_t *)b1, 4*N);
    Serial.write((uint8_t *)a1, 4*N);
  }
}

// Updates system input
ISR(TIMER1_OVF_vect)
{
  OCR3B = uint16_t(x[samples_obtained]*1599.8);
}

// Measures the system output
ISR(ADC_vect){
  // Toggle LED
  PINB |= B10000000;

  //clear Timer 1 overflow flag
  TIFR1 |= B00000001;

  y[samples_obtained] = ADC_Read() * 0.004888; // 5/1023
  
  NEW_SAMPLE = 1;
  samples_obtained += 1;
}

// --------------------------------------------------------------------------------
// Configures TIMER3 to generate a PWM signal (at PE4 pin) with frequency equal to 1kHz and resolution of 1/2000
void PWM_Init(void)
{
  // Disable all interrupts
  cli();

  // Disable power reduction in TIMER1
  PRR1 &= B11110111;

  // Initialize control registers to default values
  TCCR3A = B00000000;
  TCCR3B = B00000000;
  TCCR3C = B00000000;

  // Waveform generation mode 15
  TCCR3A |= B00100011;
  TCCR3B |= B00011000;

  // Timer prescaler
  TCCR3B &= B11111000;

  switch (PWM_PRESCALER){
    case (1):
      TCCR3B |= B00000001;
    break;
    case (8):
      TCCR3B |= B00000010;
    break;
    case (64):
      TCCR3B |= B00000011;
    break;
    case(256):
      TCCR3B |= B00000100;
    break;
    case(1024):
      TCCR3B |= B00000101;
    break;
  }

  // Output compare register channel A
  OCR3A = PWM_RESOLUTION;

  // Output compare register channel B  
  OCR3B = 0;

  // Initialize timer counter
  TCNT3 = 0x0000;

  // Enable overflow interrupt
  TIMSK3 = B00000000;

  // Configures Output Pin (PE4)
  PORTE &= B11101111;
  DDRE |= B00010000;

  // Enable interrups
  sei();
}

void PWM_DutyCycle(uint16_t duty_cycle)
{
  OCR3B = duty_cycle;
}

void Start_Sampling(void)
{
  // Start conversion by selecting the clock source and prescaler
  TCCR1B &= B11111000;

  switch (PRESCALER) {
    case 1:  
      TCCR1B |= B00000001;
    break;
    case 8:
      TCCR1B |= B00000010;
    break;
    case 64:
      TCCR1B |= B00000011;
    break;
    case 256:
      TCCR1B |= B00000100;
    break;
    case 1024:
      TCCR1B |= B00000101;
    break;
  }
}

void Stop_Sampling(void)
{
  // No clock source (timer/counter 1 stopped)
  TCCR1B = B00000000;
}

// Configures TIMER1 to generate a overflow interruption at each 1/fs second
void ADC_TIMER_Init(void)
{
  // Disable all interrupts
  cli();

  // Disable power reduction in TIMER1
  PRR0 &= B11110111;

  // Initialize control registers to default values
  TCCR1A = B00000000;
  TCCR1B = B00000000;

  // Waveform generation mode 15
  TCCR1A |= B00000011;
  TCCR1B |= B00011000;

  // No clock source (timer/counter 1 stopped)
  TCCR1B |= B00000000;

  // Output compare register A
  OCR1A = TOP;

  // Initialize timer counter
  TCNT1 = 0x0000;

  // Enable overflow interrupt
  TIMSK1 = B00000001;

  // Enable interrups
  sei();
}

void ADC_Init(void)
{
  ADC_TIMER_Init();
  
  // Disable interrupts
  cli();

  // Disable power reduction in ADC
  PRR0 &= B11111110;

  // Voltage reference -> AVCC with external capacitor (see schematic of Arduino MEGA)
  // Right adjust result and MUX[4:0] -> 0000 
  ADMUX = B01000000;

  // clear MUX[5] and ADTS[2:0] bits
  ADCSRB &= B11110000;

  // Configure auto trigger source as Timer1 overflow
  ADCSRB |= B00000110;

  // ADC enable, Auto Trigger enable, Interrupt Enable, Prescaler 
  ADCSRA = B10101100;

  // Enable interrupts
  sei();
}

uint16_t ADC_Read(void)
{
  uint16_t data;

  data = ADCL;
  data = data | (ADCH << 8);

  return data;
}
