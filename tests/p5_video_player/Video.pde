import processing.video.*;

class Video {

    Movie video;
    PGraphics pg;
    float time;
    boolean playing;
    boolean available = false;
    float speed = 1;
    int tickCount = 0;

    TimeoutP5 timeout;

    public Video (PApplet stage, String source) {
        this.video = new Movie(stage, source);
        this.pg = createGraphics(width, height, OPENGL);
        this.pg.beginDraw();
        this.pg.endDraw();
        this.timeout = new TimeoutP5(1000,true);
        this.timeout.start();
    }

    public boolean play(){
        this.video.play();
        return this.setPlaying(true);
    }

    public boolean pause(){
        this.video.pause();
        return this.setPlaying(false);
    }

    public boolean getPlaying(){
        return this.playing;
    }

    public boolean setPlaying(boolean playing){
        this.playing = playing;
        return this.getPlaying();
    }

    public boolean togglePlay(){
        if(this.getPlaying()){
            return this.pause();
        }else{
            return this.play();
        }
    }

    public PGraphics getPg(){
        return this.pg;
    }

    public void update(){
        if (this.available == false && video.available()) {
            this.available = true;
        }
        if(this.available){
            // println("reading");
            video.read();
        }
        if(this.timeout.isFinished()){
            println("this.setMidSpeed(): "+this.setMidSpeed());
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

    public float setMidSpeed(){
        float speed = (float)this.tickCount/10;
        if(speed == 0){
            this.pause();
        }
        else{
            if(!this.getPlaying()){
                this.play();
            }
            this.setSpeed(speed);
        }
        this.tickCount = 0;
        return this.getSpeed();
    }

    public float changeSpeed(float speed){
        return this.setSpeed(this.getSpeed() + speed);
    }

    public float getTime(){
        this.time = this.video.time();
        return this.time;
    }

    public float setTime(float time){
        this.time = time;
        this.video.jump(time);
        this.video.play();
        this.video.pause();
        return this.getTime();
    }

    public float tick(){
        // this.setTime(this.getTime() + 1.0/frameRate);
        this.tickCount++;
        return this.getTime();
    }

    void movieEvent(Movie m) {
        // println("movieEvent dedans");
    }

}