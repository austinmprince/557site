class Button {
  float xPos;
  float yPos;
  float xSize;
  float ySize;
  float fontSize;
  String str;
  Button(String str) {
    
    
    fill(255);
    xPos = height * 0.04;
    yPos = width * 0.02;
    xSize = height * 0.1;
    ySize = width * 0.03;
    
    
    
    //println("text height: " + (textDescent() + textAscent()) + " boxHeight: " + ySize);
    
    //textSize(min(minWidth, minHeight));
    //println(min(minWidth, minHeight));
    //println("xPos: " + xPos + " yPos: " + yPos + " xSize: " + xSize + " ySize: " + ySize);
    //drawBox();
    //drawText();
    
    //fill(0);
    //textSize();
    //text(str, xPos, yPos);
    
    
    
  }
  
  void Draw() {
    fill(218);
    stroke(141);
    textSize(width/100);
    rect(xPos, yPos, xSize, ySize, 10);
    textAlign(CENTER, CENTER);
    fill(0);
    text(str, xPos + (xSize / 2), yPos + (ySize / 2));
  }
  
  boolean MouseIsOver() {
    if (mouseX > xPos && mouseX < (xPos + xSize) && mouseY > yPos && mouseY < (yPos + ySize)){
      return true;
    }
    return false;
  }
  //void drawBox() {
  //  rect(xPos, yPos, xSize, ySize);
  //}
  //void drawText() {
  //  float minWidth = ((12/textWidth(str)) * xSize);
  //  float minHeight = ((12/ (textDescent() + textAscent())) * ySize);
  //  fontSize = min(minWidth, minHeight);
  //  println(fontSize);
  //  textSize(fontSize);
  //  fill(0);
  //  text(str, xPos, yPos); 
  //}
}