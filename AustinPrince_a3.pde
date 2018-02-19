String fileName = "iris.csv";
// dictate how much of the screen our x axes take up
float sxProp = 0.2;
int drawn = 0;
float exProp = 0.8;
float syProp = 0.1;
float eyProp = 0.9;
float colSeparate;
int field;
int rangeField;
boolean boxSet; 
float boundMax;
float boundMin;
float rectStartX;
float rectStartY;
float rectWidth;
float rectHeight;
Axes ax;
DrawRect drawRect;

Column [] axesFields;

void setup() {
  drawRect = new DrawRect();
  size(800 , 600);
  rectStartX = 0;
  rectStartY = 0;
  rectWidth = 0;
  rectHeight = 0;
  ax = new Axes(fileName);
  boxSet = false;
  //String[] lines = loadStrings(fileName);
  //String[] firstLine = split(lines[0], ",");
  //int numColumns = firstLine.length;
}

void draw() {
  background(255);
  ax.Draw();
  drawRect.drawing();
  ax.checkPos();
  
  
}
void mousePressed() {
   for (Column c: axesFields) {
     if (c.MouseIsOver()) {
       field = c.field;
       boxSet = false;
       for (Column x : axesFields) {
         if (x.currSelect == true) {
           x.currSelect = false;
         }
       }
       c.currSelect = !c.currSelect;
     }
     if (c.flip.MouseIsOver()) {
       c.inverse = !c.inverse;
       ax.flipVals(c.field);
       //println(c.inverse);
     }
   }
   drawRect.startDrawingRectAt(mouseX, mouseY);
   //rectStartX = mouseX;
   //rectStartY = mouseY;
}

void mouseDragged() {
  
  drawRect.updateBottomRight(mouseX, mouseY);
  //rect(rectStartX, rectStartY, rectWidth, rectHeight);
}

void mouseReleased() {
  float maxY = drawRect.rectStartY;
  boundMax = maxY;
  float minY = drawRect.rectStartY + drawRect.yHeight;
  boundMin = minY;
  
  if (drawRect.hasRectangle == true) {
    boxSet = true;
  }
  else {
    boxSet = false;
  }
  drawRect.doneDrawing();
  
  //println(rectStartX +  rectStartY + rectWidth + rectHeight);
  //println(colSeparate);
  int i = 0;
  //boxSet = true;
  for (Column c : axesFields) {
    //if (i == 0|| i == axesFields.length - 1) {
    //  if (abs(drawRect.rectStartX - c.xPoint + 
    //}
    if (abs(drawRect.rectStartX - c.xPoint) < colSeparate / 2) {
     // println(c.colName);
      rangeField = c.field;
      //println(maxY, minY);
      c.setMaxMin(maxY, minY);
      c.currSelect = true;
      //println(maxY, minY);
      ax.findInRange(rangeField, maxY, minY);
    }
    else {
      c.currSelect = false;
    }
    i ++;
  }
  
}
