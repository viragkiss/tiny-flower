// A box body

class Box {

  Body body;
  float x, y, w, h;
  color myColor;

  Box(float x_, float y_, color c) {
    x = x_;
    y = y_;    
    w = random(5, 30);
    h = random(5, 30);
    myColor = c;
    // Add the box to the box2d world
    makeBody(new Vec2(x, y), w, h);
  }

  // This function removes the particle from the box2d world
  // Same as for Ball class
  void killBody() {
    box2d.destroyBody(body);
  }

  boolean done() {
   Vec2 pos = box2d.getBodyPixelCoord(body);  
   if ((abs(Xcoord - pos.x) < 60) && (abs(Ycoord - pos.y) < 60)) {
   killBody();
   return true;
   }
   return false;
   }
   
  void applyForce(Vec2 force) {
    Vec2 pos = body.getWorldCenter();
    body.applyForce(force, pos);
  }

  // Same as for Ball class
  void attract(float x, float y) {
    Vec2 worldTarget = box2d.coordPixelsToWorld(x, y);   
    Vec2 bodyVec = body.getWorldCenter();
    worldTarget.subLocal(bodyVec);
    worldTarget.normalize();
    worldTarget.mulLocal((float) 200);
    body.applyForce(worldTarget, bodyVec);
  }


  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(myColor);
    noStroke();
    rect(0, 0, w, h);
    popMatrix();
  }

  // This function adds the rectangle to the box2d world
  void makeBody(Vec2 center, float w_, float h_) {

    // Define a polygon
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.5;

    // Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));

    body = box2d.createBody(bd);
    body.createFixture(fd);
  }
}
