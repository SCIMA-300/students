//introduce variables and objects
PImage worldmap;
Table locationTable; //this is using the Table object
Table dataTable; //this is using the Table object
int rowCount;
Circle[] myCircles;
Circle oneCircle;
int num = 6;
float radius = 0;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;
int red, green, blue;

//global variables assigned values in drawData()
float closestDist;
String closestText;
float closestTextX;
float closestTextY;
int newR, newG, newB;

void setup() {
  size(640, 400);
  worldmap = loadImage("worldmap.png");
  oneCircle = new Circle();
  myCircles = new Circle[num];
  for (int i = 0; i<num; i++) {
    myCircles[i] = new Circle();
  }

  //assign tables to object
  locationTable = new Table("locations.tsv");  
  dataTable = new Table("random.tsv");

  // get number of rows and store in a variable called rowCount
  rowCount = locationTable.getRowCount();
  //count through rows to find max and min values in random.tsv and store values in variables
  for (int row = 0; row< rowCount; row++) {
    //get the value of the second field in each row (1)
    float value = dataTable.getFloat(row, 1);
    //if the highest # in the table is higher than what is stored in the 
    //dataMax variable, set value = dataMax
    if (value>dataMax) {
      dataMax = value;
    }
    //same for dataMin
    if (value<dataMin) {
      dataMin = value;
    }
  }
}

void draw() {
  background(255);
  image(worldmap, 0, 0);

  closestDist = MAX_FLOAT;

  //count through rows of location table, 
  for (int row = 0; row<rowCount; row++) {
    //assign id values to variable called id
    String id = dataTable.getRowName(row);
    //get the 2nd and 3rd fields and assign them to
    float x = locationTable.getFloat(id, 1);
    float y = locationTable.getFloat(id, 2);
    //use the drawData function (written below) to position and visualize
    drawData(x, y, id);

    myCircles[row].grow(int(radius));
    myCircles[row].display(x, y, newR, newG, newB);


    switch(row) {
    case 0:  //San Francisco Green
      newR = 163;
      newG = 255;
      newB = 162;
      radius=115;
      break;
    case 1: //Italy Green Medium
      newR = 0;
      newG = 255;
      newB = 0;
      radius=25;
      break; 
    case 2: //France Dark Green
      newR = 4;
      newG = 173;
      newB = 2;
      radius=10;
      break;
    case 3://NY Blue
      newR = 0;
      newG = 0;
      newB = 255;
      radius=5;
      break;
    case 4:  //Brasil Blue
      newR = 0;
      newG = 0;
      newB = 255;
      radius=5;
      break;
    case 5:    //Norway Red
      newR = 255;
      newG = 0;
      newB = 0;
      radius = 5;
      break;
    }
  }

  //myCircles[0].grow();
  //myCircles[0].display(x,y);
  //myCircles[0].begin(300,400);

  //if the closestDist variable does not equal the maximum float variable....
  if (closestDist != MAX_FLOAT) {
    fill(0);
    textAlign(CENTER);
    text(closestText, closestTextX, closestTextY);
  }
}

//we write this function to visualize our data 
// it takes 3 arguments: x, y and id
void drawData(float x, float y, String id) {
  //value variable equals second field in row
  float value = dataTable.getFloat(id, 1);
  float radius = 0;
  //if the value variable holds a float greater than or equal to 0

  if (value>=0) {
    //remap the value to a range between 1.5 and 15
    radius = map(value, 0, dataMax, 15, 15); 
    //and make it this color
  } else {
    //otherwise, if the number is negative, make it this color.
    radius = map(value, 0, dataMin, 1.5, 15);
    fill(#FF4422);
  }
  //make a circle at the x and y locations using the radius values assigned above
  //ellipseMode(RADIUS); 
  //ellipse(x, y, radius, radius);




  float d = dist(x, y, mouseX, mouseY);

  //if the mouse is hovering over circle, show information as text
  if ((d<radius+2) && (d<closestDist)) {
    closestDist = d;
    String name = dataTable.getString(id, 1);
    closestText = name +" "+value;
    closestTextX = x;
    closestTextY = y-radius-4;
  }
}