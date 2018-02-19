public class Button {
  float xPos;
  float yPos; 
  float xSize; 
  float ySize;
  String str;
  Button(float x, float y, float w, float h, String name) {
    xPos = x + (w / 2);
    yPos = y;
    xSize = w;
    ySize = h;
    str = name;
    //rect(c.flip.xPos + (c.flip.xSize / 2), c.flip.yPos, c.flip.xSize, c.flip.ySize);

  }
  
  boolean MouseIsOver() {
    if (mouseX > xPos && mouseX < (xPos + xSize) && mouseY > yPos && mouseY < (yPos + ySize)){
      return true;
    }
    return false;
  }
}
