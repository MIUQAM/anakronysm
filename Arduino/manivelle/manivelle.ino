#define ENCODER_A 2
#define ENCODER_B 3

volatile boolean encoderMoved = false;
volatile byte encoderValue = 0;
volatile int relativeValue = 0;
volatile int directionValue = 0;
volatile int oldDirectionValue = 0;
volatile int newDirectionValue = 0;

void setup() {

  Serial.begin (57600);
  
  pinMode(ENCODER_A, INPUT_PULLUP); // turn interal pullup resistor on.
  pinMode(ENCODER_B, INPUT_PULLUP); // turn interal pullup resistor on.
  
  // call updateEncoder() when any high/low changed seen
  // on interrupt 0 (pin 2), or interrupt 1 (pin 3) :
  attachInterrupt(0, updateEncoder, CHANGE);
  attachInterrupt(1, updateEncoder, CHANGE);
}

void loop(){
  
  if ( encoderMoved ) {
    encoderMoved = false;    
    Serial.print("dir ");
    Serial.println(newDirectionValue);
  }

}


void updateEncoder(){

  encoderMoved = true;
  
  byte MSB = digitalRead(ENCODER_A); //MSB = most significant bit
  byte LSB = digitalRead(ENCODER_B); //LSB = least significant bit
  
  byte newEncodedValue = (MSB << 1) | LSB; //converting the 2 pin value to single number
  byte old_vs_new  = (encoderValue << 2) | newEncodedValue; //adding it to the previous encoded value
  
  //if( old_vs_new == B1101 ||  old_vs_new == B0100 ||  old_vs_new == B0010 ||  old_vs_new == B1011) relativeValue ++;
  //if( old_vs_new == B1110 ||  old_vs_new == B0111 ||  old_vs_new == B0001 ||  old_vs_new == B1000) relativeValue --;
  
  if( old_vs_new == B1101 ||  old_vs_new == B0100 ||  old_vs_new == B0010 ||  old_vs_new == B1011) directionValue = 1;
  if( old_vs_new == B1110 ||  old_vs_new == B0111 ||  old_vs_new == B0001 ||  old_vs_new == B1000) directionValue = -1;
  
  if(oldDirectionValue == directionValue)
    newDirectionValue = directionValue;
  
  oldDirectionValue = directionValue;
  
  encoderValue = newEncodedValue; //store this value for next time
}
