import processing.video.*;

Capture video;
PGraphics pg;
PShader shader;

void setup() {
  size(800, 600, OPENGL);

  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this, 160, 120);

  // Start capturing the images from the camera
  video.start();  

  pg = createGraphics(width, height, OPENGL);
  pg.beginDraw();
  pg.endDraw();

  shader = loadShader("ripple2D.glsl");
  shader.set("timeFactor", 10.0);
  shader.set("rippleHeight", 0.005);
  shader.set("rippleQuantity", 200.0);
  shader.set("rippleMaxDistance", 0.75);
}


void draw() {
  if (video.available()) {
    video.read();
  }
  updatePG();
  background(0);
  noStroke();

  image(pg, 0, 0);
}

void updatePG() {
  pg.beginDraw();
  pg.clear();
  
  shader.set("rippleOrigin", (float)mouseX/width, (float)mouseY/height);
  shader.set("time", millis()/1000.0);

  pg.shader(shader);
  pg.image(video, 0, 0, width, height);
  pg.resetShader();

  pg.fill(255);
  pg.noStroke();
  pg.ellipseMode(CENTER);
  pg.ellipse(mouseX, mouseY, 20, 20);

  pg.endDraw();
}


void keyPressed() {
  if (key == 'g') {
  } else if (key == 'c') {
  }
}
