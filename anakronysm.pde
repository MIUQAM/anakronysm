/**
* Project : anakronysm 
* Author : Pier-Olivier Bourgault, Marc-Antoine Brodeur, Alexandre d'Avignon, Erwan d'Orgeville, Pier Luc Marrier
* Author URI : http://github.com/MIUQAM
* License : MIT
* Version : 1.0.0
* 
*/


import de.voidplus.leapmotion.*;
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
    }
    // intro.update();
    background(0);
    // ellipse(width/2, height/2, millis()%100, millis()%100);
    noStroke();
    if(screensaving){
        image(intro.getPg(), 0, 0);
    }else{
        image(video.getPg(), 0, 0);
        image(cadre.getPg(), 0, 0);
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
        //fingerMaskArray.get(finger.getType()).update(finger_position);
      }
    }
  } else {

    /*for (FingerMask fm : fingerMaskArray) {
      fm.update(false);
    }*/
  }
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

// Definir une fonction pour recevoir les donnees du port serie:
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
              //video.setDirection(messageSecondElement);

                if(messageSecondElement == -1.0){
                  bridge.send("md8key/ctrl_layer_movie_playDirection/1", 0.0);
                } else {
                  bridge.send("md8key/ctrl_layer_movie_playDirection/1", 1.0);
                }
            }
            
        }
    }
}