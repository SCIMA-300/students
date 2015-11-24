class Ball {  
  color c; 
  float xpos; 
  float ypos; 

  float radius; 

  Ball (color c_, float xp, float yp,  float r ) { 
    c = c_; 
    xpos = xp; 
    ypos = yp; 

    radius = r; 

  } 
  void display() { 
    noStroke(); 
    fill (c); 
    smooth(); 
    ellipse(xpos, ypos, radius, radius); 
    if (radius > 10) { 
      radius--;
    }
  } 
 

} 