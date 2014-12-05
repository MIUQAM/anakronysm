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
String portName = "/dev/tty.usbmodem1451";
Serial serial;
String messageFirstElement = "";
int messageSecondElement = 0;
float manivelleValue = 0;
/* ============================== */


Videos video;
ArrayList<String> videos = new ArrayList<String>();



void setup() {
  size(800, 600, OPENGL);

  // Affiche les noms des ports.
  println(Serial.list());
  serial = new Serial(this, portName, 57600);
  // Indiquer a l'instance serial de lancer la fonction serialEvent()
  // lorsque l'octet 13 est recu. L'octet 13 est envoye par
  // l'Arduino pour indiquer la fin du message
  serial.bufferUntil(13);


  leap = new LeapMotion(this);


  videos.add("../../data/videos/Through_The_Mirror.ogv");
  videos.add("../../data/videos/1920/1_Steamboat_1928.ogv");
  videos.add("../../data/videos/1920/2_Steamboat_1928.ogv");
  videos.add("../../data/videos/1920/3_skeleton dance_1929.ogv");
  videos.add("../../data/videos/1920/4_skeleton dance_1929.ogv");
  videos.add("../../data/videos/1920/5_skeleton dance_1929.ogv");
  videos.add("../../data/videos/1920/6_skeleton dance_1929.ogv");
  videos.add("../../data/videos/1930/7_Woos Whoopee_1930.ogv");
  videos.add("../../data/videos/1930/8_Geti a Horse_1930.ogv");
  videos.add("../../data/videos/1930/9_Bosko the Doughboy_1931.ogv");
  videos.add("../../data/videos/1930/10_Red Hot Mamma_1934.ogv");
  videos.add("../../data/videos/1940/11_Pinocchio_1940.ogv");
  videos.add("../../data/videos/1950/12_Peter Pan_1953.ogv");
  videos.add("../../data/videos/1950/13_Alice in Wonderland_1951.ogv");
  videos.add("../../data/videos/1960/14_101 Dalmatians_1961.ogv");
  video = new Videos(this, videos);
  video.play();


  if(debug){
    if (frameCount % 30 == 1) {
      int fps = Math.round(frameRate);
      frame.setTitle(fps + "fps");
    }
  }

}


void draw() {

  updateLeap();

  video.update();
  background(0);
  noStroke();
  image(video.getMovie(), 0, 0);

  println(bridge.send("speed", abs(video.speed)));
  println(bridge.send("dir", abs(video.speed)/video.speed));

}

void keyPressed() {
    // println("keyCode: "+keyCode);
    if(keyCode == 37){
       //Left
       println("video.changeSpeed(-0.1): "+video.changeSpeed(-0.1));
    }else if(keyCode == 39){
        //Right
        println("video.changeSpeed(0.1): "+video.changeSpeed(0.1));
    }

    else if(key == '1'){
        //Right
        println("video.next(): "+video.next());
    }else if(key == '2'){
        //Right
        println("video.previous(): "+video.previous());
    }

    //Space
    else if(keyCode == 32){
        video.tick();
    }

    //Command
    else if(keyCode == 157){
        println("video.togglePlay(): "+video.togglePlay());
    }
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
        if ( messageFirstElement.equals("direction") ){
            //manivelleValue = messageSecondElement;
            video.tick();
            // video.setDirection(messageSecondElement);
        }
    }
}