PImage mapImage;
Table locationTable; 
Table dataTable; 
int rowCount;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;

//global variables
float closestDist;
String closestText;
float closestTextX;
float closestTextY;

void setup() {
  size(1280, 800);
  mapImage = loadImage("mappingimage-v1.1.png");

  locationTable = new Table("locations.tsv");  
  dataTable = new Table("random.tsv");
  rowCount = locationTable.getRowCount();
  for (int row = 0; row< rowCount; row++) {
    float value = dataTable.getFloat(row, 1);
    if (value>dataMax) {
      dataMax = value;
    }
    if (value<dataMin) {
      dataMin = value;
    }
  }
}

void draw() {
  background(255);
  image(mapImage, 0, 0);
  closestDist = MAX_FLOAT;
  for (int row = 0; row<rowCount; row++) {
    String id = dataTable.getRowName(row);
    float x = locationTable.getFloat(id, 1);
    float y = locationTable.getFloat(id, 2);
    //checked
    drawData(x, y, id);
  }

  if (closestDist != MAX_FLOAT) {
    fill(0);
    textAlign(CENTER);
    text(closestText, closestTextX, closestTextY);
  }
}

void drawData(float x, float y, String id) {
  float value = dataTable.getFloat(id, 1);
  float radius = 0;
  if (value>=0) {
    //remap the value to a range between 1.5 and 15
    radius = map(value, 0, dataMax, 1.5, 15); 
    //and make it this color
    fill(#4422CC);
  } else {
    //otherwise, if the number is negative, make it this color.
    radius = map(value, 0, dataMin, 1.5, 15);
    fill(#FF4422);
  }
  //make a circle at the x and y locations using the radius values assigned above
  ellipseMode(RADIUS);
  ellipse(x, y, radius, radius);

  float d = dist(x, y, mouseX, mouseY);

  if ((d<radius+2) && (d<closestDist)) {
    closestDist = d;
    String name = dataTable.getString(id, 1);
    closestText = name +" "+value;
    closestTextX = x;
    closestTextY = y-radius-4;
  }
}
