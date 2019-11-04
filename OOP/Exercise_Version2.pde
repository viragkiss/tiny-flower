float [] speeds = {4, 5, 6, 7, 8};   //5 elements

float BIGCIRCLE = 75;
float SMALLCIRCLE = 10;
float BOUNDARY = 375;

//this class is for the white of the eyes
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


//this class is for the bouncing ball
class BouncingBall {
  PVector location;
  PVector velocity;
  
  float smallx, smally, smallw, smallh, xSpeed, ySpeed;
  
  BouncingBall (float x, float y, float w, float h) {
    smallx = random(x);
    smally = random(y);
    smallw = w;
    smallh = h;
    xSpeed = speeds[int(random(0, 5))];  //random() returns a float --> convert to int to get index
    ySpeed = speeds[int(random(0, 5))];  //xSpeed - 1;

    // this statement is to avoid the ball getting "stuck" on one of the sides
    // and keep it continually bouncing all around the white circles
    // if ySpeed = xSpeed - 1, we don't need this
    while ( xSpeed <= ySpeed ) {
      ySpeed = speeds[int(random(0, 5))];
    }
    
    location = new PVector(smallx, smally);
    velocity = new PVector(xSpeed, ySpeed);
}
  
  void update() {
    location.add(velocity);
  }
  
  void checkCollisions(BigEyeBall ball, BigEyeBall ball2) {
    if ( (location.x<SMALLCIRCLE) || (location.x>width-SMALLCIRCLE)) {
      velocity.x = velocity.x*-1 + random(-1, 1);
    }
    if ( (location.y<SMALLCIRCLE) || (location.y>height-SMALLCIRCLE)) {
      velocity.y = velocity.y*-1 + random(-1, 1);
    }
    if (dist(ball.bigx, ball.bigy, location.x, location.y) < (BIGCIRCLE + SMALLCIRCLE)) {
      velocity.x = velocity.x*-1;
      velocity.y = velocity.y*-1;
    }
    if (dist(ball2.bigx, ball2.bigy, location.x, location.y) < (BIGCIRCLE + SMALLCIRCLE)) {
      velocity.x = velocity.x*-1;
      velocity.y = velocity.y*-1;
    }
  }
  
  void drawCircle() {
    fill(255, 0, 0);
    noStroke();
    ellipse(location.x, location.y, smallw, smallh);
  } 
  
  void printInfo() {
    println(location.y, location.y);
    println(velocity.x, velocity.y);
  }
}

//-----------------------------end of bouncing ball class------------------------------------


class Retina extends BouncingBall {
  
  Retina (float x, float y, float w, float h) {
    super(x, y, w, h);
    smallx = x;
    smally = y;
    location = new PVector(smallx, smally);
  }
  
  void update(BouncingBall ball) {
    location.add(ball.velocity);
  }
  
  void drawCircle() {
    super.drawCircle();
    fill(0);
    noStroke();
    ellipse(location.x, location.y, smallw, smallh);
  }

  void printInfo() {
    super.printInfo();
    println("This is from the inherited class: " + location.x);
    println("This is from the inherited class: " + location.y);
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
  
  retina.update(bouncebounce);
  retina.drawCircle();
  retina.printInfo();
  
  retina2.update(bouncebounce);
  retina2.drawCircle();
  retina2.printInfo();
}
