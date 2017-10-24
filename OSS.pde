//Outer Space Signal
//by Lambert Segura
//20th October 2017
//Glasgow School of Art - IxD year 2, "Control" project
//
//lambert.segura@gmail.com
//www.lambertsegura.com
//Blog project: https://mc200s253e.wordpress.com/2017/09/29/control/
//Github: https://github.com/mc200s253e/OSS
//
//Participation and many thanks goes to Paul Maguire and Jennifer Sykes for their help on programmation.
//Special thanks to Elke Langenbucher for her support and help.
//
//This is an open source and copyleft project.
//I'm happy to share and spread what I've learned and the tool I created.

import processing.video.*;

Movie myMovie1, myMovie2, myMovie3, myMovie4;
Capture cam;

int counter = 0;
int cols, rows;
int videoScale;
int h;
int s;
int b;
int videoWidth = 1000;
int videoHeight = 600;
int maxScatter = 1000;
int newHeight = 0;
boolean randomScatter = false;
boolean playMovie1=true;
boolean playMovie2=true;
boolean playMovie3=true;
boolean playMovie4=true;


void setup() {
  fullScreen();
  //size (1280, 720);
  frameRate(30);
  noCursor();
  //printArray(Capture.list());
  setupSerial(1);

  myMovie1 = new Movie(this, "ch1.mp4");
  myMovie1.play();

  myMovie2 = new Movie(this, "ch2.mov");
  myMovie2.play();

  myMovie3 = new Movie(this, "ch3.mov");
  myMovie3.play();

  cam = new Capture(this, Capture.list()[18]);
  cam.start();
}

void draw ( ) {
  TintSlider01();
  TintSlider02();
  TintSlider03();
  TintSlider04();

  //KP (New height)
  int speed = int(map(arduino.analogRead(0), 0, 1023, -75, 75));
  newHeight = (newHeight+speed) % height;
  translate(0, newHeight);

  if (myMovie1.available()) {
    myMovie1.read();
  }
  if (myMovie2.available()) {
    myMovie2.read();
  }
  if (myMovie3.available()) {
    myMovie3.read();
  }
  if (cam.available() == true) {
    cam.read();
  }

  // Ionisation
  scatter(myMovie1);
  scatter(myMovie2);
  scatter(myMovie3);
  scatter(cam);

  //switches
  //R-> - Thunderstorm
  if (arduino.digitalRead(8)==1) {
    randomScatter = !randomScatter;
  }
  //Schmitt trigger - Threshold
  if (arduino.digitalRead(7)==1) {
    filter(THRESHOLD, 0.4);
  }
  //Cone - HSB
  if (arduino.digitalRead(6)==1) {
    colorMode(HSB, 255); //HSB: Hue Saturation Brightness
  } else {
    colorMode(RGB, 255);
  }


  //Rotary switch - blendMode()
  //wave - Blend
  if (arduino.digitalRead(1)==1) {
    blendMode(BLEND);
  } 
  //+ - Add
  if (arduino.digitalRead(2)==1) {
    blendMode(ADD);
  }
  //- - Subtract
  if (arduino.digitalRead(3)==1) {
    blendMode(SUBTRACT);
  }
  //≠ - Difference
  if (arduino.digitalRead(4)==1) {
    blendMode(DIFFERENCE);
  }
  //x - Multiply
  if (arduino.digitalRead(5)==1) {
    blendMode(MULTIPLY);
  }
}

void keyPressed() {
  switch(key) {

    //snapshot
  case 's':
    save("yourpicture" + counter + ".jpg");
    counter++;
    break;
  }
}

//Opacity - Fader 1 - Tint/Opacity ch1
void TintSlider01() {
  float opacity= map(arduino.analogRead(2), 0, 1023, 0, 255);
  tint(255, opacity);
  image(myMovie1, 0, 0, width, height);
}

//Eclipse - Fader 2 - Tint/Opacity ch2
void TintSlider02() {
  float opacity= map(arduino.analogRead(3), 0, 1023, 0, 255);
  tint(255, opacity);
  image(myMovie2, 0, 0, width, height);
}

// The Rover/The black moon - Fader 3 - Tint/Opacity ch3
void TintSlider03() {
  // change for the Arduino
  float opacity= map(arduino.analogRead(4), 0, 1023, 0, 255);
  tint(255, opacity);
  image(myMovie3, 0, 0, width, height);
}

//Ouroboros - Fader 4 - Tint/Opacity webcam
void TintSlider04() {
  // change for the Arduino
  float opacity= map(arduino.analogRead(5), 0, 1023, 0, 255);
  tint(255, opacity);
  image(cam, 0, 0, width, height);
}
