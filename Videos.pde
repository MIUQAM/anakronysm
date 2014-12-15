class Videos {

    PGraphics pg;
    float time;
    boolean playing;
    boolean available = false;
    float speed = 1;
    int tickCount = 0;

    PApplet stage;

    TimeoutP5 timeout;

    ArrayList<String> sources;
    ArrayList<Integer> sourcesLength;
    int currentSourceIndex = 0;

    ArrayList<Video> videos;

    boolean opacityAffected = false;

    //direction
    //          1 == forward
    //         -1 == backward
    int direction = 1;

    public Videos (PApplet stage, ArrayList<String> sources, ArrayList<Integer> sourcesLength){
        this.videos = new ArrayList<Video>();
        this.sources = sources;
        this.sourcesLength = sourcesLength;
        this.stage = stage;
        this.setup();
    }

    private void setup(){
        if(this.videos.size() <= 0){
            for(int i = 0; i < this.sources.size(); i++){
                this.videos.add(new Video(this.stage, this.sources.get(i), this.sourcesLength.get(i)));
            }
        }
        this.pg = createGraphics(width, height, OPENGL);
        this.pg.beginDraw();
        this.pg.endDraw();
        this.timeout = new TimeoutP5(100,true);
        this.timeout.start();
    }

    private String getCurrentSource(){
        return this.sources.get(currentSourceIndex);
    }

    public boolean play(){
        this.getCurrentVideo().play();
        this.available = true;
        return this.setPlaying(true);
    }

    public void stop() {
        this.available = false;
        this.getCurrentVideo().stop();
    }

    public boolean getPlaying(){
        return this.playing;
    }

    public boolean setPlaying(boolean playing){
        this.playing = playing;
        return this.getPlaying();
    }

    public PGraphics getPg(){
        return this.pg;
    }

    public PImage getPImage(){
        if(this.getCurrentVideo().getPImage() != null){
            return this.getCurrentVideo().getPImage();
        }
        return new PImage();
    }

    float getOpacity(){
        if(opacityAffected)
            return map(abs(this.getSpeed()),0.0,2.0,1.0,0.0);
        return 1;
    }

    public PImage getMovie(){
        return this.getPImage();
    }

    public void update(){
        if(this.available){
            if(this.timeout.isFinished()){
                this.setMidSpeed();
            }
            if(this.getPImage() != null){
                this.getCurrentVideo().update();
                this.pg.beginDraw();
                    this.pg.clear();
                    this.pg.image(this.getPImage(), 0, 0, width, height);
                this.pg.endDraw();
            }

        } else {

             //println("!available");
        }
    }

    public float setSpeed(float speed){
        if(speed > 2){
            speed = 2;
        }else if(speed < -2){
            speed = -2;
        }
        this.speed = speed;
        this.getCurrentVideo().speed(this.speed);
        return this.getSpeed();
    }

    public float getSpeed(){
        return this.speed;
    }

    public void goToStart(){
        this.getCurrentVideo().goToStart();
    }

    public void goToRandom(){
        this.getCurrentVideo().goToRandom();
    }

    public void setFrame(float frame){
        this.getCurrentVideo().setFrame(frame);
    }

    public float setMidSpeed(){
        float speed = this.tickCount/100.0;
        speed = map(speed, 0.0, 2.0, 0.0, 3.0);
        //invert
        speed *= (-1);
        if(speed > 2.5){
            speed = 2.5;
        }else if(speed < -2.5){
            speed = -2.5;
        }

        bridge.send("speed", speed);

        if(tickCount > 0){
            this.direction = 1;
        }
        else{
            this.direction = -1;
        }
        this.setSpeed(speed);

        this.tickCount = 0;
        return this.getSpeed();
    }

    public float changeSpeed(float speed){
        return this.setSpeed(this.getSpeed() + speed);
    }

    public float getTime(){
        this.time = this.getCurrentVideo().time();
        return this.time;
    }

    public float tick(int direction){
        this.tickCount+= direction;
        return this.getTime();
    }

    public int next(){
        this.stop();
        if(this.currentSourceIndex == this.videos.size() - 1){
            this.currentSourceIndex = 0;
        }else{
            this.currentSourceIndex += 1;
        }
        this.play();
        return this.currentSourceIndex;
    }

    public int previous(){
        this.stop();
        if(this.currentSourceIndex == 0){
            this.currentSourceIndex = this.videos.size() - 1;
        }else{
            this.currentSourceIndex -= 1;
        }
        this.play();
        this.goToEnd();
        return currentSourceIndex;
    }

    private void goToEnd(){
        this.getCurrentVideo().goToEnd();
    }

    private Video getCurrentVideo(){
        return this.videos.get(currentSourceIndex);
    }

    public int getDirection(){
        return this.direction;
    }

    public int setDirection(int direction){
        this.direction = direction;
        return this.getDirection();
    }

}