// A circular body

class Ball {
  // Instead of any of the usual variables, store a reference to a Box2D Body
  Body body;      

  float x, y, r;
  color myColour;

  Ball(float x_, float y_, color c) {
    r = 10;
    x = x_;
    y = y_;    
    myColour=c;

    // Build Body
    BodyDef bd = new BodyDef();    
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));
    body = box2d.createBody(bd);


    // Define a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r); 


    // Define a fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.9;   //was 0.3 // apply more force - heavier
    fd.restitution = 1;   //was 0.5 // make more bouncy

    // Attach Fixture to Body               
    body.createFixture(fd);
  }
  
  // This function removes the particle from the box2d world
  // We have to remove the particle from both the box2d world and the ArrayList
  void killBody() {
    box2d.destroyBody(body);
  }

  boolean done() {
   // Particle can be removed if it's around the mouse when DOWN arrow is pressed
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
  
  void attract(float x, float y) {
    // From BoxWrap2D example
    Vec2 worldTarget = box2d.coordPixelsToWorld(x, y);   
    Vec2 bodyVec = body.getWorldCenter();
    // First find the vector going from this body to the specified point
    worldTarget.subLocal(bodyVec);
    // Then, scale the vector to the specified force
    worldTarget.normalize();
    worldTarget.mulLocal((float) 200);
    // Now apply it to the body's center of mass.
    body.applyForce(worldTarget, bodyVec);
  }

  void display() {
    // Look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(myColour);
    noStroke();
    strokeWeight(1);
    ellipse(0, 0, r*2, r*2);
    // For debugging: add a line so we can see the rotation
    //line(0, 0, r, 0);
    popMatrix();
  }
}
