import processing.video.*;
import de.voidplus.leapmotion.*;

LeapMotion leap;

Movie video;
PImage brush;

PGraphics pass1;
PGraphics pass2;

ArrayList<FingerMask> fingerMaskArray = new ArrayList<FingerMask>();

PShader sepialize;
PShader colorizeCircle;
float circleRadius = 100.0;

void setup() {
  size(800, 600, OPENGL);
  
  leap = new LeapMotion(this);

  video = new Movie(this, "Through_The_Mirror.mp4");
  video.play();  

  pass1 = createGraphics(width, height, OPENGL);
  pass1.beginDraw();
  pass1.endDraw();

  pass2 = createGraphics(width, height, OPENGL);
  pass2.beginDraw();
  pass2.endDraw();

  for (int i = 0; i < 5; i++) {
    fingerMaskArray.add(new FingerMask());
  }

  sepialize = loadShader("sepia.glsl");

  colorizeCircle = loadShader("colorizeCircle.glsl");

  brush = loadImage("brush.png");
}


void draw() {
  if (video.available()) {
    video.read();
  }

  updateLeap();

  updatePass1();
  updatePass2();

  background(0);
  image(pass1, 0, 0);
  image(pass2, 0, 0);

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

  pass1.shader(sepialize);
  pass1.image(video, 0, 0, width, height);
  pass1.resetShader();

  pass1.endDraw();
}

void updatePass2() {
  pass2.beginDraw();
  pass2.clear();

  for (int i = 0; i < 5; i++) {
    colorizeCircle.set("maskTexture_f"+i, fingerMaskArray.get(i).draw());
  }

  pass2.shader(colorizeCircle);
  pass2.image(video, 0, 0, width, height);
  pass2.resetShader();

  pass2.endDraw();
}

public class FingerMask {

  PGraphics circleMask;
  float posX;
  float posY;
  float size = 0.0;
  float sizeFactor = 2.0;
  boolean show = false;

  public FingerMask() {
    circleMask = createGraphics(width, height, OPENGL);
    circleMask.beginDraw();
    circleMask.endDraw();
  }

  void update(PVector fingerPos){
    posX = fingerPos.x;
    posY = fingerPos.y;
    size = fingerPos.z * sizeFactor;
    this.show = true;
  }

  void update(boolean isVisible){
    this.show = isVisible;
  }

  PGraphics draw(){
    circleMask.beginDraw();
    circleMask.fill(0, 10);
    circleMask.rect(0, 0, width, height);

    if(this.show){
      circleMask.fill(255, 25);
      circleMask.noStroke();
      circleMask.imageMode(CENTER);
      circleMask.image(brush, posX, posY, size, size);
    }
    circleMask.endDraw();

    return circleMask;
  }

}