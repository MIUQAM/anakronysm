/**
* Project : p5_video_player 
* Author : Erwan
* Version : 1.0.0
* Date : 20-11-2014
* Description here
*/

import processing.serial.*;

P5toMSPBridge bridge = new P5toMSPBridge("127.0.0.1", 12345);

Videos video;
ArrayList<String> videos = new ArrayList<String>();
ArrayList<Integer> videosLengths = new ArrayList<Integer>();

Videos cadre;
ArrayList<String> cadreL = new ArrayList<String>();
ArrayList<Integer> cadreLengths = new ArrayList<Integer>();

Videos intro;
ArrayList<String> introL = new ArrayList<String>();
ArrayList<Integer> introLengths = new ArrayList<Integer>();

/* ========= ARDUINO ============ */
String portName = "/dev/tty.usbmodem1411";
Serial serial;
String messageFirstElement = "";
int messageSecondElement = 0;
float manivelleValue = 0;
/* ============================== */

boolean screensaving = false;
TimeoutP5 timeoutScreenSaving;

int tickCount = 0;
 
void setup() {
    size(853, 480, OPENGL);
    frameRate(30);
    

    setupVideos();

    println(Serial.list());
    try{
        serial = new Serial(this, portName, 57600);
        serial.bufferUntil(13);
    }catch (Exception e) {
        println("Couldn't connect to Arduino");
    }

}

void draw() {

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
}

void setupVideos(){
    videos.add("../../../data/pngs/101 Dalmatians/101 Dalmatians- A Gentleman Always Has His Handkerchief Ready");
    videosLengths.add(1823);

    video = new Videos(this, videos, videosLengths);
    video.play();


    cadreL.add("../../../data/videos/Film_strip/Film Strip 02_");
    cadreLengths.add(146);
    cadre = new Videos(this, cadreL, cadreLengths);
    cadre.play();

    introL.add("../../../data/pngs/Intro_v2/Intro_v2_");
    introLengths.add(224);
    intro = new Videos(this, introL, introLengths);
    intro.play();

    this.timeoutScreenSaving = new TimeoutP5(10000, false);
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

void keyPressed() {
    // println("keyCode: "+keyCode);
    //Space
    if(keyCode == 32){
        video.tick(-100);
        cadre.tick(-100);
        tickCount+= -100;
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