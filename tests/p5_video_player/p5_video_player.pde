/**
* Project : p5_video_player 
* Author : Erwan
* Version : 1.0.0
* Date : 20-11-2014
* Description here
*/

Video video;
ArrayList<String> videoList = new ArrayList<String>();

void setup() {
    size(960, 540, OPENGL);
    // video = new Video(this, "../../../data/videos/Through_The_Mirror.ogv");
    videoList.add("../../../data/videos/Through_The_Mirror.ogv");
    video = new Video(this, videoList);
    video.play();
    // video.pause();
    // video.setSpeed(0.00000000001);
}

void draw() {
    // video.tick();
    video.update();
    background(0);
    noStroke();
    image(video.getMovie(), 0, 0);
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

// void movieEvent(Movie m) {
//     println("movieEvent dehors");
// }