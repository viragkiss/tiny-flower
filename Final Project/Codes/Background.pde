// Draw a rectangle for the background

class Rectangle{
  
  float x, y, w, h;
  color colour;
  
  Rectangle(color c){
    x = 0;
    y = 0;
    w = width*40;
    h = height*40;
    colour = c;
  }
  
  void display(){
    noStroke();
    fill(colour);
    rect(x, y, w, h);
  }
}
