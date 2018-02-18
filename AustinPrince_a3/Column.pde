public class Column {
  float xPoint;
  float yPoint; 
  float xWidth;
  float yHeight;
  int field;
  Button flip;
  boolean inverse;
  boolean currSelect; 
  boolean range;
  String colName;
  float colMax;
  float colMin;
  float selectMax;
  float selectMin;

  Column(float x, float y, float xw, float yh, int f, Button b, String name, float m, float mi) {
    xPoint = x;
    yPoint = y;
    xWidth = xw;
    yHeight = yh;
    field = f;
    flip = b;
    inverse = false;
    currSelect = false;
    colName = name; 
    colMax = m;
    colMin = mi;
    range = false;
    
  }
  
  boolean MouseIsOver() {
    if (mouseX > xPoint && mouseX < xPoint + xWidth && mouseY > yPoint && mouseY < yPoint + yHeight) {
      return true;
    }
    return false;
    
  }
  
  void setMaxMin(float x, float y) {
   selectMax = x;
   selectMin = y;
   range = true;
  }
}