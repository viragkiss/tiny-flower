
//feature colors are global
color skin = color(236, 188, 180);
color lips = color(255, 0, 150);
color hair = color(56, 18, 22);

void setup() {
  size(1000, 1000);
  background(0, 150, 150);
  noStroke();
  frameRate(20);

  //hair
  fill(hair);
  stroke(hair);
  pushMatrix();
  translate(450, 0);
  rotate(radians(-15));

  beginShape();
  vertex(30, 70);
  bezierVertex(25, 25, 100, 50, 50, 100);
  bezierVertex(20, 130, 75, 140, 120, 130);
  bezierVertex(145, 130, 200, 100, 160, 200);
  bezierVertex(150, 280, 270, 110, 250, 350);
  bezierVertex(250, 390, 300, 500, 400, 350);
  bezierVertex(395, 360, 480, 200, 470, 450);
  bezierVertex(470, 560, 800, 250, -250, 2000);
  endShape();
  popMatrix();

  beginShape();
  fill(hair);
  vertex(500, 60);
  bezierVertex(470, 25, 450, 30, 450, 70);
  bezierVertex(450, 90, 420, 140, 330, 70);
  bezierVertex(260, 30, 220, 30, 250, 130);
  bezierVertex(270, 260, 200, 150, 130, 150);
  bezierVertex(5, 150, 5, 400, 100, 430);
  bezierVertex(170, 450, 50, 500, 1, 400);
  bezierVertex(1, 400, -300, 2000, 1000, 2000);
  bezierVertex(1000, 2000, 500, 500, 505, 60);
  endShape();
}

void draw() {

  //face
  noStroke();
  fill(skin);
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(frameCount * 3.7 % 360));
  translate(0, 200);
  triangle(-100, 100, 0, -200, 100, 100);
  popMatrix();
  println(frameCount);


  //eyelashes
  stroke(hair);
  noFill();
  arc(680, 288, 80, 80, 0, PI / 2);
  arc(670, 290, 80, 80, 0, PI / 2);
  arc(660, 292, 80, 80, 0, PI / 2);
  arc(650, 296, 80, 80, 0, PI / 2);
  arc(640, 298, 80, 80, 0, PI / 2);

  arc(320, 288, 80, 80, PI / 2, PI);
  arc(330, 290, 80, 80, PI / 2, PI);
  arc(340, 292, 80, 80, PI / 2, PI);
  arc(350, 296, 80, 80, PI / 2, PI);
  arc(360, 298, 80, 80, PI / 2, PI);


  //eyes
  noStroke();
  fill(255);
  arc(350, 350, 200, 100, radians(20), radians(230), CHORD);
  arc(650, 350, 200, 100, radians(-50), radians(160), CHORD);
  fill(0, 150, 50);
  arc(350, 350, 100, 100, radians(2), radians(217), CHORD);
  arc(650, 350, 100, 100, radians(-37), radians(178), CHORD);
  fill(0);
  ellipse(350, 360, 48, 48);
  ellipse(650, 360, 48, 48);
  fill(255);
  ellipse(330, 360, 15, 15);
  ellipse(630, 360, 15, 15);

  //neck
  noStroke();
  fill(skin);
  rect(330, 700, 320, 320);

  //nose
  fill(skin);
  strokeWeight(2.5);
  stroke(230, 0, 50);
  arc(500, 525, 80, 50, 0, PI);
  arc(445, 525, 30, 20, 0, PI);
  arc(555, 525, 30, 20, 0, PI);

  //mouth
  strokeWeight(2.5);
  stroke(lips);
  fill(lips);
  arc(460, 650, 100, 50, -PI, 0);
  arc(545, 650, 100, 50, -PI, 0);
  arc(503, 650, 183, 100, 0, PI);

  //extra hair
  noStroke();
  fill(hair);
  translate(600, 180);
  rotate(radians(30));
  arc(0, 0, 350, 150, 0, PI);

  translate(-200, 130);
  rotate(radians(-45));
  arc(0, 0, 350, 150, 0, PI);

  translate(190, 800);
  rotate(radians(120));
  arc(0, 0, 350, 350, 0, PI);

  translate(100, 550);
  rotate(radians(150));
  arc(0, 0, 300, 350, 0, PI);
}
