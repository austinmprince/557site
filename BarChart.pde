public class BarChart extends Chart {
  ArrayList<Bar> bars = new ArrayList();
  BarChart(String inputData) {
    super(inputData);
    //ArrayList<Bar> bars = new ArrayList();
    makeBars();
    drawBars();
    hoverRect();
    button.Draw();
  }
 
  void makeBars() {
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
      
      // this creates a linearly spaced vector from the start point to the end point
      // so that we can put our bars there
      int xcoord = xStart + i * (xEnd-xStart)/(numRows-1);
      
      //float barH = data.getFloat(i, 1) * pixConvert;
      float barH = float(values[i]) * pixConvert;
      // draws bars at the correct width and xcoordinate need to get height
      //String val = data.getString(i, 0);
      
      Bar b = new Bar(xcoord, zeroPoint - barH, barSize, barH, names[i], values[i]);
      //println("barH " + barH + " b.h " + b.x) ;

      bars.add(b);
      //println(b.h);
      //println(b.h);
      //rect(xcoord, zeroPoint - barH, barSize, b.h);
      
    }
  }
  
  void drawBars() {
    color c = color(175, 100, 220);
    fill(c);
    for (Bar b : bars) {
      float x = lerp(0, b.h, alpha);
      //float y = lerp(0,  b.w, beta);
      rect(b.x, b.y, b.w, x);
    }
    

  }
  void hoverRect () {
    if (animating == false) {
    for (Bar b : bars) {
      if (mouseX > b.x && mouseX < (b.x + b.w * 0.8)  && mouseY > b.y && mouseY < b.y + b.h) {
        fill(0);
        String val = "Name: " + b.name + "\n" + "Value: " + b.value;
        //println("Team Name: " + b.name + " Height: " + b.h + " Value: " + b.y);
        
        
        text(val, b.x, b.y - (height * 0.03));
        //rect(b.x - b.w / 2 , b.y - b.y * 0.1, b.w * 5, b.w * 3);
        
      }
    }
    }
  }
  
  //void buttonClicked() {
  //  //for (int i = 0; i < numRows; i ++) {
  //  //  //color c = color(175, 100, 220);
  //  //  //fill(c);
    
  //  for (Bar a : bars) {
  //    a.h = lerp(0, 100, alpha);
  //    if (alpha < 1) {
  //      alpha += 0.01;
  //    }
  //  }
  //  //println("lerping");
  // }
}