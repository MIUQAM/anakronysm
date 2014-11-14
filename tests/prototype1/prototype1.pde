/**
* Project : anakronysm
* Author : marcantoinebrodeur, th3m4rio, Adaav, pierrelucgithub
* Version : 1.0.0
* Date : 14-11-2014
* Prototype 1
*/




/*

Movie

Example 

  import processing.video.*;
  Movie myMovie;

  void setup() {
    size(200, 200);
    myMovie = new Movie(this, "totoro.mov");
    myMovie.loop();
  }

  void draw() {
    tint(255, 20);
    image(myMovie, mouseX, mouseY);
  }

  // Called every time a new frame is available to read
  void movieEvent(Movie m) {
    m.read();
  }
  


frameRate() Sets the target frame rate
speed() Sets the relative playback speed
duration()  Returns length of movie in seconds
time()  Returns location of playback head in units of seconds
jump()  Jumps to a specific location
available() Returns "true" when a new movie frame is available to read.
play()  Plays movie one time and stops at the last frame
loop()  Plays a movie continuously, restarting it when it's over.
noLoop()  Stops the movie from looping
pause() Pauses the movie
stop()  Stops the movie
read()  Reads the current frame

*/

import processing.video.*;
Movie myMovie;

void setup() {
  size(480, 360);
  myMovie = new Movie(this, "Through_The_Mirror.mp4");
  myMovie.play();
}

void draw() {
  image(myMovie, 0, 0);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  m.loadPixels();

  for (int i=0; i < m.width; i++) {
    for (int j=0; j < m.height; j++) {
 
      color pixelCourant = m.pixels[getCurrentPixelIndex(i,j)];

      m.pixels[getCurrentPixelIndex(i,j)] = color(getBrightness(pixelCourant));
    }
  }

  m.updatePixels();
}




// Fonction qui retourne l'index du pixel à la position courante, dans le tableau des pixels
int getCurrentPixelIndex(int _posX, int _posY) {
  return int(constrain((_posY*width)+_posX, 0, width*height-1));
}


// Création de fonction personnalisées pour aller chercher les informations de couleurs
// Pour que ce soit plus rapide que les fonctions de base de processing.

// Retourne la valeur d'alpha d'une couleur passée en paramètre.
float getAlpha(color c){
  colorMode(RGB);
  return ((c >> 24) & 0xFF);
}

// Retourne la valeur de rouge d'une couleur passée en paramètre.
float getRed(color c){
  colorMode(RGB);
  return ((c >> 16) & 0xFF);
}

// Retourne la valeur de vert d'une couleur passée en paramètre.
float getGreen(color c){
  colorMode(RGB);
  return ((c >> 8) & 0xFF);
}

// Retourne la valeur de bleu d'une couleur passée en paramètre.
float getBlue(color c){
  colorMode(RGB);
  return (c & 0xFF);
}

// Retourne la valeur de teinte d'une couleur passée en paramètre.
float getHue(color c){
  colorMode(HSB);
  float hueValue = ((c >> 16) & 0xFF);
  colorMode(RGB);
  return hueValue;
}

// Retourne la valeur de saturation d'une couleur passée en paramètre.
float getSaturation(color c){
  colorMode(HSB);
  float saturationValue = ((c >> 8) & 0xFF);
  colorMode(RGB);
  return saturationValue;
}

// Retourne la valeur de luminosité d'une couleur passée en paramètre.
float getBrightness(color c){
  //colorMode(HSB);
  //float brightnessValue = (c & 0xFF);
  //colorMode(RGB);

  float brightnessValue = getRed(c)*0.2126 + getGreen(c)*0.7152 + getBlue(c)*0.0722;
  return brightnessValue;
}