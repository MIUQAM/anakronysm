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

ShadersManager shadersManager = new ShadersManager();

PShader sepialize;
PShader effect1;
PShader effect2;
PShader effect3;
PShader effect4;
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
  effect2 = loadShader("effect2.glsl");
  effect3 = loadShader("effect3.glsl");
  effect4 = loadShader("effect4.glsl");
  blackAndWhite = loadShader("bNw.glsl");
  colorizeCircle = loadShader("colorizeCircle.glsl");
  glow = loadShader("glow.glsl");

  /*shadersManager.add("effect1");
  shadersManager.add("effect2");
  shadersManager.add("effect3");
  shadersManager.add("effect4");
  shadersManager.add("colorizeCircle");*/
  shadersManager.add("glow");

  shadersManager.switchShader();

  brush = loadImage("brush.png");
}


void draw() {
  if (video.available()) {
    video.read();
  }

  updateLeap();

  updatePass1();
  updatePass2(shadersManager.getCurrentShader());

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

void keyPressed(){
  if(key == ' '){
    shadersManager.switchShader();
  }
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

void updatePass2(String fx) {

  pass2.beginDraw();
  


  if(pass2Visible && pass2Alpha < 255){
    pass2Alpha+=2;
  } else if(!pass2Visible && pass2Alpha > 0){
    pass2Alpha-=2;
  }

  if(fx.equals("effect1")){
    pass2.clear();
    effect1.set("a", norm(pass2Alpha, 0, 255));
    effect1.set("x", norm(handPos.x, 0, width));
    effect1.set("y", norm(handPos.y, 0, height));
    effect1.set("z", norm(handPos.z, 0, 200));
    pass2.shader(effect1);
    pass2.image(video, 0, 0, width, height);
  }

  else if(fx.equals("effect2")){
    pass2.clear();
    float x = map(handPos.x, 0, width, -1.0, 1.0);
    float y = map(handPos.y, 0, height, -1.0, 1.0);
    float z = map(handPos.z, 0, 100, 0, 20);
    
    effect2.set("a", norm(pass2Alpha, 0, 255));
    effect2.set("x", abs(x) + 0.1);
    effect2.set("y", abs(y) + 0.1);
    effect2.set("red", 1.0);
    effect2.set("green", 0.0);
    effect2.set("blue", 0.0);
    pass2.shader(effect2);
    pass2.image(video, x*z*4, y*z*4, width, height);
    pass2.resetShader();

    effect2.set("a", norm(pass2Alpha, 0, 255));
    effect2.set("x", abs(x) + 0.1);
    effect2.set("y", abs(y) + 0.1);
    effect2.set("red", 0.0);
    effect2.set("green", 1.0);
    effect2.set("blue", 0.0);
    pass2.shader(effect2);
    pass2.image(video, x*z*3, y*z*3, width, height);
    pass2.resetShader();

    effect2.set("a", norm(pass2Alpha, 0, 255));
    effect2.set("x", abs(x) + 0.1);
    effect2.set("y", abs(y) + 0.1);
    effect2.set("red", 0.0);
    effect2.set("green", 0.0);
    effect2.set("blue", 1.0);
    pass2.shader(effect2);
    pass2.image(video, x*z*2, y*z*2, width, height);

  }

  else if(fx.equals("effect3")){
    pass2.clear();
    float x = map(handPos.x, 0, width, -1.0, 1.0);
    float y = map(handPos.y, 0, height, -1.0, 1.0);
    float z = map(handPos.z, 0, 100, 0, 20);
    
    effect3.set("a", norm(pass2Alpha, 0, 255));
    effect3.set("x", abs(x) + 0.1);
    effect3.set("y", abs(y) + 0.1);
    effect3.set("red", 1.0);
    effect3.set("green", 0.0);
    effect3.set("blue", 0.0);
    pass2.shader(effect3);
    pass2.image(video, x*z*4, y*z*4, width, height);
    pass2.resetShader();

    effect3.set("a", norm(pass2Alpha, 0, 255));
    effect3.set("x", abs(x) + 0.1);
    effect3.set("y", abs(y) + 0.1);
    effect3.set("red", 0.0);
    effect3.set("green", 1.0);
    effect3.set("blue", 0.0);
    pass2.shader(effect3);
    pass2.image(video, x*z*3, y*z*3, width, height);
    pass2.resetShader();

    effect3.set("a", norm(pass2Alpha, 0, 255));
    effect3.set("x", abs(x) + 0.1);
    effect3.set("y", abs(y) + 0.1);
    effect3.set("red", 0.0);
    effect3.set("green", 0.0);
    effect3.set("blue", 1.0);
    pass2.shader(effect3);
    pass2.image(video, x*z*2, y*z*2, width, height);

  }

  else if(fx.equals("effect4")){
    pass2.clear();
    float x = map(handPos.x, 0, width, -1.0, 1.0);
    float y = map(handPos.y, 0, height, -1.0, 1.0);
    float z = map(handPos.z, 0, 100, 0, 20);
    
    effect4.set("a", norm(pass2Alpha, 0, 255));
    effect4.set("x", abs(x) + 0.1);
    effect4.set("y", abs(y) + 0.1);
    effect4.set("red", 1.0);
    effect4.set("green", 0.0);
    effect4.set("blue", 0.0);
    pass2.shader(effect4);
    pass2.image(video, x*z*4, y*z*4, width, height);
    pass2.resetShader();

    effect4.set("a", norm(pass2Alpha, 0, 255));
    effect4.set("x", abs(x) + 0.1);
    effect4.set("y", abs(y) + 0.1);
    effect4.set("red", 0.0);
    effect4.set("green", 1.0);
    effect4.set("blue", 0.0);
    pass2.shader(effect4);
    pass2.image(video, x*z*3, y*z*3, width, height);
    pass2.resetShader();

    effect4.set("a", norm(pass2Alpha, 0, 255));
    effect4.set("x", abs(x) + 0.1);
    effect4.set("y", abs(y) + 0.1);
    effect4.set("red", 0.0);
    effect4.set("green", 0.0);
    effect4.set("blue", 1.0);
    pass2.shader(effect4);
    pass2.image(video, x*z*2, y*z*2, width, height);

  }

  else if(fx.equals("glow")){
    pass2.clear();
    float x = map(handPos.x, 0, width, 0.0, 1.0);
    float y = map(handPos.y, 0, height, 0.0, 1.0);
    float z = map(handPos.z, 0, 100, 1.0, 0.85);
    glow.set("intensity", z);
    pass2.shader(glow);
    pass2.image(video, 0, 0, width, height);
  }

  else if(fx.equals("colorizeCircle")){
    pass2.clear();
    for (int i = 0; i < 5; i++) {
      colorizeCircle.set("maskTexture_f"+i, fingerMaskArray.get(i).draw());
    }
    pass2.shader(colorizeCircle);
    pass2.image(video, 0, 0, width, height);
  }

  pass2.resetShader();

  pass2.endDraw();
}