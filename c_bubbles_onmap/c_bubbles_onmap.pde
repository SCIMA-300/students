//introduce variables and objects
PImage mapImage;
float s = 29;
float num1 = 0; 
float num2 = 55;
boolean t = false;
 

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

    int m = int(random(255));
    int n = int(random(255));
    int o = int(random(255));
  
   

void setup() {
  size(753, 571);
  mapImage = loadImage("Aditi_Map2.png");
  oneCircle = new Circle();
 myCircles = new Circle[num];
 for(int i = 0; i<num; i++){
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
  background(150);
  image(mapImage, 0, 0);
    translate(width/2, height/2);
    
  int m = (int)map(mouseX, 0, width, 1, 5);
  if ((num2%90)==0)t = !t;
  for (int i = 0; i < 360; i+=72) {
    for (int q = 0; q < m; q++) {
      float s2 = q*3;
      float angle = -(s+s2)+sin(radians(num))*(s+s2);
      fill(m, n, o);
      ellipse(sin(radians(i+num-num2))*(s+s2+angle), cos(radians(i+num-num2))*(s+s2+angle), (s)*4, (s)*4);
    }
  }
  if (t)num+=5;
  num2+=5;


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
   myCircles[row].display(x,y, red, green, blue);
  }

//if the closestDist variable does not equal the maximum float variable....
  if (closestDist != MAX_FLOAT) {
     fill(m, n, o);
    textAlign(CENTER);
    text(closestText, closestTextX, closestTextY);

   
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
}
//we write this function to visualize our data 
// it takes 3 arguments: x, y and id


void drawData(float x, float y, String id) {
//value variable equals second field in row
  float value = dataTable.getFloat(id, 1);
  
 if (value>=0) {
    //remap the value to a range between 1.5 and 15
    radius = map(value, 0, dataMax, 2, 100); 
    //and make it this color
    fill(m, n, o);
  } else {
    //otherwise, if the number is negative, make it this color.
    radius = map(value, 0, dataMin, 1.5, 15);
     fill(m, n, o);
  }
  //make a circle at the x and y locations using the radius values assigned above
  ellipseMode(RADIUS);
   fill(m, o,n);
  ellipse(x, RADIUS, RADIUS, RADIUS);

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