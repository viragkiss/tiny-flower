// The boundary object for the tank

class Boundary {
  float x, y, w, h;
  color c;

  Body b;

  Boundary(float x_,float y_, float w_, float h_, color c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // Set body as box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }

  // Draw the boundary
  void display() {
    noStroke();
    fill(c);
    rectMode(CENTER);
    rect(x,y,w,h);
  }

}
