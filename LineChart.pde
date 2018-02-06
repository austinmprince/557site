public class LineChart extends Chart {
  int pixelSize = height/100;
  ArrayList<Point> points = new ArrayList();
  LineChart(String inputData) {
    super(inputData);
    makePoints();
    drawPoints();
    drawLines();
    hoverPoint();
    button.Draw();
    
  }
  
  void makePoints() {
    int xStart = int(width * minProp);
    int xEnd = int(width * maxProp);
    int yStart = int(height * minProp);
    int yEnd = int(height * maxProp);
    int yLen = yEnd - yStart;
    int xLen = xEnd - xStart;
    float barSize = float(xLen / numRows);
    barSize = barSize * 0.8;
    int numRange = maxValue - minValue;
    float pixConvert =(float(yLen) / float(numRange));
    //println("conversion: " + pixConvert);
    //println("numRange: " + numRange + " pixelRange: " + xLen);
    for (int i = 0; i < numRows; i++) {
      color c = color(175, 100, 220);
      fill(c);
      // this creates a linearly spaced vector from the start point to the end point
      // so that we can put our bars there
      float xcoord = xStart + i * (xEnd-xStart)/(numRows-1);
      
      //float barH = data.getFloat(i, 1) * pixConvert;
      float barH = float(values[i]) * pixConvert;
      // draws bars at the correct width and xcoordinate need to get height
      //String val = data.getString(i, 0);
      xcoord = xcoord + barSize / 2;
      Point p = new Point(xcoord, zeroPoint - barH, names[i], values[i]);
      //println("barH " + barH + " b.h " + b.x) ;

      points.add(p);
   
      
    }
  }
  void drawPoints() {
    
    fill(c);
    stroke(c);
    strokeWeight(pixelSize);
  
    for (Point p : points) {
      point(p.x, p.y);
    }
    strokeWeight(1);
    
  }
  
  void hoverPoint() {
    if (animating == false) {
      for (Point p : points) {
        
        if (mouseX > p.x - pixelSize  && mouseX < (p.x + pixelSize)  && mouseY > p.y - pixelSize  && mouseY < p.y + pixelSize) {
          
          fill(0);
          String val = "Name: " + p.name + "\n" + "Value: " + p.value;
          text(val, p.x, p.y - p.y * 0.1);
          //rect(p.x - p.w / 2 , b.y - b.y * 0.1, b.w * 5, b.w * 3);
        }
      }
    }
  }
  
  void drawLines() {
    //stroke(0);
    for (int i = 0; i < numRows - 1; i ++) {
      float x = lerp(points.get(i).x, points.get(i + 1).x, lineAlpha);
      float y = lerp(points.get(i).y, points.get(i + 1).y, lineAlpha); 
      line(points.get(i).x, points.get(i).y, x, y);
    }
    //println(points.size());
   
    
  }
}