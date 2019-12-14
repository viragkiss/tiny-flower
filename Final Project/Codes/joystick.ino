/* Arduino Code for the Rainbow Tank project
 *  
 *  This program reads the X and Y coordinates from the joystick and
 *  sends these 2 figures to Processing using serial communication through ASCII codes
 *  and hand-shaking.
 */

// this is the pin for pressing the joystick like a mouse
// it is connected but not used in this project
//const int SW_pin = A0;

const int X_pin = A2; // analog pin connected to X output
const int Y_pin = A1; // analog pin connected to Y output

int Xcoord = 0;    // first analog sensor
int Ycoord = 0;   // second analog sensor
int inByte = 0;   // incoming serial byte

void setup() {

  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

void loop() {
   if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();
  }
  
  Xcoord = analogRead(A2);
  Ycoord = analogRead(A1);

  Serial.print(Xcoord);
  Serial.print(",");
  Serial.println(Ycoord);

}
