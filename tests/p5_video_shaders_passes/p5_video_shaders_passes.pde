import processing.video.*;

Capture video;

PGraphics pass1;
PGraphics pass2;

PShader shader1;
PShader shader2;

void setup() {
  size(800, 600, OPENGL);

  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this, 160, 120);

  // Start capturing the images from the camera
  video.start();  

  pass1 = createGraphics(width, height, OPENGL);
  pass1.beginDraw();
  pass1.endDraw();

  pass2 = createGraphics(width, height, OPENGL);
  pass2.beginDraw();
  pass2.endDraw();

  shader1 = loadShader("ripple2D.glsl");
  shader1.set("timeFactor", 10.0);
  shader1.set("rippleHeight", 0.005);
  shader1.set("rippleQuantity", 200.0);
  shader1.set("rippleMaxDistance", 0.75);
  
  shader2 = loadShader("color.glsl");
  shader2.set("colorFilter", 0.0, 0.1, 0.0);
}


void draw() {
  if (video.available()) {
    video.read();
  }
  updatePass1();
  updatePass2();
  
  background(0);
  image(pass2, 0, 0);
}

void updatePass1() {
  pass1.beginDraw();
  pass1.clear();

  shader1.set("rippleOrigin", (float)mouseX/width, (float)mouseY/height);
  shader1.set("time", millis()/1000.0);

  pass1.shader(shader1);
  pass1.image(video, 0, 0, width, height);
  pass1.resetShader();

  pass1.fill(255);
  pass1.noStroke();
  pass1.ellipseMode(CENTER);
  pass1.ellipse(mouseX, mouseY, 20, 20);

  pass1.endDraw();
}

void updatePass2() {
  pass2.beginDraw();
  pass2.clear();

  pass2.shader(shader2);
  pass2.image(pass1, 0, 0, width, height);
  pass2.resetShader();

  pass2.endDraw();
}


void keyPressed() {
  if (key == 'g') {
  } else if (key == 'c') {
  }
}
