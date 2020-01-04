
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

Adafruit_SSD1306 display(128, 32, &Wire, 4);

void setup() {
 //Setup the serial port
 Serial.begin(9600);

 //Setup oled display
 if( display.begin(SSD1306_SWITCHCAPVCC, 0x3C) != 0) {
  Serial.println("Error setting up display");
 }

 //Clear the display before its first use
 display.clearDisplay();
 display.display();
 
}


void loop() {
  char byteArr[15];
  memset(byteArr, 0, 15);
  Serial.readBytesUntil('\n', byteArr, 15);
  if(byteArr[0] != 0) {
    String ipString(byteArr);
    Serial.println(ipString);
    
    display.clearDisplay();

    display.setTextColor(WHITE);
    display.setTextSize(1, 1);
    display.setCursor(49, 16);
    display.println(ipString);
  
    display.display();
  }
  
}
