import java.util.concurrent.ConcurrentHashMap;

int threshold = 100;

// Le tableau qui contient les images
ConcurrentHashMap <Integer, PImage> imgs = new ConcurrentHashMap<Integer, PImage>();
Loader loader;

int framesTotal = 1999;
float timehead = 0;
int prevFrame = 0;
int currentFrame = 0;
float speed  = 0;
int frameDrop = 0;

PShader sepialize;

void setup() {
  size(720, 404, P3D);
  frameRate(24);

  loader = new Loader(this, imgs, threshold, framesTotal);
  loader.setUpdateDelay(1);
  loader.start();
  
  sepialize = loadShader("sepia.glsl");
}

void draw() { 
  

  // Effacer le skecth actuel (reset)
  background(0, 0, 0, 0);

  //int currentFrame = floor(millis()/1000.0 * 30);
  currentFrame  = floor(timehead);
  loader.setFrame(currentFrame);

  sepialize.set("intensity", (float)mouseY/height);
  shader(sepialize);
  
  if (imgs.get(currentFrame) != null) {
    image(imgs.get(currentFrame), 0, 0);
    prevFrame = currentFrame;
  } else if (imgs.get(prevFrame) != null) {
    image(imgs.get(prevFrame), 0, 0);
    frameDrop ++;
    // System.out.println("prevFrame");
  }
  
  resetShader();

  if (loader.ready()) {
    speed = (mouseX - width/2) / 100.0;
    timehead += speed;
    timehead = timehead % (framesTotal-1);
    if(timehead < 0) {
      timehead = framesTotal -1 ;
    }
  }
  
  
  textSize(12);
  text("speed " + speed,40,40);
  text("frame drop " + frameDrop,40,60);
  text("loader health " + loader.getHealth(),40,80);

  //println(timehead);
}


String fixedDigits(int value) { 

  if (value < 10) {
    return "0000" + value;
  } else  if (value < 100) {
    return "000" + value;
  } else  if (value < 1000) {
    return "00" + value;
  } else  if (value < 10000) {
    return "0" + value;
  } else {
    return Integer.toString(value);
  }
}

