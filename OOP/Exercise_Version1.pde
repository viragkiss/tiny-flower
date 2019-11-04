/*
OOP Exercise
Intro to IM
Week 10

GOALS:
- to simulate a pair of eyes following a bouncing ball
- the white circles of the eyes should stay fixed, while the small black circles follow the movement
  of the ball within the constraints of the white circles - they can't leave the eye
- the ball should detect when it meets another object eg the edges of the canvas and the white circles,
  and bounce off that object
- the black circles should be able to detect their own boundaries and stay within the white circles while
  following the ball's motion

This code uses inheritance from superclass (bouncing ball) to subclass (bouncing black balls), while
  changing some of the subclass's methods
The other version of it is also an exercise in basic vector operations in Processing
*/


float [] speeds = {4, 5, 6, 7, 8};

float BIGCIRCLE = 75;     // radius of big eye balls
float SMALLCIRCLE = 10;   // radius of small bouncing ball

//this class is for the white of the eyes----------------------------------------------
class BigEyeBall {

  float bigx, bigy, bigw, bigh;

  BigEyeBall (float x, float y, float w, float h) {
    bigx = x;
    bigy = y;
    bigw = w;
    bigh = h;
  }

  void drawCircle() {
    fill(255);
    noStroke();
    ellipse(bigx, bigy, bigw, bigh);
  }
}
//-----------------------------End of the BigEyeBall class---------------------------------------


// this class is for the bouncing ball
// add a random small ball to bounce around the white ball(s) with x, y speed randomly chosen from an array
class BouncingBall {
  
  float smallx, smally, smallw, smallh, xSpeed, ySpeed;
  
  BouncingBall (float x, float y, float w, float h) {
    smallx = random(x);
    smally = random(y);
    smallw = w;
    smallh = h;
    xSpeed = speeds[int(random(0, 5))];  //random() returns a float --> convert to int to get index
    ySpeed = speeds[int(random(0, 5))];  //xSpeed - 1 is an alternate way to get the ySpeed
    
    // this statement is to avoid the ball getting "stuck" on one of the sides
    // and keep it continually bouncing all around the white circles
    // if ySpeed = xSpeed - 1, we don't need this
    while ( xSpeed <= ySpeed ) {
      ySpeed = speeds[int(random(0, 5))];
    }
}
  
  void update() {
    smallx += xSpeed;
    smally += ySpeed;
  }
  
  //this method was to try out how methods can use other objects as parameters
  void checkForOtherball(BouncingBall ball) {
    float d = dist(ball.smallx, ball.smally, smallx, smally);
    println("This is the distance: " + d);
  }
  
  // this function checks collisions of bouncing ball with edges of canvas and other balls
  void checkCollisions(BigEyeBall ball, BigEyeBall ball2) {
    if ( (smallx<SMALLCIRCLE) || (smallx>width-SMALLCIRCLE)) {
      // adding some random value to the speed makes motion more random
      xSpeed = -xSpeed + random(-1, 1);
    }
    if ( (smally<SMALLCIRCLE) || (smally>height-SMALLCIRCLE)) {
      ySpeed = -ySpeed + random(-1, 1);
    }
    if (dist(ball.bigx, ball.bigy, smallx, smally) < (BIGCIRCLE + SMALLCIRCLE)) {
      xSpeed = -xSpeed;
      ySpeed = -ySpeed;
    }
    if (dist(ball2.bigx, ball2.bigy, smallx, smally) < (BIGCIRCLE + SMALLCIRCLE)) {
      xSpeed = -xSpeed;
      ySpeed = -ySpeed;
    }
  }
  
  void drawCircle() {
    fill(255, 0, 0);
    noStroke();
    ellipse(smallx, smally, smallw, smallh);
  } 
  
  void printInfo() {
    println(smallx, smally);
    println(xSpeed, ySpeed);
    println("Distance between 2 points: " + dist(300, 400, smallx, smally));
  }
}

//-----------------------------end of bouncing ball class------------------------------------

// use a subclass to create bouncing black balls inside white ones like retinas
// subclass iherits basic properties and methods, other methods and properties get changed
class Retina extends BouncingBall {
  
  Retina (float x, float y, float w, float h) {
    super(x, y, w, h);
    smallx = x;
    smally = y;
  }
  
  void update(BouncingBall ball) {
    // using the bouncing ball's speed generates positions that look more random
    smallx += ball.xSpeed/25;
    smally += ball.ySpeed/25;
  }

  void checkForOtherball(BouncingBall ball) {
    float d = dist(ball.smallx, ball.smally, smallx, smally);
    println("This is the distance from inherited class: " + d);
  }
  
  void checkCollisions(BigEyeBall ball) {
    // eqv. to drawing a box around the black ball --> bouncing inside a box makes more fun motion
    // than bouncing inside a circle, which is always in one direction back and forth
    if ((smallx < (ball.bigx - BIGCIRCLE/2)) || (smallx > (ball.bigx + BIGCIRCLE/2))) {
      xSpeed = -xSpeed;
    }
    if ((smally < (ball.bigy - BIGCIRCLE/2)) || (smally > (ball.bigy + BIGCIRCLE/2))) {
      ySpeed = -ySpeed;
    }
    
    //this was in a version where the boundary of the black ball was the inside of the white ball
    /*super.checkCollisions(myeye);
    if (dist(ball.bigx, ball.bigy, smallx, smally) < (BIGCIRCLE - SMALLCIRCLE)) {
      xSpeed = -xSpeed;
      ySpeed = -ySpeed;
    }*/
  }
  
  void drawCircle() {
    super.drawCircle();
    fill(0);
    noStroke();
    ellipse(smallx, smally, smallw, smallh);
  }

  void printInfo() {
    super.printInfo();
    println("This is from the inherited class: " + smallx);
    println("This is from the inherited class: " + smally);
  }
}

//-----------------------------------end of retina class----------------------------------------


BigEyeBall myeye = new BigEyeBall(300, 400, 150, 150);
BigEyeBall myeye2 = new BigEyeBall(500, 400, 150, 150);

BouncingBall bouncebounce = new BouncingBall(750, 750, 20, 20);
Retina retina = new Retina(300, 400, 40, 40);
Retina retina2 = new Retina(500, 400, 40, 40);

void setup() {
  size(800, 800);
  smooth();
}

void draw() {
  background(144, 202, 249);
  
  myeye.drawCircle();
  myeye2.drawCircle();
  
  bouncebounce.update();
  bouncebounce.checkCollisions(myeye, myeye2);
  bouncebounce.drawCircle();
  bouncebounce.printInfo();
  bouncebounce.checkForOtherball(retina);
  
  retina.update();
  retina.checkCollisions(myeye);
  retina.drawCircle();
  retina.printInfo();
  retina.checkForOtherball(bouncebounce);
  
  retina2.update();
  retina2.checkCollisions(myeye2);
  retina2.drawCircle();
  retina2.printInfo();
  retina2.checkForOtherball(bouncebounce);

}
