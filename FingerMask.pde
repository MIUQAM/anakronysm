public class FingerMask {

  PGraphics circleMask;
  float posX;
  float posY;
  float size = 0.0;
  float sizeFactor = 3.0;
  boolean show = false;

  public FingerMask() {
    circleMask = createGraphics(width, height, OPENGL);
    circleMask.beginDraw();
    circleMask.endDraw();
  }

  void update(PVector fingerPos){
    posX = map(fingerPos.x, 300, 1150, 0, width);
    posY = map(fingerPos.y, 300, 640, 0, height);
    size = map(fingerPos.z, 20, 70, 0, 75) * sizeFactor;
    this.show = true;
  }

  void update(boolean isVisible){
    this.show = isVisible;
  }

  PGraphics draw(){
    circleMask.beginDraw();
    circleMask.fill(0, 10);
    circleMask.rect(0, 0, width, height);

    if(this.show){
      circleMask.fill(255, 25);
      circleMask.noStroke();
      circleMask.imageMode(CENTER);
      circleMask.image(brush, posX, posY, size, size);
    }
    circleMask.endDraw();

    return circleMask;
  }

}