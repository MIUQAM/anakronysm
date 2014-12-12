/**
* Project : anakronysm 
* Author : Pier-Olivier Bourgault, Marc-Antoine Brodeur, Alexandre d'Avignon, Erwan d'Orgeville, Pier Luc Marrier
* Author URI : http://github.com/MIUQAM
* License : MIT
* Version : 1.0.0
* 
*/


import de.voidplus.leapmotion.*;
import processing.opengl.*;
import processing.serial.*;

boolean fullscreen = true;

boolean debug = true;
Debugger debugger = new Debugger();

LeapMotion leap;
P5toMSPBridge bridge = new P5toMSPBridge("127.0.0.1", 5001);

/* ========= ARDUINO ============ */
String portName = "/dev/tty.usbmodem1451";
Serial serial;
String messageFirstElement = "";
int messageSecondElement = 0;
float manivelleValue = 0;
/* ============================== */


Videos video;
ArrayList<String> videos = new ArrayList<String>();
ArrayList<Integer> videosLengths = new ArrayList<Integer>();

Videos cadre;
ArrayList<String> cadreL = new ArrayList<String>();
ArrayList<Integer> cadreLengths = new ArrayList<Integer>();

Videos intro;
ArrayList<String> introL = new ArrayList<String>();
ArrayList<Integer> introLengths = new ArrayList<Integer>();

boolean screensaving = false;
TimeoutP5 timeoutScreenSaving;
TimeoutP5 timeoutEffectSwitch;

int tickCount = 0;

PImage brush;

PGraphics pass1;
PGraphics pass1Cadre;
PGraphics pass2;
PGraphics pass3;

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
PShader glow;
PShader glow2;
PShader colorizeCircle;


float speed = 0;
float glitchesOpacity;


int offset;

void setup() {
  size(1280, 720, OPENGL);
  frameRate(30);

  // Affiche les noms des ports.
  println(Serial.list());

  noCursor();


  try{
      serial = new Serial(this, portName, 57600);
      serial.bufferUntil(13);
  }catch (Exception e) {
      println("Couldn't connect to Arduino");
  }

  leap = new LeapMotion(this);


  setupVideos();

  pass1 = createGraphics(width, height, OPENGL);
  pass1.beginDraw();
  pass1.endDraw();

  pass1Cadre = createGraphics(width, height, OPENGL);
  pass1Cadre.beginDraw();
  pass1Cadre.endDraw();

  pass2 = createGraphics(width, height, OPENGL);
  pass2.beginDraw();
  pass2.endDraw();

  pass3 = createGraphics(width, height, OPENGL);
  pass3.beginDraw();
  pass3.endDraw();

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
  glow2 = loadShader("glow2.glsl");

  shadersManager.add("effect1");
  shadersManager.add("effect2");
  shadersManager.add("effect3");
  shadersManager.add("effect4");
  shadersManager.add("colorizeCircle");
  shadersManager.add("glow");
  shadersManager.add("glow2");
  //shadersManager.add("");

  shadersManager.switchShader();

  brush = loadImage("brush.png");

}


void draw() {
  //scale(2);
  noStroke();

  try {
    updateLeap();
  } catch (Exception e) {
  }

  checkScreenSaver();
  checkEffectChange();

    // intro.update();
    background(0);

    if(screensaving){
        intro.update();
        intro.setSpeed(1);
        image(intro.getPg(), 0, 0);
    }else{
        video.update();
        cadre.update();
        updatePass1();
        updatePass1Cadre();
        updatePass2(shadersManager.getCurrentShader());
        updatePass3(shadersManager.getCurrentShader());

        // image(lastPass1,0,0);
        // image(lastPass2,0,0)

        updateOffset();

        image(pass1, 0, 0 + offset);
        image(pass1Cadre, 0, 0);
        //image(photo, 0, 0);
        image(pass2, 0, 0 + offset);
        image(pass3, 0, 0);
        //image(video.getPg(), 0, 0);
        //image(cadre.getPg(), 0, 0);

        //image(pass2, 0, 0);
    }


    

  //bridge.send("modul8/ctrl_layer_movie_playDirection", abs(video.speed));

  //bridge.send("speed", abs(video.speed));
  //bridge.send("dir", abs(video.speed)/video.speed);
  //bridge.send("dir", video.direction);

  if(debug){
    if (frameCount % 30 == 1) {
      int fps = Math.round(frameRate);
      frame.setTitle(fps + "fps");
    }
    // debugger.draw();
  }

}

void updateOffset(){
  // offset = int( sin(this.video.getSpeed() * 9) * 100 );
  // sin(1/(x^1.2))
  // (2*sin(2*x*2*3.14159)/10/x)
  float x = this.video.getSpeed();
  // offset = int( sin(1/(pow(x, 1.2))) * 100);
  offset = int( (2*sin(2*x*2*3.14159)/10/x) * 100 );
  // println("offset: "+offset);
}

void setupVideos(){
   // videos.add("Main/Main");
   // videosLengths.add(44510);

  videos.add("pngs/Intro_v2/Intro_v2_");
  videosLengths.add(224);

  video = new Videos(this, videos, videosLengths);
  video.play();
  video.goToRandom();


  cadreL.add("videos/Film_strip/Film Strip 02_");
  cadreLengths.add(146);
  cadre = new Videos(this, cadreL, cadreLengths);
  cadre.play();
  cadre.opacityAffected = true;

  introL.add("pngs/Intro_v2/Intro_v2_");
  introLengths.add(224);
  intro = new Videos(this, introL, introLengths);
  intro.play();

  this.timeoutScreenSaving = new TimeoutP5(10000, false);
  this.timeoutScreenSaving.start();

  this.timeoutEffectSwitch = new TimeoutP5(15 * 1000, true);
  this.timeoutEffectSwitch.start();
}


void updateLeap(){

  int fps = leap.getFrameRate();

  if(leap.getHands().size() > 0){

    tickCount = 100;

    pass2Visible = true;

    for(Hand hand : leap.getHands()){

      handPos = hand.getPosition();

      bridge.send("x", handPos.x);
      bridge.send("y", handPos.y);
      bridge.send("z", handPos.z);

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

void updatePass1() {
  pass1.beginDraw();
  pass1.clear();

  blackAndWhite.set("a", 1.0);
  pass1.shader(blackAndWhite);

  pass1.image(video.getCurrentVideo().getPImage(), 0, 0, width, height);

  pass1.resetShader();

  pass1.endDraw();
}

void updatePass1Cadre() {
  pass1Cadre.beginDraw();
  pass1Cadre.clear();

  blackAndWhite.set("a", cadre.getOpacity());
  // println("cadre.getOpacity(): "+cadre.getOpacity());
  pass1Cadre.shader(blackAndWhite);

  pass1Cadre.image(cadre.getCurrentVideo().getPImage(), 0, 0, width, height);

  pass1Cadre.resetShader();

  pass1Cadre.endDraw();
}

void updatePass2(String fx) {

   //println("handPos.z: "+handPos.z); // 20 à 70
   //println("handPos.x: "+handPos.x); // 300 à 1150
   //println("handPos.y: "+handPos.y); // 300 à 640


  pass2.beginDraw();
  
  if(pass2Visible && pass2Alpha < 255){
    pass2Alpha+=25;
  } else if(!pass2Visible && pass2Alpha > 0){
    pass2Alpha-=5;
  }

  if(fx.equals("effect1")){
    pass2.clear();
    effect1.set("a", norm(pass2Alpha, 0, 255));
    effect1.set("x", norm(handPos.x, 300, 1150));
    effect1.set("y", norm(handPos.y, 300, 640));
    effect1.set("z", norm(handPos.z, 10, 70));
    pass2.shader(effect1);
    pass2.image(video.getCurrentVideo().getPImage(), 0, 0, width, height);
  }

  else if(fx.equals("effect2")){
    pass2.clear();
    float x = map(handPos.x, 300, 1150, -1.0, 1.0);
    float y = map(handPos.y, 300, 640, -1.0, 1.0);
    float z = map(handPos.z, 10, 70, 0, 20);
    
    effect2.set("a", norm(pass2Alpha, 0, 255));
    effect2.set("x", abs(x) + 0.25);
    effect2.set("y", abs(y) + 0.25);
    effect2.set("red", 1.0);
    effect2.set("green", 0.0);
    effect2.set("blue", 0.0);
    pass2.shader(effect2);
    pass2.image(video.getCurrentVideo().getPImage(), x*z*8, y*z*8, width, height);
    pass2.resetShader();

    effect2.set("a", norm(pass2Alpha, 0, 255));
    effect2.set("x", abs(x) + 0.25);
    effect2.set("y", abs(y) + 0.25);
    effect2.set("red", 0.0);
    effect2.set("green", 1.0);
    effect2.set("blue", 0.0);
    pass2.shader(effect2);
    pass2.image(video.getCurrentVideo().getPImage(), x*z*6, y*z*6, width, height);
    pass2.resetShader();

    effect2.set("a", norm(pass2Alpha, 0, 255));
    effect2.set("x", abs(x) + 0.25);
    effect2.set("y", abs(y) + 0.25);
    effect2.set("red", 0.0);
    effect2.set("green", 0.0);
    effect2.set("blue", 1.0);
    pass2.shader(effect2);
    pass2.image(video.getCurrentVideo().getPImage(), x*z*4, y*z*4, width, height);

  }

  else if(fx.equals("effect3")){
    pass2.clear();
    float x = map(handPos.x, 300, 1150, -1.0, 1.0);
    float y = map(handPos.y, 300, 640, -1.0, 1.0);
    float z = map(handPos.z, 10, 70, 0, 20);
    
    effect3.set("a", norm(pass2Alpha, 0, 255));
    effect3.set("x", abs(x) + 0.1);
    effect3.set("y", abs(y) + 0.1);
    effect3.set("red", 1.0);
    effect3.set("green", 0.0);
    effect3.set("blue", 0.0);
    pass2.shader(effect3);
    pass2.image(video.getCurrentVideo().getPImage(), x*z*4, y*z*4, width, height);
    pass2.resetShader();

    effect3.set("a", norm(pass2Alpha, 0, 255));
    effect3.set("x", abs(x) + 0.1);
    effect3.set("y", abs(y) + 0.1);
    effect3.set("red", 0.0);
    effect3.set("green", 1.0);
    effect3.set("blue", 0.0);
    pass2.shader(effect3);
    pass2.image(video.getCurrentVideo().getPImage(), x*z*3, y*z*3, width, height);
    pass2.resetShader();

    effect3.set("a", norm(pass2Alpha, 0, 255));
    effect3.set("x", abs(x) + 0.1);
    effect3.set("y", abs(y) + 0.1);
    effect3.set("red", 0.0);
    effect3.set("green", 0.0);
    effect3.set("blue", 1.0);
    pass2.shader(effect3);
    pass2.image(video.getCurrentVideo().getPImage(), x*z*2, y*z*2, width, height);

  }

  else if(fx.equals("effect4")){
    pass2.clear();
    float x = map(handPos.x, 300, 1150, -1.0, 1.0);
    float y = map(handPos.y, 300, 640, -1.0, 1.0);
    float z = map(handPos.z, 10, 70, 0, 20);
    
    effect4.set("a", norm(pass2Alpha, 0, 255));
    effect4.set("x", abs(x) + 0.1);
    effect4.set("y", abs(y) + 0.1);
    effect4.set("red", 1.0);
    effect4.set("green", 0.0);
    effect4.set("blue", 0.0);
    pass2.shader(effect4);
    pass2.image(video.getCurrentVideo().getPImage(), x*z*4, y*z*4, width, height);
    pass2.resetShader();

    effect4.set("a", norm(pass2Alpha, 0, 255));
    effect4.set("x", abs(x) + 0.1);
    effect4.set("y", abs(y) + 0.1);
    effect4.set("red", 0.0);
    effect4.set("green", 1.0);
    effect4.set("blue", 0.0);
    pass2.shader(effect4);
    pass2.image(video.getCurrentVideo().getPImage(), x*z*3, y*z*3, width, height);
    pass2.resetShader();

    effect4.set("a", norm(pass2Alpha, 0, 255));
    effect4.set("x", abs(x) + 0.1);
    effect4.set("y", abs(y) + 0.1);
    effect4.set("red", 0.0);
    effect4.set("green", 0.0);
    effect4.set("blue", 1.0);
    pass2.shader(effect4);
    pass2.image(video.getCurrentVideo().getPImage(), x*z*2, y*z*2, width, height);

  }

  else if(fx.equals("glow")){
    pass2.clear();
    float z = map(handPos.z, 10, 70, 0.75, .95);
    glow.set("a", norm(pass2Alpha, 0, 255));
    glow.set("intensity", z);
    pass2.shader(glow);
    pass2.image(video.getCurrentVideo().getPImage(), 0, 0, width, height);
  }

  else if(fx.equals("glow2")){
    pass2.clear();
    float z = map(handPos.z, 10, 70, 0.001, 0.02);
    glow2.set("a", norm(pass2Alpha, 0, 255));
    glow2.set("intensity", z);
    pass2.shader(glow2);
    pass2.image(video.getCurrentVideo().getPImage(), 0, 0, width, height);
  }

  else if(fx.equals("colorizeCircle")){
    pass2.clear();
    for (int i = 0; i < 5; i++) {
      colorizeCircle.set("maskTexture_f"+i, fingerMaskArray.get(i).draw());
    }
    pass2.shader(colorizeCircle);
    pass2.image(video.getCurrentVideo().getPImage(), 0, 0, width, height);
  }

  pass2.resetShader();

  pass2.endDraw();
}

void updatePass3(String fx) {

  // println("handPos.z: "+handPos.z);

  pass3.beginDraw();

  if(fx.equals("effect1")){
    pass3.clear();
    effect1.set("a", cadre.getOpacity() * norm(pass2Alpha, 0, 255));
    effect1.set("x", norm(handPos.x, 300, 1150));
    effect1.set("y", norm(handPos.y, 300, 640));
    effect1.set("z", norm(handPos.z, 10, 70));
    pass3.shader(effect1);
    pass3.image(cadre.getCurrentVideo().getPImage(), 0, 0, width, height);
  }

  else if(fx.equals("effect2")){
    pass3.clear();
    float x = map(handPos.x, 300, 1150, -1.0, 1.0);
    float y = map(handPos.y, 300, 640, -1.0, 1.0);
    float z = map(handPos.z, 10, 70, 0, 20);
    
    effect2.set("a", cadre.getOpacity() * norm(pass2Alpha, 0, 255));
    effect2.set("x", abs(x) + 0.25);
    effect2.set("y", abs(y) + 0.25);
    effect2.set("red", 1.0);
    effect2.set("green", 0.0);
    effect2.set("blue", 0.0);
    pass3.shader(effect2);
    pass3.image(cadre.getCurrentVideo().getPImage(), x*z*8, y*z*8, width, height);
    pass3.resetShader();

    effect2.set("a", cadre.getOpacity() * norm(pass2Alpha, 0, 255));
    effect2.set("x", abs(x) + 0.25);
    effect2.set("y", abs(y) + 0.25);
    effect2.set("red", 0.0);
    effect2.set("green", 1.0);
    effect2.set("blue", 0.0);
    pass3.shader(effect2);
    pass3.image(cadre.getCurrentVideo().getPImage(), x*z*6, y*z*6, width, height);
    pass3.resetShader();

    effect2.set("a", cadre.getOpacity() * norm(pass2Alpha, 0, 255));
    effect2.set("x", abs(x) + 0.25);
    effect2.set("y", abs(y) + 0.25);
    effect2.set("red", 0.0);
    effect2.set("green", 0.0);
    effect2.set("blue", 1.0);
    pass3.shader(effect2);
    pass3.image(cadre.getCurrentVideo().getPImage(), x*z*4, y*z*4, width, height);

  }

  else if(fx.equals("effect3")){
    pass3.clear();
    float x = map(handPos.x, 300, 1150, -1.0, 1.0);
    float y = map(handPos.y, 300, 640, -1.0, 1.0);
    float z = map(handPos.z, 10, 70, 0, 20);
    
    effect3.set("a", cadre.getOpacity() * norm(pass2Alpha, 0, 255));
    effect3.set("x", abs(x) + 0.1);
    effect3.set("y", abs(y) + 0.1);
    effect3.set("red", 1.0);
    effect3.set("green", 0.0);
    effect3.set("blue", 0.0);
    pass3.shader(effect3);
    pass3.image(cadre.getCurrentVideo().getPImage(), x*z*4, y*z*4, width, height);
    pass3.resetShader();

    effect3.set("a", cadre.getOpacity() * norm(pass2Alpha, 0, 255));
    effect3.set("x", abs(x) + 0.1);
    effect3.set("y", abs(y) + 0.1);
    effect3.set("red", 0.0);
    effect3.set("green", 1.0);
    effect3.set("blue", 0.0);
    pass3.shader(effect3);
    pass3.image(cadre.getCurrentVideo().getPImage(), x*z*3, y*z*3, width, height);
    pass3.resetShader();

    effect3.set("a", cadre.getOpacity() * norm(pass2Alpha, 0, 255));
    effect3.set("x", abs(x) + 0.1);
    effect3.set("y", abs(y) + 0.1);
    effect3.set("red", 0.0);
    effect3.set("green", 0.0);
    effect3.set("blue", 1.0);
    pass3.shader(effect3);
    pass3.image(cadre.getCurrentVideo().getPImage(), x*z*2, y*z*2, width, height);

  }

  else if(fx.equals("effect4")){
    pass3.clear();
    float x = map(handPos.x, 300, 1150, -1.0, 1.0);
    float y = map(handPos.y, 300, 640, -1.0, 1.0);
    float z = map(handPos.z, 10, 70, 0, 20);
    
    effect4.set("a", cadre.getOpacity() * norm(pass2Alpha, 0, 255));
    effect4.set("x", abs(x) + 0.1);
    effect4.set("y", abs(y) + 0.1);
    effect4.set("red", 1.0);
    effect4.set("green", 0.0);
    effect4.set("blue", 0.0);
    pass3.shader(effect4);
    pass3.image(cadre.getCurrentVideo().getPImage(), x*z*4, y*z*4, width, height);
    pass3.resetShader();

    effect4.set("a", cadre.getOpacity() * norm(pass2Alpha, 0, 255));
    effect4.set("x", abs(x) + 0.1);
    effect4.set("y", abs(y) + 0.1);
    effect4.set("red", 0.0);
    effect4.set("green", 1.0);
    effect4.set("blue", 0.0);
    pass3.shader(effect4);
    pass3.image(cadre.getCurrentVideo().getPImage(), x*z*3, y*z*3, width, height);
    pass3.resetShader();

    effect4.set("a", cadre.getOpacity() * norm(pass2Alpha, 0, 255));
    effect4.set("x", abs(x) + 0.1);
    effect4.set("y", abs(y) + 0.1);
    effect4.set("red", 0.0);
    effect4.set("green", 0.0);
    effect4.set("blue", 1.0);
    pass3.shader(effect4);
    pass3.image(cadre.getCurrentVideo().getPImage(), x*z*2, y*z*2, width, height);

  }

  else if(fx.equals("glow")){
    pass3.clear();
    float z = map(handPos.z, 10, 70, 0.9, 0.95);
    //println("z: "+z);
    //println("handPos.z: "+handPos.z);
    glow.set("a", cadre.getOpacity() * norm(pass2Alpha, 0, 255));
    glow.set("intensity", 0.0);
    pass3.shader(glow);
    pass3.image(cadre.getCurrentVideo().getPImage(), 0, 0, width, height);
  }

  else if(fx.equals("glow2")){
    pass3.clear();
    float z = map(handPos.z, 10, 70, 0.001, 0.02);
    glow2.set("a", cadre.getOpacity() * norm(pass2Alpha, 0, 255));
    glow2.set("intensity", 0.0);
    pass3.shader(glow2);
    pass3.image(cadre.getCurrentVideo().getPImage(), 0, 0, width, height);
  }

  else if(fx.equals("colorizeCircle")){
    pass3.clear();
    for (int i = 0; i < 5; i++) {
      colorizeCircle.set("maskTexture_f"+i, fingerMaskArray.get(i).draw());
    }
    pass3.shader(colorizeCircle);
    pass3.image(cadre.getCurrentVideo().getPImage(), 0, 0, width, height);
  }

  pass3.resetShader();

  pass3.endDraw();
}

void checkScreenSaver(){
    if(screensaving){
        if (tickCount >= 2 || tickCount <= -2){
            screensaving = false;
            this.timeoutScreenSaving.stop();
            // println("stopping timeout");
            this.intro.goToStart();
        }
    }else{
        //Si pas d'entrée
        if (tickCount < 2 && tickCount > -2){
            //println("pas d'entree.");
            if(!this.timeoutScreenSaving.isStarted()){
              screensaving = false;
              this.timeoutScreenSaving.reset();
              this.timeoutScreenSaving.start();
              //println("starting timeout");
            }
            if(this.timeoutScreenSaving.isFinished()){
                screensaving = true;
                this.video.goToRandom();
            }
        }
        //Si entrée
        else{
          screensaving = false;
          this.timeoutScreenSaving.reset();
          //println("resetting timeout");
        }
    }
    tickCount = 0;
}

void checkEffectChange(){
  if(this.timeoutEffectSwitch.isFinished()){
    this.shadersManager.switchShader();
  }
}

void changeEffectRandom(){

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


void keyPressed() {
    // println("keyCode: "+keyCode);
    //Space
    if(keyCode == 32){
        video.tick(-100);
        cadre.tick(-100);
        tickCount+= -100;
    }
    else if(key == 'c'){
        shadersManager.switchShader();
    }
}

// void movieEvent(Movie m) {
//     println("movieEvent dehors");
// }

void serialEvent(Serial p) {

    // Lire le message.
    String chaine = p.readString();

    // Separer les elements du message
    // selon les espaces:
    String[] elements = splitTokens(chaine);

    // S'assurer qu'il y a bien deux mots
    // dans le message et les appliquer aux variables :
    if ( elements.length == 2 ) {
        messageFirstElement = elements[0];
        messageSecondElement = int(elements[1]);
        // On peut "router" les messages en comparant le premier Ã©lÃ©ment :
        if ( messageFirstElement.equals("dir") ){
            //manivelleValue = messageSecondElement;
            if(video != null) {
              video.tick(messageSecondElement);
            }
            if(cadre != null){
                cadre.tick(messageSecondElement);
            }
            tickCount += messageSecondElement;
        }
    }
}


boolean sketchFullScreen() {
  return fullscreen;
}
