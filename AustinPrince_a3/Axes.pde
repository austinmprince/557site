
public class Axes {

  // Column [] axesFields;

  String [] fieldNames;
  float [] max;
  float [] min;
  int [] xcoords;
  int numCol;

  Line [] newLines;
  float [] lineVals;
  float [] pointVals; 
  // int field;
  Axes(String inputData) {
    loadData(inputData);
    makeAxes();
    generatePoints();
    //drawAxes();
    //generatePoints();
    //drawPoints();
    //getLineValues(inputData);
  }
  void Draw() {
    drawAxes();
    drawPoints();
  }


  void loadData(String inputString) { 
    String[] lines = loadStrings(inputString);

    String[] firstLine = split(lines[0], ",");
    //println(firstLine);
    //println(firstLine.length);
    numCol = firstLine.length - 1;
    max = new float [firstLine.length - 1];
    min = new float [firstLine.length - 1];
    fieldNames = new String[firstLine.length - 1];
    newLines = new Line[lines.length - 1];

    //println(lines.length);
    //for (int i = 1; i < firstLine; i ++) {
    //  println(firstLine[i]);
    //}
    for (int i = 0; i < max.length; i ++) {
      fieldNames[i] = firstLine[i + 1];
      max[i] = -99999999;
      min[i] = 99999999;
    }
    for (int i  = 1; i < lines.length; i ++) {

      String[] row = split(lines[i], ",");
      String lineName = row[0];
      lineVals = new float[row.length - 1];

      for (int j = 1; j < row.length; j ++) {
        //println(row[j]);
        lineVals[j - 1] = float(row[j]);
        //println(lineVals[j-1]);
        float testVal = parseFloat(row[j]);
        //println(testVal);
        if (testVal > max[j -1]) {
          max[j -1 ] = testVal;
        }
        if (testVal < min[j - 1]) {
          min[j -1] = testVal;
        }
      }
      newLines[i - 1] = new Line(lineName, lineVals);
    }
  }

  void makeAxes() {
    xcoords = new int[numCol];
    int yEnd = int(height * eyProp);
    int xStart = int(width * sxProp);
    int xEnd = int(width * exProp);
    colSeparate = xEnd/numCol;
    axesFields = new Column[numCol];
    int yStart = int(height * syProp);
    for (int i = 0; i < numCol; i ++) {
      int xcoord = xStart + i * (xEnd - xStart)/(numCol - 1);
      float rectWidth = width * 0.01;
      float iHeight = height /40;
      float iWidth = width / 25;
      xcoords[i] = xcoord;

      Button b = new Button(xcoord - (iWidth - 2), yEnd + yEnd * 0.06, iWidth, iHeight, "flip");
      Column c = new Column(xcoord - (rectWidth / 2), float(yStart), rectWidth, float(yEnd - yStart), i, b, fieldNames[i], max[i], min[i]);
      if (i == 0) {
        c.currSelect = true;
      }
      axesFields[i] = c;
    }
  }

  void drawAxes() {
    int yEnd = int(height * eyProp);
    int xStart = int(width * sxProp);
    int xEnd = int(width * exProp);
    int i = 0;
    int yStart = int(height * syProp);
    for (Column c : axesFields) {
      fill(155);
      // draw the button
      rect(c.flip.xPos, c.flip.yPos, c.flip.xSize, c.flip.ySize);
      fill(0);
      textSize(width / 75);
      text("Invert", c.flip.xPos + c.flip.xSize / 2, c.flip.yPos + c.flip.ySize);
      
      //rect(c.flip.xPos + (c.flip.xSize / 2), c.flip.yPos, c.flip.xSize, c.flip.ySize);
      fill(0);
      // if the column is the currently selected column change the color so it
      // is shown as being selected
      if (c.currSelect == true && boxSet == false) {
        fill(153);
      } else {
        fill(250);
      }
      // draw columns
      if (boxSet == true && rangeField == i) {
        rect(c.xPoint, c.yPoint, c.xWidth, c.yHeight);
        fill(153);
        rect(c.xPoint, c.selectMax, c.xWidth, c.selectMin - c.selectMax);
        //rect(c.xPoint , c.selectMax, c.xWidth, c.selectMax + c.selectMin);
      } else {
        rect(c.xPoint, c.yPoint, c.xWidth, c.yHeight);
      }
      // draw line in the middle of columns
      line(xcoords[i], c.yPoint, xcoords[i], c.yPoint + c.yHeight);
      textSize(width/60);
      fill(0);
      // column name at the top
      textAlign(CENTER, BOTTOM);
      text(c.colName, c.xPoint, c.yPoint - c.yPoint * 0.4);
      if (c.inverse == false) {
        // max val right below it
        text(str(c.colMax), c.xPoint, c.yPoint - c.yPoint * 0.1);
        textAlign(CENTER, BOTTOM);
        // col min at the bottom of the column
        text(str(c.colMin), c.xPoint, (c.yPoint + c.yHeight) + c.yPoint * 0.5);
        i++;
      } else {
        text(str(c.colMin), c.xPoint, c.yPoint - c.yPoint * 0.1);
        textAlign(CENTER, BOTTOM);
        // col min at the bottom of the column
        text(str(c.colMax), c.xPoint, (c.yPoint + c.yHeight) + c.yPoint * 0.5);
        i++;
      }
    }
  }



  void generatePoints() {
    int yStart = int(height * syProp);
    int yEnd = int(height * eyProp);
    int yLen = yEnd - yStart;

    //println("min array" + min);
    //for (int i = 0; i < min.length; i ++) {
    //  println(min[i]);
    //}
    //println("max array" + max);
    // for (int i = 0; i < max.length; i ++) {
    //  println(max[i]);
    //}
    for (Line l : newLines) {
      pointVals = new float [max.length];
      for (int i = 0; i < l.values.length; i ++) {
        float numRange = max[i] - min[i];

        //println(numRange);
        float pixConvert = (float(yLen) / numRange);
        pointVals[i] = (yLen * ((max[i] - l.values[i]) / numRange)) + yStart;

        // pointVals[i] = (l.values[i] * pixConvert);
        //pointVals[i] = yEnd - (((l.values[i] - max[i]) / numRange) * 0.8);
      }
      float [] slopes = new float [pointVals.length - 1];
      float [] yInts = new float [pointVals.length - 1];
      for (int i = 0; i < pointVals.length - 1; i ++) {
        float m = (pointVals[i + 1] - pointVals[i]) / (xcoords[i + 1] - xcoords[i]);
        //println(x);
        slopes[i] = m;
        //println(m);
        yInts[i] = pointVals[i] - (m * xcoords[i]);
        l.slope = slopes;
        l.yInt = yInts;
        //println(yInts[i - 1]);

        //println(yInts[i - 1]);
      }

      l.setPoints(pointVals);
    }
  }
  void drawPoints() {
    // println(newLines.length);
    //int [] colorVal = new int [3];
    //int field = 2;
    int j = 0;
    int k = 0;
    int yStart = int(height * syProp);
    int yEnd = int(height * eyProp);
    int yLen = yEnd - yStart;
    for (Line l : newLines) {
      if (boxSet == false) {
        float colorVal = 510 * (max[field] - l.values[field]) / (max[field] - min[field]);

        stroke((255 - (colorVal - 255)), 20, (colorVal -255));
        for (int i = 0; i < l.points.length - 1; i ++) {
          line(xcoords[i], l.points[i], xcoords[i + 1], l.points[i + 1]);
        }
        stroke(0);
        j ++;
        j = j % 4;
      } else {
        if (l.inRange == true) {

          float colorVal = 510 * (boundMax - l.points[field]) / (boundMax - boundMin);

          stroke((255 - (colorVal - 255)), 20, (colorVal -255));
          for (int i = 0; i < l.points.length - 1; i ++) {
            line(xcoords[i], l.points[i], xcoords[i + 1], l.points[i + 1]);
          }
          //println("0 fill");
        } else {
          stroke(209);
        }
        for (int i = 0; i < l.points.length - 1; i ++) {
          line(xcoords[i], l.points[i], xcoords[i + 1], l.points[i + 1]);
        }
      }
      stroke(0);
    }
  }
  void flipVals(int field) {
    int yStart = int(height * syProp);
    int yEnd = int(height * eyProp);
    for (Line l : newLines) {
      for (int i = 0; i < l.points.length; i ++) {
        if (axesFields[i].inverse == true && axesFields[i].field == field) {
          l.points[i] = yStart + yEnd - l.points[i];
          if (field == 0) {
            float m = (l.points[i + 1] - l.points[i]) / (xcoords[i + 1] - xcoords[i]);
            l.slope[i] = m;
            l.yInt[i] =  l.points[i] - (m * xcoords[i]);
          }
          else if (field == numCol - 1){
            println("in here");
            float m = (l.points[i] - l.points[i - 1]) / (xcoords[i] - xcoords[i - 1]);
            l.slope[i - 1] = m;
            l.yInt[i - 1] =  l.points[i] - (m * xcoords[i]);
          }
          else {
            //println(numCol);
            float mb = (l.points[i] - l.points[i - 1]) / (xcoords[i] - xcoords[i - 1]);
            l.slope[i - 1] = mb;
            l.yInt[i - 1] = l.points[i - 1] - (mb * xcoords[i - 1]);
            float m = (l.points[i + 1] - l.points[i]) / (xcoords[i + 1] - xcoords[i]);
            l.slope[i] = m;
            l.yInt[i] =  l.points[i] - (m * xcoords[i]);
          }
        } else if (axesFields[i].inverse == false && axesFields[i].field == field) {
          l.points[i] = yStart + yEnd - l.points[i];
          if (field == 0) {
            float m = (l.points[i + 1] - l.points[i]) / (xcoords[i + 1] - xcoords[i]);
            l.slope[i] = m;
            l.yInt[i] =  l.points[i] - (m * xcoords[i]);
          }
          else if (field == numCol - 1){
            //println("in here");
            float m = (l.points[i] - l.points[i - 1]) / (xcoords[i] - xcoords[i - 1]);
            l.slope[i - 1] = m;
            l.yInt[i - 1] =  l.points[i] - (m * xcoords[i]);
          }
          else {
            //println(numCol);
            float mb = (l.points[i] - l.points[i - 1]) / (xcoords[i] - xcoords[i - 1]);
            l.slope[i - 1] = mb;
            l.yInt[i - 1] = l.points[i - 1] - (mb * xcoords[i - 1]);
            float m = (l.points[i + 1] - l.points[i]) / (xcoords[i + 1] - xcoords[i]);
            l.slope[i] = m;
            l.yInt[i] =  l.points[i] - (m * xcoords[i]);
          }
        }
      }
    }
  }
  void findInRange(int colCheck, float minY, float maxY) {

    for (Line l : newLines) {
      //println(l.points[colCheck]);
      if (l.points[colCheck] > minY && l.points[colCheck] < maxY) {
        l.inRange = true;
      } else {
        l.inRange = false;
      }
    }
  }
  void checkPos() {
    
    boolean top;
    int yStart = int(height * syProp);
    int yEnd = int(height * eyProp);
    //println("working it");
    if (abs(yStart - mouseY) < abs(yEnd - mouseY)) {
      //println("on top");
      top = true;
    } else {
      top = false;
      //println("on bottom");
    }
    for (Line l : newLines) {
     
  
      for (int i = 0; i < l.slope.length; i ++) {
        
        if (mouseX > xcoords[i] && mouseX < xcoords[i + 1]) {
       
          if (abs((l.slope[i] * (mouseX) + l.yInt[i]) - (mouseY)) <= 2) {
     
            int boxHeight = height / 10;
            int boxWidth = width / 15;
            String val = l.lineName + "\n";
            for (int j = 0; j < l.values.length; j ++) {
              stroke(255);
              val += fieldNames[j] + ": " + l.values[j] + "\n";
            }
            textSize(height/60);
            if (top == true) {

              if (drawn == 0) {
              text(val, mouseX, mouseY + boxHeight );
              }
              drawn += 1;
              stroke(0);
            
            } else {
              if (drawn == 0) {
              text(val, mouseX, mouseY);
              }
              drawn += 1;
              stroke(0);
            
            }
          }
        }
      }
    }
    drawn = 0;
  }
}