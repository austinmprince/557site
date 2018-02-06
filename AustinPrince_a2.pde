import java.util.*;
Button button;

// string of the name of the file containing info
String graphName = "Downloads/national-average.csv";
color c = color(175, 100, 220);
float lineAlpha = 0;
boolean animating = false;
boolean graphType = true;
boolean toLine = false;
float alpha = 1;
float maxProp = 0.85;
float minProp = 0.15;
boolean drawingLines = false;
void setup() {

  size(800 , 600);
  surface.setResizable(true);

  //Chart c1 = new Chart("Downloads/national-average.csv");


}

void draw() {
  button = new Button("Line Graph");
   //println(lineAlpha);
   //Set Background to white.
   background(255);
   //Chart c1 = new Chart("Downloads/national-average.csv");

   //LineChart l1 = new LineChart("Downloads/national-average.csv");

   if (graphType == false) {
     button.str = "Bar Graph";

   }
   else {
     button.str = "Line Graph";
     //button.Draw();
   }
   // going from bar graph to line graph
   if (graphType == false) {
     //LineChart l1 = new LineChart("Downloads/national-average.csv");
     if (alpha > 0) {
       animating = true;
       BarChart b1 = new BarChart(graphName);
       //button.Draw();
       alpha -= 0.01;
     }
     else if (alpha < 0) {
       animating = false;
       LineChart l1 = new LineChart(graphName);
       //button.Draw();
       if (lineAlpha < 1) {
         animating = true;
         lineAlpha += 0.01;
       }
     }


   }
   // going from line graph to bar graph
   if (graphType == true) {
     if (alpha < 1) {
        if (lineAlpha > 0) {
          animating = true;
          LineChart l1 = new LineChart(graphName);
          //button.Draw();
        lineAlpha -= 0.01;
        }
        else {
         animating = true;
         BarChart b1 = new BarChart(graphName);
         alpha += 0.01;
        }
     }
     else if (alpha > 0) {
       animating = false;
       BarChart b1 = new BarChart(graphName);
       //button.Draw();
     }

   }

}

void mousePressed() {

  if (button.MouseIsOver()) {
    if (graphType == true) {
      toLine = true;
    }
    graphType = !graphType;


  }
}

public class Bar {
  float x;
  float y;
  float h;
  float w;
  String name;
  float value;

  Bar(float a, float b, float c, float d, String n, float v) {
    x = a;
    y = b;
    w = c;
    h = d;
    name = n;
    value = v;
  }
}

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

public class Chart {
  Table data;
  int numRows;
  int maxValue;
  int minValue;
  int zeroPoint;
  String xName;
  String yName;
  String[] names;
  int[] values;
  Chart(String inputData) {
    //data = loadTable(inputData, "header");
    loadData(inputData);
    numRows = values.length;

    getValues();
    drawAxes();

  }

  void loadData(String path) {
    String[] lines = loadStrings(path);
    String[] firstLine = split(lines[0], ",");
    xName = firstLine[0];
    yName = firstLine[1];
    names = new String [lines.length - 1];
    values = new int[lines.length - 1];

    for (int i = 1; i < lines.length; i ++) {
      String[] row = split(lines[i], ",");
      names[i - 1] = row[0];
      values[i - 1] = (int)parseFloat(row[1]);
    }
  }
  void getValues() {
    ArrayList<Integer> list = new ArrayList<Integer>();
    //for (int i = 0; i < data.getRowCount(); i++) {
      for (int i = 0; i < names.length; i ++) {
      //list.add(data.getInt(i, 1));
      list.add(values[i]);
    }
    maxValue = Collections.max(list);

    minValue = Collections.min(list);
    if (minValue > 0) {
      minValue = 0;
    }
  }


  void drawAxes() {
    int xStart = int(width * maxProp);
    int yStart = int(height * maxProp);
    int xEnd = int(width * minProp);
    int yEnd = int(height * minProp);
    int yLen = yStart - yEnd;
    float rValue = (Math.abs(float(minValue)) / Math.abs(float(maxValue)));
    int yPoint = yLen - (int(0.5 * rValue * yLen)) + yEnd;
    zeroPoint = yPoint;
    drawYTicks(yStart, yEnd, xEnd);
    drawXTicks(xStart, xEnd, yStart);
    int xLen = xEnd - xStart;
    float barSize = float(xLen / numRows);


    line(xStart - barSize, yPoint, xEnd, yPoint); // y axis
    line(xEnd, yStart, xEnd, yEnd); // yaxis doesn't need to be changed ever

  }

  void drawYTicks(int yStart, int yEnd, int xEnd) {
    //float pixConvert =(float(yLen) / float(6));
    int yLen = yStart + yEnd;
    pushMatrix();
    //println(yName);
    //translate(500, 500);
    fill(0);
    translate(xEnd - xEnd * 0.6, yLen / 2);
    textSize(height/50);
    rotate(3*PI/2.0);
    text(yName,0,0);
    popMatrix();
    textSize(height/60);
    int numTicks = 7;
    //float conFactor = (maxValue - minValue) / numTicks;
    for (int i = 0; i < numTicks; i ++) {
      int coord = yEnd + i * (yStart - yEnd) / (numTicks - 1);
      line(xEnd, coord, xEnd - (xEnd * 0.1), coord);
      String label = str(maxValue + i * (minValue - maxValue) / (numTicks - 1));
      fill(0);
      textAlign(CENTER, CENTER);
      text(label, xEnd * 0.7 , coord);
    }

  }

  void drawXTicks(int xStart, int xEnd, int yStart) {
    int xLen = xStart - xEnd;
    textSize(height/50);
    text(xName, (xLen / 2) + xEnd, yStart + yStart * 0.1);
    textSize(height/75);
    textAlign(CENTER);
    float barSize = float(xLen / numRows);
    barSize = barSize * 0.8;
    for (int i = 0; i < numRows; i ++) {
      //String label = data.getString(i, 0);
      String label = names[i];
      int xcoord = xEnd + i * (xStart-xEnd)/(numRows-1);
      fill(0);
      //println(zeroPoint);
      int factor;
      if (values[i] >= 0) {
        factor = 1;
      }
      else {
       factor = -1;
      }
      line(xcoord + barSize / 2, zeroPoint, xcoord + barSize / 2, zeroPoint + (factor) * yStart * 0.02);
      pushMatrix();
      translate(xcoord + barSize / 2, zeroPoint + (factor) * yStart * 0.04);
      rotate(PI/2.0);
      text(label,0,0);
      popMatrix();


    }
  }

  void drawLabels() {
    textAlign(CENTER);
    for (int i = 0; i < numRows; i++){
      int xcoord = 50 + i * (700-50)/(32-1);
      //String label = data.getString(i, 0);
      String label = names[i];
      //println(label);
      pushMatrix();
      translate(xcoord, 525);
      rotate(PI/2.0);
      textSize(height/75);
      text(label,0,0);
      popMatrix();




      //text(label, xcoord, 550);
   }
 }
}

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

public class Point {
 float x;
 float y;
 String name;
 int value;

 Point(float a, float b, String c, int d) {
   x = a;
   y = b;
   name = c;
   value = d;
 }

}
