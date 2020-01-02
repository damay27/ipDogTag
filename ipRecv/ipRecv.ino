
void setup() {
 Serial.begin(9600); 
}

char byteArr[15];

void loop() {
  Serial.readBytesUntil('\n', byteArr, 15);
  Serial.println(byteArr);
  delay(500);
}
