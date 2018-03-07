class Crystal {
  /*
  let the crystal flow in only one angle, for a short period
   of time. this will be a preliminary state before the crystal
   transforms into a grid system.
   
   */

  //these are the positions of 4 points
  Position topLeft;
  Position topRight;
  Position bottomRight;
  Position bottomLeft;
  //this guy is used when the flow mode has started
  Vector v;
  //this is the acceleration vector that is added to V
  Vector acc;
  Position temp;
  //this guys isthe center of four points.
  Position center;
  //whether there is any specific pos-data stored or not
  boolean activate = false;
  float mass;
  int r = 0;
  Vehicle vehi;
  color fillIn;//first color value
  color fillOut;//second color value 
  boolean flow = false;
  boolean grow = false;
  //int a = 0;
  //int b = 0;

 



  //default constructor
  Crystal(Position p1, Position p2, Position p3, Position p4, Position p5, color c1, color c2){
    temp = new Position(0, 0);
    topLeft = p1;
    topRight = p2;
    bottomRight = p3;
    bottomLeft = p4;
    center = p5;
    fillIn = c1;
    fillOut = c2;
    mass = dist(p1, p4);
    v = new Vector(center, PI/2, 5);
    acc = new Vector(center, PI/2, 1);
    vehi = new Vehicle(center, PI/2, 5, mass*5 ,1 ,2,40);
    
    //the booleans are activated: Transition can now gather p1, p2, p3, p4 as valus
    activate = true;

  }

  //draws the crystall
  void draw() {
    //println(acc.a);
    //translate(-acc.p.x, -acc.p.y);
    pushMatrix();
    translate(vehi.location.x, vehi.location.y);
    if(flow == true) {
    rotate(vehi.velocity.a*PI/180);
    }
    noFill();
    beginShape(POLYGON);
    stroke(fillIn);
    //stroke(255, 20);
    //curveVertex(topLeft);

    //stroke(0, 20);
    vertex(topLeft);
        stroke(fillOut);
    vertex(topRight);
    vertex(bottomRight);
    vertex(bottomLeft);
    //curveVertex(bottomLeft);
    endShape();
    popMatrix();
    //println(topLeft.x);
    //fill(red);
    //ellipse(topRight.x, topRight.y, 3 ,3); //this guy is the one!!!
    //topLeft.x+=100;
    //fill(255, 0, 0);
    //ellipse(acc.p.x, acc.p.y, 5, 5);
    //fill(0, 255, 0);
    //ellipse(center.x, center.y, 5, 5);
    //vehi.update();
    //vehi.draw();
    //vehi.drawAllVectors();
  }

  //let the crystal flow
  void flow() {  
    keyPressed();
    grow();
    //println("yay");
    if(flow == true) {
      //v = v.add(acc);
      //temp = displace(acc.p, acc.a, acc.m);
      //acc.setStart(temp);
      //drawVector(acc);
      pushMatrix();
      vehi.update();
      vehi.draw();
      popMatrix();
      //vehi.drawAllVectors();
      //println("yay");
      //center.x += 1;
      //center.y += 1.9;
      //center.x = center.x + acc.p.x;
      //center.y = center.y + acc.p.y;
      //topLeft.x += acc.p.x;
      //topLeft.y += acc.p.y;
      //topRight.x += acc.p.x;
      //topRight.y += acc.p.y;
      //bottomLeft.x += acc.p.x;
      //bottomLeft.y += acc.p.y;
      //bottomRight.x += acc.p.x;
      //bottomRight.y += acc.p.y;
    } 
  }
  
  void grow() {
    if(grow == true) {
      //vehi.location.x++;
      //vehi.location.y++;
       //topLeft.x++;
       //topLeft.y++;
       //topRight.x++;
       //topRight.y++;
       //bottomLeft.x++;
       //bottomLeft.y++;
       //bottomRight.x++;
       //bottomRight.y++;  
      //println(topLeft.x);
    }
  }
  //returns the number of positions that are being activated
  int returnPosNum() {
    if(activate == true) {
    return 4;
    }
    else return 0;
  }
  



  void keyPressed() {
    if(key == 'a') {
      flow = true; 
    }
    if(key == 's') {
      grow = true; 
    }
  }
}
