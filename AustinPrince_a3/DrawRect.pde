public class DrawRect {
  float xCoord;
  float yCoord;
  float xWidth;
  float yHeight;
  float rectStartX;
  float rectStartY;
  boolean hasRectangle = false;
  boolean inDrawState = false;
  
  void startDrawingRectAt(float x, float y) {
   rectStartX = x;
   rectStartY = y;
   //hasRectangle = true;
   inDrawState = true;
   
  }
  
  void updateBottomRight(float x, float y) {
    xWidth = mouseX - rectStartX;
    yHeight = mouseY - rectStartY;
    hasRectangle = true;
    //rect(rectStartX, rectStartY, xWidth, yHeight);
  }
  void drawing() {
    if (inDrawState == true) {
      rect(rectStartX, rectStartY, xWidth, yHeight);
    }
  }
  void doneDrawing() {
    inDrawState = false;
    hasRectangle = false;
    xCoord = 0;
    yCoord = 0;
    xWidth = 0;
    yHeight = 0;
    
  }
}
