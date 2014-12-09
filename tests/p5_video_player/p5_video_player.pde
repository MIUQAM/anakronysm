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

Videos frame;
ArrayList<String> frameL = new ArrayList<String>();
ArrayList<Integer> frameLengths = new ArrayList<Integer>();

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
    // video = new Video(this, "../../../data/videos/Through_The_Mirror.ogv");


    videos.add("../../../data/pngs/101 Dalmatians/101 Dalmatians- A Gentleman Always Has His Handkerchief Ready");
    videosLengths.add(1823);

    // videos.add("../../../data/pngs/Alice In Wonderland/Alice In Wonderland");
    // videosLengths.add(1594);



    // videos.add("../../../data/videos/Through_The_Mirror/IMG_");
    // videosLengths.add(12243);

    // videos.add("../../../data/videos/1920/2_Steamboat_1928.ogv");
    // videos.add("../../../data/videos/1920/3_skeleton dance_1929.ogv");
    // videos.add("../../../data/videos/1920/4_skeleton dance_1929.ogv");
    // videos.add("../../../data/videos/1920/5_skeleton dance_1929.ogv");
    // videos.add("../../../data/videos/1920/6_skeleton dance_1929.ogv");
    // videos.add("../../../data/videos/1930/7_Woos Whoopee_1930.ogv");
    // videos.add("../../../data/videos/1930/8_Geti a Horse_1930.ogv");
    // videos.add("../../../data/videos/1930/9_Bosko the Doughboy_1931.ogv");
    // videos.add("../../../data/videos/1930/10_Red Hot Mamma_1934.ogv");
    // videos.add("../../../data/videos/1940/11_Pinocchio_1940.ogv");
    // videos.add("../../../data/videos/1950/12_Peter Pan_1953.ogv");
    // videos.add("../../../data/videos/1950/13_Alice in Wonderland_1951.ogv");
    // videos.add("../../../data/videos/1960/14_101 Dalmatians_1961.ogv");
    video = new Videos(this, videos, videosLengths);
    video.play();
    // video.pause();
    // video.setSpeed(0.00000000001);

    // frame = new Frame(this, "../../../data/videos/Film_strip/Film Strip 02_", 146);

    frameL.add("../../../data/videos/Film_strip/Film Strip 02_");
    frameLengths.add(146);
    frame = new Videos(this, frameL, frameLengths);
    frame.play();

    introL.add("../../../data/pngs/Intro_v2/Intro_v2_");
    introLengths.add(224);
    intro = new Videos(this, introL, introLengths);
    intro.play();

    println(Serial.list());
    try{
        serial = new Serial(this, portName, 57600);
        serial.bufferUntil(13);
    }catch (Exception e) {
        println("Couldn't connect to Arduino");
    }

    this.timeoutScreenSaving = new TimeoutP5(10000, false);

}

void draw() {

    checkScreenSaver();

    // video.tick();
    if(screensaving){
        intro.update();
        intro.setSpeed(1);
    }else{
        video.update();
        frame.update();
    }
    // intro.update();
    background(0);
    // ellipse(width/2, height/2, millis()%100, millis()%100);
    noStroke();
    if(screensaving){
        image(intro.getPg(), 0, 0);
    }else{
        image(video.getPg(), 0, 0);
        image(frame.getPg(), 0, 0);
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

void keyPressed() {
    // println("keyCode: "+keyCode);
    //Space
    if(keyCode == 32){
        video.tick(-100);
        frame.tick(-100);
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
            if(frame != null){
                frame.tick(messageSecondElement);
            }
            tickCount += messageSecondElement;
        }
    }
}