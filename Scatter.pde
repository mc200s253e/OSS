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
//I'm happy to share and spread what I've learn and the tool I created.
//
// Scatter source code by Mark Kleback: https://github.com/markkleeb/VideoMixer/blob/master/scatter.pde


//Ionisation

void scatter(Movie movie) {
  float rs = 0;
  if (randomScatter) {
    //rs = random(10, 100);
    rs = noise((frameCount*10)*0.01)*100;
  }
  int scatterAmount = int(map(arduino.analogRead(1), 0, 5, 0, maxScatter) + rs); //0 - 5 : gives an heavy scatter (knob turned left) or a light snow (knob turned left)
  movie.loadPixels();
  //println(scatterAmount);
  for (int i = scatterAmount; i < movie.pixels.length-scatterAmount; i++) {
    float r = red(movie.pixels[i]);
    float g = green(movie.pixels[i]);
    float b = blue(movie.pixels[i]);

    int newIndex = i+int(random(scatterAmount*-1, scatterAmount));
    movie.pixels[newIndex] = color(r, g, b);
  }
  movie.updatePixels();
}

void scatter(Capture cam) {
  float rs = 0;
  if (randomScatter) {
    //rs = random(10, 100);
    rs = noise((frameCount*10)*0.01)*100;
  }
  int scatterAmount = int(map(arduino.analogRead(1), 0, 5, 0, maxScatter) + rs);
  cam.loadPixels();
  //println(scatterAmount);
  for (int i = scatterAmount; i < cam.pixels.length-scatterAmount; i++) {
    float r = red(cam.pixels[i]);
    float g = green(cam.pixels[i]);
    float b = blue(cam.pixels[i]);

    int newIndex = i+int(random(scatterAmount*-1, scatterAmount));
    cam.pixels[newIndex] = color(r, g, b);
  }
  cam.updatePixels();
}