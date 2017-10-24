// Arduino for: 
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
//This is an open source and copyleft project.


import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

void setupSerial(int _index) {
  printArray(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[_index], 57600);
  for (int i = 0; i <= 13; i++)
    arduino.pinMode(i, Arduino.INPUT);
}