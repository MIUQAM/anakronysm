// Thanks to jmcouillard.com for help

import java.util.concurrent.ConcurrentHashMap;

class Video {

    int threshold = 100;

    // Le tableau qui contient les images
    ConcurrentHashMap <Integer, PImage> imgs = new ConcurrentHashMap<Integer, PImage>();
    Loader loader;

    float timehead = 0;
    int prevFrame = 0;
    int currentFrame = 0;
    float speed  = 0;
    int frameDrop = 0;

    PShader sepialize;

    String source;
    int sourceLength;
    PApplet p;

    public Video (PApplet p, String source, int sourceLength) {
        this.p = p;
        this.source = source;
        this.sourceLength = sourceLength;

        // Source should be something like "../../../data/videos/Through_The_Mirror/IMG_"
        loader = new Loader(this.p, imgs, threshold, sourceLength, source);
        loader.setUpdateDelay(1);
        loader.start();
    }

    void setSpeed(float speed){
        this.speed = speed;
    }

    private void setFrame(float frame){
        this.timehead = frame;
        this.currentFrame = floor(this.timehead);
        //this.currentFrame  = floor(timehead);
        this.loader.setFrame(this.currentFrame);
        println("currentFrame: "+currentFrame);
    }

    float getFrame(){
        return this.currentFrame;
    }

    public float time(){
        return this.getFrame();
    }

    private float duration(){
        return sourceLength;
    }

    public void update() {
        this.currentFrame  = floor(timehead);
        // println("timehead: "+timehead);
        this.loader.setFrame(this.currentFrame);
        // println("currentFrame: "+currentFrame);

        if (loader.ready()) {
            //println("speed: "+speed);
            timehead += speed;
            timehead = timehead % (sourceLength-1);
            if(timehead < 0) {
                timehead = sourceLength -1 ;
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
            img = new PImage();
            // println("null");
        }

        return img;
    }


    public void play() {
        this.loader.stop = false;
        // println("starting loader " + source);
    }

    public void stop(){
        this.loader.stop = true;
        //this.clean();
        // println("stopping loader " + source);
    }

    public void clean(){
        this.loader.clean();
    }

    public boolean available(){
        return this.loader.ready();
    }

    /*public void jump(float time){
        this.setFrame(time);
    }*/

    public void goToEnd(){
        this.setFrame(this.duration()-1);
    }

    public boolean pastEnd(){
        // println("this.getFrame(): "+this.getFrame());
        // println("this.duration(): "+this.duration());
        if(this.getFrame() >= this.duration()){
            return true;
        }
        return false;
    }

    public boolean pastStart(){
        if(this.getFrame() < 0){
            return true;
        }
        return false;
    }

    public void speed(float speed){
        this.setSpeed(speed);
    }

}