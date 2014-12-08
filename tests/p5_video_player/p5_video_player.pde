/**
* Project : p5_video_player 
* Author : Erwan
* Version : 1.0.0
* Date : 20-11-2014
* Description here
*/

Videos_upgraded video;
ArrayList<String> videos = new ArrayList<String>();

void setup() {
    size(960, 540, OPENGL);
    // video = new Video(this, "../../../data/videos/Through_The_Mirror.ogv");
    videos.add("../../../data/videos/Through_The_Mirror/IMG_");
    // videos.add("../../../data/videos/1920/1_Steamboat_1928.ogv");
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
    video = new Videos_upgraded(this, videos);
    video.play();
    // video.pause();
    // video.setSpeed(0.00000000001);
}

void draw() {
    // video.tick();
    video.update();
    background(0);
    // ellipse(width/2, height/2, millis()%100, millis()%100);
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
        println("video.next(): "+video.next());
    }else if(key == '2'){
        //Right
        println("video.previous(): "+video.previous());
    }

    //Space
    else if(keyCode == 32){
        video.tick(+100);
    }

    //Command
    else if(keyCode == 157){
        println("video.togglePlay(): "+video.togglePlay());
    }
}

// void movieEvent(Movie m) {
//     println("movieEvent dehors");
// }