void ADC_Init(void);
uint16_t ADC_Read(void);
void ADC_TIMER_Init(void);

void Start_Sampling();
void Stop_Sampling();

void PWM_Init(void);
void PWM_DutyCycle(uint16_t duty_cycle);

void TIMER4_Init(void);

// States of the state machine implemenred in the loop() function
typedef enum {
  IDLE = 0,
  NEW_SAMPLE
} STATUS;

// Global variables
uint16_t adc_value;
uint16_t control_value = 0;

uint16_t tx_buffer[3] = {0, 0, 0};
uint8_t rx_buffer[6];

uint16_t counter = 0;

STATUS operation_status = IDLE;

// Sampling frequency = 10 Hz
#define PRESCALER 256
#define TOP 6249

// PWM frequency = 2000 Hz
#define PWM_PRESCALER 1
#define PWM_RESOLUTION 7999

// ---------------------------------------------------------------------
void setup() {
  // put your setup code here, to run once:
    // PB7 to LOW
  PORTB &= B01111111;
  
  // Configure PB7 as output
  DDRB |= B10000000;

  TIMER4_Init();
  PWM_Init();

  ADC_Init();
  Serial.begin(115200);
  Serial.flush();

}

void loop() {
  // put your main code here, to run repeatedly:
  
  if (operation_status == NEW_SAMPLE) {    
    TCNT4 = 0x0000;
    tx_buffer[0] = adc_value;

    Serial.flush();
    Serial.write((uint8_t *)tx_buffer, 6);

    operation_status = IDLE;
  } 
  
  // Read data from PC
 if (Serial.available() >= 4) {

    Serial.readBytes(rx_buffer, 4);

    if (rx_buffer[0] == 0x00 & rx_buffer[1] == 0x01) {
      Start_Sampling();

    } else if (rx_buffer[0] == 0x00 & rx_buffer[1] == 0x02) {

      control_value = rx_buffer[2] | (rx_buffer[3] << 8); 

      tx_buffer[1] = TCNT4;
      tx_buffer[2] = control_value;

    } else if (rx_buffer[0] == 0x00 & rx_buffer[1] == 0x03) {
      PWM_DutyCycle(0);
      Stop_Sampling(); 
      Serial.flush();
    }
  }  
}

// ---------------------------------------------------------------------
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
  TCCR1B &= B11111000;
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

ISR(TIMER1_OVF_vect)
{
  PINB |= B10000000;

  PWM_DutyCycle(control_value);
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

ISR(ADC_vect){

  //clear Timer 1 overflow flag
  TIFR1 |= B00000001;

  adc_value = ADC_Read();
  
  operation_status = NEW_SAMPLE;
}

void TIMER4_Init(void)
{
  // Init timer counter
  TCNT4 = 0x0000;

  // Initialize timer control registers to default values
  TCCR4A = 0x00;
  TCCR4B = 0x00;
  TCCR4C = 0x00;

  // Set clock source to clk_io/64
  TCCR4B &= B11111000;  
  TCCR4B |= B00000011;

  // Enable TIMER4
  PRR1 &= B11101111;
}

// --------------------------------------------------------------------------------
// Configures TIMER3 to generate a PWM signal (at PE4 pin)
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
