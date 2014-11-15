import processing.video.*;

Movie video;

PGraphics pass1;
PGraphics pass2;
PGraphics circleMask;

PShader sepialize;
PShader colorizeCircle;
float circleRadius = 100.0;

void setup() {
  size(800, 600, OPENGL);

  video = new Movie(this, "Through_The_Mirror.mp4");
  video.play();  

  pass1 = createGraphics(width, height, OPENGL);
  pass1.beginDraw();
  pass1.endDraw();

  pass2 = createGraphics(width, height, OPENGL);
  pass2.beginDraw();
  pass2.endDraw();

  circleMask = createGraphics(width, height, OPENGL);
  circleMask.beginDraw();
  circleMask.endDraw();

  sepialize = loadShader("sepia.glsl");

  colorizeCircle = loadShader("colorizeCircle.glsl");
}


void draw() {
  if (video.available()) {
    video.read();
  }

  updatePass1();
  updatePass2();
  
  background(0);
  image(pass1, 0, 0);
  image(pass2, 0, 0);

  circleMask.beginDraw();
  circleMask.clear();
  circleMask.fill(0);
  circleMask.ellipse(mouseX, mouseY, circleRadius, circleRadius);
  circleMask.endDraw();

  image(circleMask, 0, 0);
}

void updatePass1() {
  pass1.beginDraw();
  pass1.clear();

  pass1.shader(sepialize);
  pass1.image(video, 0, 0, width, height);
  pass1.resetShader();

  pass1.endDraw();
}

void updatePass2() {
  pass2.beginDraw();
  pass2.clear();

  colorizeCircle.set("maskTexture", circleMask);

  pass2.shader(colorizeCircle);
  pass2.image(video, 0, 0, width, height);
  pass2.resetShader();

  pass2.endDraw();
}


void keyPressed() {
  if (key == 'g') {
  } else if (key == 'c') {
  }
}
