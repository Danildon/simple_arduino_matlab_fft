#include <Arduino.h>

// ===================== Configuration =====================
constexpr uint8_t ADC_PIN = A0;            // ADC input pin
constexpr uint8_t LED_PIN = 12;            // LED output pin
constexpr unsigned long LED_INTERVAL_MS = 1000;  // LED blink interval
constexpr unsigned long SERIAL_INTERVAL_US = 50; // Minimum delay between serial prints (~20 kHz max)

// ===================== Global Variables =====================
unsigned long lastLedTime = 0;
bool ledState = false;

// Optional: time tracking for debugging
unsigned long lastSampleTime = 0;

// ===================== Setup =====================
void setup() {
  Serial.begin(115200);             // Initialize serial communication
  pinMode(ADC_PIN, INPUT);          // Set ADC pin as input
  pinMode(LED_PIN, OUTPUT);         // Set LED pin as output

  // Optional: indicate start of streaming
  Serial.println("START");
}

// ===================== Main Loop =====================
void loop() {
  unsigned long currentMicros = micros();
  unsigned long currentMillis = millis();

  // ----------- ADC Sampling and Streaming -----------
  uint16_t adcValue = analogRead(ADC_PIN);

  // Print ADC value over Serial
  Serial.println(adcValue);

  // Optional: measure time between samples
  lastSampleTime = currentMicros;

  // ----------- LED Blinking (Non-blocking) -----------
  if (currentMillis - lastLedTime >= LED_INTERVAL_MS) {
    lastLedTime += LED_INTERVAL_MS;
    ledState = !ledState;
    digitalWrite(LED_PIN, ledState ? HIGH : LOW);
  }
}
