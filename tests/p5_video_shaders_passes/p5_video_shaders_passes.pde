import processing.video.*;
import processing.opengl.*;
import de.voidplus.leapmotion.*;

LeapMotion leap;

Movie video;
PImage brush;

PGraphics pass1;
PGraphics pass2;

boolean pass2Visible = false;
int pass2Alpha = 0;

ArrayList<FingerMask> fingerMaskArray = new ArrayList<FingerMask>();

PVector handPos = new PVector();

PShader sepialize;
PShader effect1;
PShader blackAndWhite;
PShader swirl;
PShader glow;
PShader fisheye;
PShader deform;
PShader zPixels;
PShader colorizeCircle;
PShader dataMosh;
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

  pass2 = createGraphics(width, height, OPENGL);
  pass2.beginDraw();
  pass2.endDraw();

  for (int i = 0; i < 5; i++) {
    fingerMaskArray.add(new FingerMask());
  }

  sepialize = loadShader("sepia.glsl");
  effect1 = loadShader("effect1.glsl");
  blackAndWhite = loadShader("bNw.glsl");
  //swirl = loadShader("swirl.frag", "swirl.vert");
  swirl = loadShader("swirl.glsl");
  deform = loadShader("deform.glsl");
  zPixels = loadShader("3dpixels.glsl");
  fisheye = loadShader("fisheye.glsl");
  dataMosh = loadShader("datamosh.glsl");
  glow = loadShader("glow.glsl");

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

    pass2Visible = true;

    for(Hand hand : leap.getHands()){

      handPos = hand.getPosition();

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

    pass2Visible = false;
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

  //deform.set("resolution", width, height);
  //pass1.shader(deform);
  //pass1.shader(sepialize);
  //pass1.shader(zPixels);
  //pass1.shader(blackAndWhite);

  //pass1.shader(swirl);
  
  //fisheye.set("aperture", (float)fingerMaskArray.get(0).posX);
  //pass1.shader(fisheye);
  /*swirl.set("angle", 100);
  swirl.set("radius", 100);
  swirl.set("center", width/2, height/2);*/

  pass1.shader(blackAndWhite);
  //pass1.shader(dataMosh);

  pass1.image(video, 0, 0, width, height);

  pass1.resetShader();

  pass1.endDraw();
}

void updatePass2() {

  if(pass2Visible && pass2Alpha < 255){
    pass2Alpha+=2;
  } else if(!pass2Visible && pass2Alpha > 0){
    pass2Alpha-=2;
  }
  //effect1.set("enable", true);
  effect1.set("a", norm(pass2Alpha, 0, 255));
  effect1.set("x", norm(handPos.x, 0, 800));
  effect1.set("y", norm(handPos.y, 0, 600));
  effect1.set("z", norm(handPos.z, 0, 200));


  pass2.beginDraw();
  pass2.clear();

  /*for (int i = 0; i < 5; i++) {
    colorizeCircle.set("maskTexture_f"+i, fingerMaskArray.get(i).draw());
  }

  pass2.shader(colorizeCircle);*/
  pass2.shader(effect1);

  pass2.image(video, 0, 0, width, height);
  pass2.resetShader();

  pass2.endDraw();
}