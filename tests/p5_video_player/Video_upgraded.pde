// Video class thanks to jmcouillard.com

import java.util.concurrent.ConcurrentHashMap;

class Video_upgraded {

    int threshold = 100;

    // Le tableau qui contient les images
    ConcurrentHashMap <Integer, PImage> imgs = new ConcurrentHashMap<Integer, PImage>();
    Loader loader;

    // int framesTotal = 409;
    int framesTotal = 12243;
    float timehead = 0;
    int prevFrame = 0;
    int currentFrame = 0;
    float speed  = 0;
    int frameDrop = 0;

    PShader sepialize;

    String source;
    PApplet p;

    public Video_upgraded (PApplet p, String source) {
        this.p = p;
        this.source = source;

        // Source should be something like "../../../data/videos/Through_The_Mirror/IMG_"
        loader = new Loader(this.p, imgs, threshold, framesTotal, source);
        loader.setUpdateDelay(1);
        loader.start();
    }

    void setSpeed(float speed){
        this.speed = speed;
    }

    void setFrame(float frame){
        this.currentFrame = currentFrame;
        this.loader.setFrame(this.currentFrame);
    }

    float getFrame(){
        return this.currentFrame;
    }

    public float time(){
        return this.getFrame();
    }

    private float duration(){
        return framesTotal;
    }

    public void update() {
        currentFrame  = floor(timehead);
        loader.setFrame(currentFrame);

        if (loader.ready()) {
            speed = (mouseX - width/2) / 100.0;
            //println("speed: "+speed);
            timehead += speed;
            timehead = timehead % (framesTotal-1);
            if(timehead < 0) {
                timehead = framesTotal -1 ;
            }
        }

        //textSize(12);
        //println("speed " + speed);
        //println("frame drop " + frameDrop);
        //println("loader health " + loader.getHealth());
    }

    PImage getPImage() {
        PImage img;

        if (imgs.get(currentFrame) != null) {
            img = imgs.get(currentFrame);
            prevFrame = currentFrame;
        } else if (imgs.get(prevFrame) != null) {
            img = imgs.get(prevFrame);
            frameDrop ++;
        // System.out.println("prevFrame");
        } else{
            img = null;
            // println("null");
        }

        return img;
    }


    public void play() {
        this.loader.stop = false;
    }

    public void stop(){
        this.loader.stop = true;
    }

    public void clean(){
        this.loader.clean();
    }

    public boolean available(){
        return this.loader.ready();
    }

    public void jump(float time){
        this.setFrame(time);
    }

    public void goToEnd(){
        this.setFrame(this.duration());
    }

    public boolean pastEnd(){
        if(this.getFrame() >= this.framesTotal){
            return true;
        }
        return false;
    }

    public boolean pastStart(){
        if(this.getFrame() <= 0){
            return true;
        }
        return false;
    }

    public void speed(float speed){
        this.setSpeed(speed);
    }

}