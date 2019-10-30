/*Recreate an old computer art from Triangulation
by Virag Kiss
Intro to IM
Week 9

Populate the canvas with squares within squares

*/


//width and height of rectangle
float w = 50;
float h = 50;

void setup() {
  size(503, 503);
  background(0);
}

void drawRectangle (float x, float y, float w, float h) {
  rect(x, y, w, h);
}

void draw() {

  stroke(255, 0, 0);
  strokeWeight(2);
  noFill();

  int intArray [] = new int [] {0, 5, 10, 15, 20};
  float floatArray [] = new float [] {1.25, 1.65, 2.4, 4.6, 75};

  for (int x = 2; x < width; x+=50) {
    for (int y = 2; y < width; y += 50) {
      drawRectangle(x, y, w, h);

      //trying to get the squares to be drawn random times- eg first big has only one small, second has 4, etc.
      for (int i = 0; i<=random(1, 5); i++) { 
        pushMatrix();
        translate(5, 5);
        drawRectangle(x + intArray[i], y + intArray[i], w/floatArray[i], h/floatArray[i]);      
        popMatrix();
        //break;
      }
    }
  }
}



/* Trying to get the squares to rotate
 pushMatrix();
 translate(x+(w/2), y);
 rotate(PI/4);
 rawRectangle(x, y, w/1.25, h/1.25);
 popMatrix();*/
