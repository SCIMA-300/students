class Circle {

  float x, y;
  float diameter = 1;
  boolean on = false;
  int volume;
  int r, g, b;

  //void begin(){
  //  x = xpos;
  //  y = ypos;
  //  on = true;
  //  diameter = 1;
  //}

  void grow(int v) {
    volume=v;
    diameter+=0.3;
// you might mess with this number a bit to get the right size,
//or you might pass in a variable to determine how wide it gets.
    if (diameter > v) {
      diameter = 0.3;
    }
  }

  void display(float xpos, float ypos, int newR, int newG, int newB) {
    x = xpos;
    y = ypos;
    r = newR;
    g = newG;
    b = newB;
    noFill();
    strokeWeight(2);
    stroke(color(r, g, b), 200);
    ellipse(x, y, diameter, diameter);
  }
}
