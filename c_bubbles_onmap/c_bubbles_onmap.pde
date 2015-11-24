final int GRID_SIZE = 10;
final float GRID_PADDING = 50;
float[] fbUsage={4,3,0,1,2,5,0};
float[] lineUsage={2,3,8,1,1,4,2};
float[] instagramUsage={4,5,6,7,8,5,1};


void setup() {
  size(500, 500);
  mouseX = mouseY = 250;
}

float gridToCoordinates(int input) {
  return GRID_PADDING+input*(500 - 2*GRID_PADDING)/(GRID_SIZE-1);
}

float getData(int i,int j){
  if(j==4){
    return fbUsage[i-2];
  }
  else if(j==5){
    return lineUsage[i-2];
  }
  else if(j==6){
    return instagramUsage[i-2];
  }
  return 0.0;
}

void draw() {
  background(0);

  noStroke();
  fill(255);
  for (int i = 2; i < 9; ++i) {
    for (int j = 4; j < 7; ++j) {
      float distance = sqrt(pow(mouseX-gridToCoordinates(i), 2) + pow(mouseY-gridToCoordinates(j), 2));
      float ellipseSize = getData(i,j)*30+15;
      if(j==4){
      fill(0,0,255);
      }
      else if(j==5){
     fill(0,255,0);
      }
      else if(j==6){
      fill(255,0,0);
      }

      if(distance>10){
        ellipseSize = 10;
      }
      ellipse(gridToCoordinates(i), gridToCoordinates(j), ellipseSize, ellipseSize);

      if(distance<=10){
        textSize(20);
        fill(255);
        text(getData(i,j)+"hr",gridToCoordinates(i), gridToCoordinates(j),20);
      }
    }
  }
}