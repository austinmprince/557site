public class Line {
  String lineName;
  float [] values;
  float [] points;
  boolean inRange;
  float []slope;
  float []yInt;
  Line(String name, float [] vals) {
    lineName = name;
    values = vals;
    inRange = true;
  }
  private void setPoints(float [] pointValues) {
    points = pointValues;
  }
  
}
