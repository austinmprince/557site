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