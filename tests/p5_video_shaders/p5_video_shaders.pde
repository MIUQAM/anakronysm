import processing.video.*;

Movie video;
PGraphics pg;
PShader shader;
PShader sepialize;

void setup() {
  size(800, 600, OPENGL);

  video = new Movie(this, "../../../data/videos/Through_The_Mirror.mp4");
  video.play();  

  pg = createGraphics(width, height, OPENGL);
  pg.beginDraw();
  pg.endDraw();

  sepialize = loadShader("sepia.glsl");
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

  pg.shader(sepialize);
  pg.image(video, 0, 0, width, height);
  pg.resetShader();

  pg.image(video, width/2, 0, width, height);

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
