class Video {

    Movie video;

    String source;
    PApplet stage;

    public Video (PApplet stage, String source) {
        this.stage = stage;
        this.source = source;
        this.resetVideo();
    }

    public void play() {
        this.video.play();   
    }

    public void pause() {
        this.video.pause();
    }

    public void stop(){
        this.video.stop();
    }

    public void resetVideo() {
        if(this.video != null){
            this.video.stop();
        }
        this.video = new Movie(this.stage, this.source);
        this.volume(0);
    }

    public Movie getMovie(){
        return this.video;
    }

    public boolean available(){
        return this.video.available();
    }

    public void jump(float time){
        this.video.jump(time);
    }

    public float time(){
        return this.video.time();
    }

    public void volume(int volume){
        this.video.volume(volume);
    }

    public boolean pastEnd(){
        if(this.time() >= this.duration()){
            return true;
        }
        return false;
    }

    public boolean pastStart(){
        if(this.time() <= 0){
            return true;
        }
        return false;
    }

    public void read(){
        this.volume(0);
        this.video.read();
        this.volume(0);
    }

    public void speed(float speed){
        this.video.speed(speed);
    }

    private float duration(){
        return this.video.duration(); 
    }

}