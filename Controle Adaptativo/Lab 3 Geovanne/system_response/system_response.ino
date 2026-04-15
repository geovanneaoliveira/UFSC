void ADC_Init(void);
void ADC_TIMER_Init(void);
uint16_t ADC_Read(void);

void PWM_Init(void);
void PWM_DutyCycle(uint16_t duty_cycle);

void Start_Sampling(void);
void Stop_Sampling(void);
//Frequência da senoide: 5 Hz

// Sampling frequency = 100 Hz
#define PRESCALER 8
#define TOP 19999

// PWM frequency = 2000 Hz
#define PWM_PRESCALER 1
#define PWM_RESOLUTION 7999
//Duracao do sinal: 6 segundos

#define N 600
uint16_t x[N] = {4000, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
3999, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
3999, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
3999, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
3999, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
4000, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
4000, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
4000, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
3999, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
4000, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
4000, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
3999, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
3999, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505,
4000, 4494, 4940, 5294, 5521, 5599, 5521, 5294, 4940, 4494,
4000, 3505, 3059, 2705, 2478, 2400, 2478, 2705, 3059, 3505};

uint16_t y[N];
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

    // Checks if the received command is intended to initiate the sampling process
    Serial.readBytes(rx_buffer, 2);
    if (rx_buffer[0] == 0x00 & rx_buffer[1] == 0x01) {
      samples_obtained = 0;
      Start_Sampling();
    }
  }

  if (samples_obtained == N) {
    // Stop sampling and turn off PWM signal
    Stop_Sampling();
    PWM_DutyCycle(0);
          
    // Turn off led
    PORTB &= B01111111;

    // Send data to PC
    Serial.write((uint8_t *)y, 2*N);
  }
}

// Updates system input
ISR(TIMER1_OVF_vect)
{
  OCR3B = x[samples_obtained];
}

// Measures the system output
ISR(ADC_vect){
  // Toggle LED
  PINB |= B10000000;

  //clear Timer 1 overflow flag
  TIFR1 |= B00000001;

  y[samples_obtained] = ADC_Read();
  
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
