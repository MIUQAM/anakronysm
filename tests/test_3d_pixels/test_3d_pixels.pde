import processing.video.*;
import processing.opengl.*;
import de.voidplus.leapmotion.*;

LeapMotion leap;

Movie video;
PImage brush;

PGraphics pass1;

ArrayList<FingerMask> fingerMaskArray = new ArrayList<FingerMask>();

PShader zPixels;
PShader colorizeCircle;
float circleRadius = 100.0;

void setup() {
  size(800, 600, OPENGL);
  
  leap = new LeapMotion(this);

  video = new Movie(this, "../../../data/videos/Through_The_Mirror.mp4");
  video.play();  
  video.loop();

  pass1 = createGraphics(width, height, OPENGL);
  pass1.beginDraw();
  pass1.endDraw();

  for (int i = 0; i < 5; i++) {
    fingerMaskArray.add(new FingerMask());
  }

  colorizeCircle = loadShader("colorizeCircle.glsl");

  brush = loadImage("brush.png");
}


void draw() {
  if (video.available()) {
    video.read();
  }

  updateLeap();

  updatePass1();

  background(0);
  image(pass1, 0, 0);

  if (frameCount % 30 == 1) {
    int fps = Math.round(frameRate);
    frame.setTitle(fps + "fps");
  }

}

void updateLeap(){

  int fps = leap.getFrameRate();

  if(leap.getHands().size() > 0){
    for(Hand hand : leap.getHands()){
      // ========= FINGERS =========

      for(Finger finger : hand.getFingers()){


        // ----- BASICS -----

        int     finger_id         = finger.getId();
        PVector finger_position   = finger.getPosition();
        PVector finger_stabilized = finger.getStabilizedPosition();
        PVector finger_velocity   = finger.getVelocity();
        PVector finger_direction  = finger.getDirection();
        float   finger_time       = finger.getTimeVisible();


        // ----- SPECIFIC FINGER -----
        fingerMaskArray.get(finger.getType()).update(finger_position);
      }
    }
  } else {

    for (FingerMask fm : fingerMaskArray) {
      fm.update(false);
    }
  }
}

// ========= CALLBACKS =========

void leapOnInit(){
    // println("Leap Motion Init");
}
void leapOnConnect(){
    // println("Leap Motion Connect");
}
void leapOnFrame(){
    // println("Leap Motion Frame");
}
void leapOnDisconnect(){
    // println("Leap Motion Disconnect");
}
void leapOnExit(){
    // println("Leap Motion Exit");
}

void updatePass1() {

  pass1.beginDraw();
  pass1.clear();

  //pass1.tint(255,10);
  rotateY(frameCount/5);
  pass1.image(video, 0, 0, width, height);


  pass1.loadPixels();

  for (int i = 0; i < pass1.height; i+=2) {
    for (int j = 0; j < pass1.width; j+=2) {
      noFill();
      int index = getCurrentPixelIndex(j, i);

      stroke(getRed(pass1.pixels[index]), getGreen(pass1.pixels[index]), getBlue(pass1.pixels[index]));

      point(j, i, getBrightness(pass1.pixels[index]));
    }
    
  }

  //deform.set("resolution", width, height);
  //pass1.shader(deform);
  //pass1.shader(sepialize);
  //pass1.shader(zPixels);
  //pass1.shader(blackAndWhite);
  //fisheye.set("aperture", 180.0);
  //pass1.shader(fisheye);
  /*swirl.set("angle", 100);
  swirl.set("radius", 100);
  swirl.set("center", width/2, height/2);
  pass1.shader(swirl);*/
  //pass1.image(video, 0, 0, width, height);
  //pass1.resetShader();

  pass1.endDraw();
}

// Fonction qui retourne l'index du pixel à la position courante, dans le tableau des pixels
int getCurrentPixelIndex(int _posX, int _posY) {
  return int(constrain((_posY*width)+_posX, 0, pass1.width*pass1.height-1));
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

// Retourne la valeur de luminosité d'une couleur passée en paramètre.
float getBrightness(color c){
  colorMode(HSB);
  float brightnessValue = (c & 0xFF);
  colorMode(RGB);

  //float brightnessValue = getRed(c)*0.2126 + getGreen(c)*0.7152 + getBlue(c)*0.0722;
  return brightnessValue;
}