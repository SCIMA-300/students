class Circle {

  float x, y;
  int r, g, b;
  float diameter = 1;
  boolean on = false;
  int volume;

  //void begin(){
  //  x = xpos;
  //  y = ypos;
  //  on = true;
  //  diameter = 1;
  //}

  void grow(int v) { 
    volume=v;
    diameter+=0.5;
    // you might mess with this number a bit to get the right size, 
    //or you might pass in a variable to determine how wide it gets.
    if (diameter > v) {
      diameter = 1;
    }
  }

  void display(float xpos, float ypos, int red, int green, int blue) { 
    x = xpos;
    y = ypos;
    r = red;
    g = green;
    b = blue;

    noFill();
    strokeWeight(5);
    stroke(color(r, g, b), 255);
    ellipse(x, y, diameter, diameter);
  }
}