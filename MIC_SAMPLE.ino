float x;
int t1,t2,t3;
int i=1;
int y[500];

void setup() {
	//bitSet(UCSR0A, U2X0);
	Serial.begin(115200);
	pinMode(A0,INPUT);
	pinMode(12,OUTPUT);
}

void loop() {
	t1=micros();
	y[i]=analogRead(A0);
	delay(10);
	t2=micros();
	Serial.println(t2-t1);
	digitalWrite(12,HIGH);
	delay(1000);
	digitalWrite(12,LOW);
	delay(1000);
	i=i+1;
}
