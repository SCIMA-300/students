int objectnumber = 20; 
PImage mapImage;
Table locationTable;
Table locationTable_d;
Table dataTable_d;
Table nameTable_d;//this is using the Table object
Table dataTable; //this is using the Table object
Table nameTable;
int rowCount;
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;
int [] angles = {3,76,30,2,87,4,112,46};

//global variables assigned values in drawData()
float closestDist;
String closestText;
float closestTextX;
float closestTextY;
boolean on = false;
int a = 1;


void setup () { 
  size (1750, 1171); 
  mapImage = loadImage("1.png");
  locationTable = new Table("locations.tsv");
  dataTable = new Table("random.tsv");
  nameTable = new Table("names.tsv");
  locationTable_d = new Table("locations_d.tsv");
  dataTable_d = new Table ("random_d.tsv");
  nameTable_d = new Table ("names_d.tsv");

  rowCount = locationTable.getRowCount();
  for (int row = 0; row < rowCount; row++) {
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


void draw () { 
  background(255); 

  background(255);
  image(mapImage, 0, 0, 1750, 1171);
  tint(255, 255);

  closestDist = MAX_FLOAT;

  //count through rows of location table, 
  if (on==true) {
    println("BANG");
    for (int row = 0; row < rowCount; row++) {
      //assign id values to variable called id
      //count through rows to find max and min values in random.tsv and store values in variables

      String id = dataTable.getRowName(row);
      //String name = nameTable.getString(id, 1);
      //get the 2nd and 3rd fields and assign them to
      float x = locationTable_d.getFloat(id, 1);
      float y = locationTable_d.getFloat(id, 2);
      
      //use the drawData function (written below) to position and visualize
      drawData1(x, y, id, 300.0, angles);
      //get the value of the second field in each row (1)
    }
  
  } else if(on == false) {

   for (int row = 0; row<rowCount; row++) {
     //assign id values to variable called id
      String id = dataTable_d.getRowName(row);
     //get the 2nd and 3rd fields and assign them to
      float x = locationTable.getFloat(id, 1);
      float y = locationTable.getFloat(id, 2);
      //float what = myTable(
      //use the drawData function (written below) to position and visualize
      drawData2(x, y, id, 300, angles);
      
      String name = nameTable_d.getString(id, 1);
    }
  }

  //if the closestDist variable does not equal the maximum float variable....
  if (closestDist != MAX_FLOAT) {
    fill(0);
    textAlign(CENTER);
    text(closestText, closestTextX, closestTextY);
  }
}

void mousePressed() {
  if(on == false){
   on = true;
  } else {
   on = false; 
   println("on == true");
  }
}

//we write this function to visualize our data 
// it takes 3 arguments: x, y and id
void drawData1(float x, float y, String id, float diameter, int[] data) {
  //value variable equals second field in row
  float value = dataTable.getFloat(id, 1);
  float radius = 0;
  //if the value variable holds a float greater than or equal to 0
  if (value>=0) {
    //remap the value to a range between 1.5 and 15
    radius = map(value, 0, dataMax, 3, 50); 
    //and make it this color
    fill(48, 139, 206, 127);
  } else {
    //otherwise, if the number is negative, make it this color.
    radius = map(value, 0, dataMin, 1.5, 15);
    fill(#AF1010);
  }
  //make a circle at the x and y locations using the radius values assigned above
  ellipseMode(RADIUS);
  ellipse(x, y, radius, radius);

  float d = dist(x, y, mouseX, mouseY);

  //if the mouse is hovering over circle, show information as text
  if ((d<radius+2) && (d<closestDist)) {
    closestDist = d;
    String name = nameTable_d.getString(id, 1);
    closestText = name +" "+value;
    closestTextX = x;
    closestTextY = y-radius-4;
    
      float lastAngle = 0;
  for (int i = 0; i < data.length; i++) {
    float gray = map(i, 0, data.length, 0, 255);
    fill(gray);
    arc(400, height/2, diameter, diameter, lastAngle, lastAngle+radians(angles[i]));
    lastAngle += radians(angles[i]);
  }
  }
}


void drawData2(float x, float y, String id, float diameter, int[] data) {
  //value variable equals second field in row
  float value = dataTable_d.getFloat(id, 1);
  float radius = 0;
  //if the value variable holds a float greater than or equal to 0
  if (value>=0) {
    //remap the value to a range between 1.5 and 15
    radius = map(value, 0, dataMax, 3, 50); 
    //and make it this color
    fill(175, 16, 16, 127);
  } else {
    //otherwise, if the number is negative, make it this color.
    radius = map(value, 0, dataMin, 1.5, 15);
    fill(#FFFF00);
  }
  //make a circle at the x and y locations using the radius values assigned above
  ellipseMode(RADIUS);
  ellipse(x, y, radius, radius);

  float d = dist(x, y, mouseX, mouseY);

  //if the mouse is hovering over circle, show information as text
  if ((d<radius+2) && (d<closestDist)) {
    closestDist = d;
    String name = nameTable.getString(id, 1);
    closestText = name +" "+value;
    closestTextX = x;
    closestTextY = y-radius-4;
    
     float lastAngle = 0;
  for (int i = 0; i < data.length; i++) {
    float gray = map(i, 0, data.length, 0, 255);
    fill(gray);
    arc(400,height/2, diameter, diameter, lastAngle, lastAngle+radians(angles[i]));
    lastAngle += radians(angles[i]);
  }

    
    //ellipse(400,400,100,100);
  }
}
// HELLO