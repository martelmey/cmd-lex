const int switchPin = 2;
const int motorPin = 9;
int switchState = 0;

void setup() {
  pinMode(motorPin, OUTPUT);
  pinMode(switchPin, INPUT);
}

void loop() {
  switchState = digitalRead(switchPin);

  if(switchPin == HIGH) {
    digitalWrite(motorPin, HIGH);
  }
  else {
    digitalWrite(motorPin, LOW);
  }
}
