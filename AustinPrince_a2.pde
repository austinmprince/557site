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