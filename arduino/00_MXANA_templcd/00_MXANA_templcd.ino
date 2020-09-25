#include <Arduino.h>
#include <Wire.h>
#include "SHT31.h"
#include "rgb_lcd.h"
// Objects
SHT31 sht31 = SHT31();
rgb_lcd lcd;
// Vars
const int colorR = 0;
const int colorG = 0;
const int colorB = 255;

void setup() {
    Serial.begin(9600);
    // sht31
    while (!Serial);
    Serial.println("begin...");
    sht31.begin();
    //rgb_lcd
    lcd.begin(16, 2);
    lcd.setRGB(colorR, colorG, colorB);
    delay(1000);
}

void loop() {
    // get & print temp
    float temp = sht31.getTemperature();
    float hum = sht31.getHumidity();
    Serial.print("\nTemp = \t");
    Serial.print(temp);
    Serial.println("\t C");
    Serial.print("\nHum = \t");
    Serial.print(hum);
    Serial.println("%");
    Serial.println();
    delay(1000);
    // print to lcd
    lcd.setCursor(0, 0);
    lcd.print("Temp: ");
    lcd.print(temp);
    lcd.setCursor(0, 1);
    lcd.print("RH: ");
    lcd.print(hum);
    delay(1000);
}
