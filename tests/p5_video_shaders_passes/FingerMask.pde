public class FingerMask {

  PGraphics circleMask;
  float posX;
  float posY;
  float size = 0.0;
  float sizeFactor = 2.0;
  boolean show = false;

  public FingerMask() {
    circleMask = createGraphics(width, height, OPENGL);
    circleMask.beginDraw();
    circleMask.endDraw();
  }

  void update(PVector fingerPos){
    posX = fingerPos.x;
    posY = fingerPos.y;
    size = fingerPos.z * sizeFactor;
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