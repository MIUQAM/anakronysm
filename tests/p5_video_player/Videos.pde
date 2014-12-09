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
    int currentSourceIndex = 0;

    ArrayList<Video> videos;

    //direction
    //          1 == forward
    //         -1 == backward
    int direction = 1;

    public Videos (PApplet stage, ArrayList<String> sources){
        this.videos = new ArrayList<Video>();
        this.sources = sources;
        this.stage = stage;
        this.setup();
    }

    private void setup(){
        if(this.videos.size() <= 0){
            for(int i = 0; i < this.sources.size(); i++){
                this.videos.add(new Video(this.stage, this.sources.get(i)));
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
        return this.setPlaying(true);
    }

    public boolean pause(){
        this.setSpeed(0);
        return this.setPlaying(true);
    }

    public void stop() {
        this.getCurrentVideo().stop();
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

    public PImage getPImage(){
        if(this.getCurrentVideo().getPImage() != null){
            return this.getCurrentVideo().getPImage();
        }
        else{
            return new PImage();
        }
    }

    public PImage getMovie(){
        return this.getPImage();
    }

    public void update(){
        //println("frameCount: "+frameCount);
        //println("millis(): "+millis());
        /*if (this.available == false && this.getCurrentVideo().available()) {
            this.available = true;
        }*/
        //if(this.available){
            // println("reading");
            // this.getCurrentVideo().read();
            if(this.getCurrentVideo().pastEnd()){
                this.next();
            }else if(this.getCurrentVideo().pastStart()){
                this.previous();
            }
        //}
        if(this.timeout.isFinished()){
            // println("this.setMidSpeed(): "+this.setMidSpeed());
            this.setMidSpeed();
        }
        // if(this.available){
            if(this.getPImage() != null){
                this.getCurrentVideo().update();
                this.pg.beginDraw();
                    this.pg.clear();
                    this.pg.image(this.getPImage(), 0, 0, width, height);
                this.pg.endDraw();
            }
        // }
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
        println("speed: "+speed);
        if(speed == 0){
            this.pause();
        }
        else{
            if(!this.getPlaying()){
                this.play();
            }
            if(tickCount > 0){
                this.direction = 1;
            }
            else{
                this.direction = -1;
            }
            this.setSpeed(speed);
        }
        this.tickCount = 0;
        // println("speed: "+speed);
        return this.getSpeed();
    }

    public float changeSpeed(float speed){
        return this.setSpeed(this.getSpeed() + speed);
    }

    public float getTime(){
        this.time = this.getCurrentVideo().time();
        return this.time;
    }

    public float setTime(float time){
        this.time = time;
        this.getCurrentVideo().jump(time);
        this.play();
        this.pause();
        return this.getTime();
    }

    public float tick(int direction){
        // this.setTime(this.getTime() + 1.0/frameRate);
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
        // this.resetVideo();
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
        // this.resetVideo();
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