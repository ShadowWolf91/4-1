#define LED_PIN 9
#define LED_PIN2 5
#define POT_PIN A0
void setup()
{
 pinMode(LED_PIN, OUTPUT);
 pinMode(LED_PIN2, OUTPUT);
 pinMode(POT_PIN, INPUT);
}
void loop()
{
 int rotation, brightness1, rotation2, brightness2; 
 rotation = analogRead(POT_PIN);
 brightness1 = rotation / 4;
 brightness2 = brightness1 / 8;
 analogWrite(LED_PIN, brightness1);
  analogWrite(LED_PIN2, brightness2);

}