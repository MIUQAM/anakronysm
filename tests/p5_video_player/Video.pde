import processing.video.*;

class Video {

    Movie video;
    PGraphics pg;

    float speed = 1;

    public Video (PApplet stage, String source) {
        this.video = new Movie(stage, source);
        this.pg = createGraphics(width, height, OPENGL);
        this.pg.beginDraw();
        this.pg.endDraw();
    }

    public void play(){
        this.video.play();
    }

    public PGraphics getPg(){
        return this.pg;
    }

    public void update(){
        if (video.available()) {
          video.read();
        }
        this.pg.beginDraw();
            this.pg.clear();
            this.pg.image(video, 0, 0, width, height);
        this.pg.endDraw();
    }

    public float backward(){
        this.setSpeed((-1.0) * abs(this.speed));
        return this.getSpeed();
    }

    public float forward(){
        this.setSpeed(abs(this.speed));
        return this.getSpeed();
    }

    public float setSpeed(float speed){
        this.speed = speed;
        this.video.speed(this.speed);
        return this.getSpeed();
    }

    public float getSpeed(){
        return this.speed;
    }

    public float changeSpeed(float speed){
        return this.setSpeed(this.getSpeed() + speed);
    }

}