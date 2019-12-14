/*
Virag Kiss
Intro to IM Final Project
12/12/2019

Project Title: Rainbow Tank
 
 A bunch of colourful boxes and circles to simulate fluid particles.
 Draw objects when mouse is pressed at mouse position.
 Objects move like a fluid because they have different density and restitution attributes.
 Press 'UP' arrowkey to exert force and attract boxes to the mouse.
 Press 'DOWN' to delete objects around the mouse position.
 Press 'w' or 'b' to adjust background color from black to white and vice versa.
 
 */

// This sketch uses Dan Shiffman's Box2d library to simluate fluid
//particles, their movements and interactions.
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import processing.serial.*;

// Connect to the Arduino Serial Communication
Serial myPort;

// Use ArrayList to track objects: boundaries of the tank and
// fluid particles (rectangles and circles)
ArrayList<Boundary> boundaries;
ArrayList<Box> boxes;
ArrayList<Ball> circles;

// Use the background class to update visuals at key commands
Rectangle backGround;

Box2DProcessing box2d;

//HSB - increment Hue every frame + depending on x coordinate
//store times mouse is clickes & released in an array - change colour accordingly
//attraction to mouse/repulsion

float Xcoord;
float Ycoord;
color white;
color black;
color fullWhite;
color fullBlack;
// Intrcutions for the user
String message = "Press laptop mouse and rotate the joystick to add particles\n" + 
"Press 'UP' arrowkey to exert force and attract boxes to the mouse.\n" +
"Press 'DOWN' to delete objects around the mouse position.\n" +
"Press 'w' or 'b' to adjust background color from black to white and vice versa.";

void setup() {
  fullScreen();
  noCursor();
  smooth();
  colorMode(HSB, 100);

  // Create trailing effect of particles by adjusting transparency of background.
  white = color(0, 0, 100, 30);
  black = color(0, 0, 0, 30);
  // No transparency for colors used to fill boundary objects
  fullWhite = color(0, 0, 100);
  fullBlack = color(0, 0, 0);
  
  // The background initially appears black
  backGround = new Rectangle(black);

  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');


  // Initialize and create the Box2D world
  box2d = new Box2DProcessing(this);	
  box2d.createWorld();
  box2d.setGravity(0, -20);

  // Add some boundaries
  boundaries = new ArrayList<Boundary>();
  boundaries.add(new Boundary(width/2, height-5, width, 10, fullWhite));  // bottom
  boundaries.add(new Boundary(width/2, 5, width, 10, fullWhite));  // top
  boundaries.add(new Boundary(width-5, height/2, 10, height, fullWhite));  // right
  boundaries.add(new Boundary(5, height/2, 10, height, fullWhite));  // left

  // Create partciles ArrayLists
  circles = new ArrayList<Ball>();
  boxes = new ArrayList<Box>();
}

void draw() {
  backGround.display();

  // step through time
  box2d.step();

  if (mousePressed) {
    
    // Add particles to ArrayLists when mouse is pressed
    // Adjust HSB value: increment Hue according to X value;
    // decrement Brightness according to Y value
    // Dividing by 20 and 5 makes a nice spectrum of all possible colors
    
    Ball c = new Ball(Xcoord, Ycoord, color(Xcoord/20, Ycoord/5, 100));
    circles.add(c);

    Box b = new Box(Xcoord, Ycoord, color(Xcoord/20, Ycoord/5, 100));
    boxes.add(b);
  }

  // Display objects
  for (Ball cc : circles) {
    cc.display();
  }
  for (Box bb : boxes) {
    bb.display();
  }

  // Show boundaries
  for (Boundary wall : boundaries) {
    wall.display();
  }
  
  // Print instructions
  printInfo();
}

void printInfo() {
  fill(color(0, 100, 100));
  textSize(15);
  textAlign(LEFT);
  text(message, 20, 30);
}

// Key actions
// The joystick has to be moved while the relevant key is constantly pressed
void keyPressed() {
  if (keyCode == UP) {
    for (Ball c : circles) {
      c.attract(Xcoord, Ycoord);
    }
    for (Box b : boxes) {
      b.attract(Xcoord, Ycoord);
    }
  }
  if (key == 'w') {
    backGround.colour = white;
    for (Boundary b : boundaries) {
      b.c = fullBlack;
    }
  }
  if (key == 'b') {
    backGround.colour = black;
    for (Boundary b : boundaries) {
      b.c = fullWhite;
    }
  }
  if (keyCode == DOWN) {
    // Remove particle from ArrayList - also has to be removed from box2d world
    for (int i = boxes.size()-1; i >= 0; i--) {
      Box b = boxes.get(i);
      if (b.done()) {
        boxes.remove(i);
      }
    }
    for (int i = circles.size()-1; i >= 0; i--) {
      Ball c = circles.get(i);
      if (c.done()) {
        circles.remove(i);
      }
    }
  }
}

// Communicate with Arduino by sending the ASCII code for 'A'
// when ready for new information

void serialEvent(Serial myPort) {

    String myString = myPort.readStringUntil('\n');
    myString = trim(myString);
    int sensors[] = int(split(myString, ','));

    // Map values to screen width and height
    // Inversely map Y values to change Arduino joystick orientation
    // ((0,0) is bottom left) to Processing orientation ((0,0) is top left)
    
    if (sensors.length > 1) {
      Xcoord = map(sensors[0], 0, 1023, 0, width);
      Ycoord = map(sensors[1], 0, 1023, height, 0);
      //println("xcoord y coord are", Xcoord, Ycoord);  // for debugging
    }
    myPort.write("A");
  }
