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

boolean debug = true;


LeapMotion leap;
P5toMSPBridge bridge = new P5toMSPBridge("127.0.0.1", 5001);

/* ========= ARDUINO ============ */
String portName = "/dev/tty.usbmodem1411";
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

int tickCount = 0;

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
PShader glow;
PShader glow2;
PShader colorizeCircle;


void setup() {
  size(853, 480, OPENGL);
  frameRate(30);

  // Affiche les noms des ports.
  println(Serial.list());


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
  glow2 = loadShader("glow2.glsl");

  shadersManager.add("effect1");
  shadersManager.add("effect2");
  shadersManager.add("effect3");
  shadersManager.add("effect4");
  shadersManager.add("colorizeCircle");
  shadersManager.add("glow");
  shadersManager.add("glow2");

  shadersManager.switchShader();

  brush = loadImage("brush.png");

}


void draw() {


  try {
    updateLeap();
  } catch (Exception e) {
  }

  checkScreenSaver();

    // video.tick();
    if(screensaving){
        intro.update();
        intro.setSpeed(1);
    }else{
      video.update();
      cadre.update();
      updatePass1();
      updatePass2(shadersManager.getCurrentShader());

    }
    // intro.update();
    background(0);

    if(screensaving){
        image(intro.getPg(), 0, 0);
    }else{
        //image(pass1, 0, 0);
        //image(pass2, 0, 0);
        //image(video.getPg(), 0, 0);
        //image(cadre.getPg(), 0, 0);
    }


    image(pass2, 0, 0);

  //bridge.send("modul8/ctrl_layer_movie_playDirection", abs(video.speed));

  //bridge.send("speed", abs(video.speed));
  //bridge.send("dir", abs(video.speed)/video.speed);
  //bridge.send("dir", video.direction);

  if(debug){
    if (frameCount % 30 == 1) {
      int fps = Math.round(frameRate);
      frame.setTitle(fps + "fps");
    }
  }

  pushStyle();
  fill(255);
  ellipse(width-100, height-100, millis()/10%100, millis()/10%100);
  popStyle();
}

void setupVideos(){
  videos.add("pngs/101 Dalmatians/101 Dalmatians- A Gentleman Always Has His Handkerchief Ready");
  videosLengths.add(1823);

  video = new Videos(this, videos, videosLengths);
  video.play();


  cadreL.add("videos/Film_strip/Film Strip 02_");
  cadreLengths.add(146);
  cadre = new Videos(this, cadreL, cadreLengths);
  cadre.play();

  introL.add("pngs/Intro_v2/Intro_v2_");
  introLengths.add(224);
  intro = new Videos(this, introL, introLengths);
  intro.play();

  this.timeoutScreenSaving = new TimeoutP5(10000, false);
}

void updateLeap(){

  int fps = leap.getFrameRate();

  if(leap.getHands().size() > 0){
    for(Hand hand : leap.getHands()){

      PVector handPosition = hand.getPosition();

      bridge.send("x", handPosition.x);
      bridge.send("y", handPosition.y);
      bridge.send("z", handPosition.z);
      println("handPosition.z: "+handPosition.z);

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

  pass1.image(video.getPg(), 0, 0, width, height);

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
    pass2.image(video.getCurrentVideo().getPImage(), 0, 0, width, height);
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
    pass2.image(video.getCurrentVideo().getPImage(), x*z*4, y*z*4, width, height);
    pass2.resetShader();

    effect2.set("a", norm(pass2Alpha, 0, 255));
    effect2.set("x", abs(x) + 0.1);
    effect2.set("y", abs(y) + 0.1);
    effect2.set("red", 0.0);
    effect2.set("green", 1.0);
    effect2.set("blue", 0.0);
    pass2.shader(effect2);
    pass2.image(video.getCurrentVideo().getPImage(), x*z*3, y*z*3, width, height);
    pass2.resetShader();

    effect2.set("a", norm(pass2Alpha, 0, 255));
    effect2.set("x", abs(x) + 0.1);
    effect2.set("y", abs(y) + 0.1);
    effect2.set("red", 0.0);
    effect2.set("green", 0.0);
    effect2.set("blue", 1.0);
    pass2.shader(effect2);
    pass2.image(video.getCurrentVideo().getPImage(), x*z*2, y*z*2, width, height);

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
    float z = map(handPos.z, 0, 100, 0.85, 1.0);
    glow.set("a", norm(pass2Alpha, 0, 255));
    glow.set("intensity", z);
    pass2.shader(glow);
    pass2.image(video.getCurrentVideo().getPImage(), 0, 0, width, height);
  }

  else if(fx.equals("glow2")){
    pass2.clear();
    float z = map(handPos.z, 0, 100, 0.001, 0.03);
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

void checkScreenSaver(){
    if(screensaving){
        if (tickCount >= 10 || tickCount <= -10){
            screensaving = false;
            this.timeoutScreenSaving.stop();
        }
    }else{
        if(!this.timeoutScreenSaving.isStarted()){
            this.timeoutScreenSaving.start();
            screensaving = false;
        }
        if(this.timeoutScreenSaving.isFinished()){
            screensaving = true;
            tickCount = 0;
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


void keyPressed() {
    // println("keyCode: "+keyCode);
    //Space
    if(keyCode == 32){
        video.tick(-100);
        cadre.tick(-100);
        tickCount+= -100;
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