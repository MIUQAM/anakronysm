/**
* Project : p5_video_player 
* Author : Erwan
* Version : 1.0.0
* Date : 20-11-2014
* Description here
*/

Video video;

void setup() {
    size(960, 540, OPENGL);
    video = new Video(this, "../../../data/videos/Through_The_Mirror.ogv");
    video.play();
}

void draw() {
    video.update();
    background(0);
    noStroke();
    image(video.getPg(), 0, 0);
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
        println("video.backward(): "+video.backward());
    }else if(key == '2'){
        //Right
        println("video.forward(): "+video.forward());
    }
}