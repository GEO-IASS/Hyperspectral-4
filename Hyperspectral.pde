// 4 images display
// potentiometer position

import processing.serial.*;

PImage[] img;

int picAlpha = 255;
//variables
int nb_images=4;
int no_image=0;


float Pot1 = 0;
float Pot2 = 0;
float Pot3 = 0;

Serial myPort;


void setup() {
  size(1280, 1024, P3D);

  img = new PImage[nb_images];
  for (int i=0; i<nb_images; i++) {
    img[i] = loadImage(i + ".png");
    noStroke();
    noCursor();
  }


  // List all the available serial ports
  println(Serial.list());
  // I know that the first port in the serial list on my mac
  // is always my Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[1], 9600);
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
}

void draw() {
  no_image = int(map(mouseX, 0, width, 0, nb_images));
  background(img[no_image]);
}




void serialEvent(Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // split the string on the commas and convert the
    // resulting substrings into an integer array:
    float[] potvalue = float(split(inString, ","));
    // if the array has at least three elements, you know
    // you got the whole thing. Put the numbers in the
    // potvalue variables:
    if (potvalue.length >=3) {
      // map them to the range 0-255:
      Pot1 = map(potvalue[0], 0, 1023, 0, 3);
      Pot2 = map(potvalue[1], 0, 1023, 0, 255);
      Pot3 = map(potvalue[2], 0, 1023, 0, 255);
    }
  }
}

