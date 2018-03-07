class Crystalline {

  Position origin;
  Position tempP;
  Position child[];                   /* position of all the child crystals */
  Position childInterpolated[];
  Position childCenter[];
  float wid1;
  int numCrystal;                     /* total number of crystals */
  float tempWid = 0;
  int iteration;                      /*iteration number of crystals */
  float orgInter = 0;
  float del;
  int counter = 0;                    /* counter used for iteration process */
  float wide[];
  float childInter[];                 /* holds the interpolator value for each crystalline child */
  int randomize[];                    /* a value that randomizes the shape of the crystalline child */
  int randomVal;                      /* the variation of randomness */
  float randomDiv;                      /* the variation of randomness used for Crystalline Formation */
  Position posInter[];                /* interpolation value used */
  boolean startGrow[];                /* controls the timing of the growth of crystalline child */
  boolean readyGrow[];                /* controls the timing of the growth of crystalline child */
  Position p1[];                      /* position data for left-top crystal */
  Position p2[];                      /* position data for right-top crystal */
  Position p3[];                      /* position data for right-bottom crystal */
  Position p4[];//position data for left-bottom crystal
  Crystal c[];//crystal structures
  float threshold = 0.2;//20%
  float decreaseVal;//this determines how slowly the crystalline children get smaller
  int growCounter = 1;
  float comp;
  float trans;
  float overlap;//determines the overlaps of the crystals
  //boolean flow = true;//this controls wheather the crystal parts will flow or not.
  boolean flow = false;
  boolean grow = false;
  color fillIn;
  color fillOut;
  char type;//determines the type of the crystal formation
  //default constructor
  Crystalline() {
  }

  Crystalline(Position o, float w1, int numIt, int delayer, float decreVal, float transparency, float over, color c1, color c2, char character) {
    origin = new Position(o);
    tempP = new Position(o);
    wid1 = w1;
    tempWid = wid1;
    iteration = numIt;
    randomVal = (int)random(-5, 5);
    randomDiv = random(0.5, 3);
    //comp = complex;
    child = new Position[iteration];
    randomize = new int[iteration];
    childCenter = new Position[iteration];
    childInter = new float[iteration];
    wide = new float[iteration];
    startGrow = new boolean[iteration];
    readyGrow = new boolean[iteration];
    posInter = new Position[iteration];
    c = new Crystal[iteration];
    p1 = new Position[iteration];
    p2 = new Position[iteration];
    p3 = new Position[iteration];
    p4 = new Position[iteration];
    del = delayer;
    trans = transparency;
    decreaseVal = decreVal;
    overlap = over;
    fillIn = c1;
    fillOut = c2;
    posInter[0] = new Position(origin);
    type = character;
    //initialize everything
    for(int i = 1; i<iteration; i++){
      child[i] = new Position(0, 0); //initialize with placeholder value
      childCenter[i] = new Position(0, 0);//initialize with placeholder value
      posInter[i] = new Position(origin);
      childInter[i] = 0;//initialize
      startGrow[i] = false;
      readyGrow[i] = false;
      wide[i] = 0;
      randomize[i] = (int)random(-randomVal, randomVal);
      p1[i] = new Position(0, 0);
      p2[i] = new Position(0, 0);
      p3[i] = new Position(0, 0);
      p4[i] = new Position(0, 0);
    }
  }
  //first the original crystal grows
  void crystallize() {
    childCenter[0] = new Position(origin);
    for(int i = 0; i<iteration-1; i++) {
      calcAllPos(wide[i], childCenter[i], i);
    }

  }

  void drawAll(){
    calcAllWid();
    crystallize();
    valInter();
    growRule();
    //println(randomize[1]);
    keyPressed();

  }
  //interpolates the various values
  void valInter() {
    //grow crystall
    orgInter += interpolator(wid1, orgInter, del);
    for(int i = 0; i<iteration; i++) {
      if(readyGrow[i] == true) {
        childInter[i] += interpolator(wide[i], childInter[i], del);
        posInter[i].x += interpolator(childCenter[i].x, posInter[i].x, del);
        posInter[i].y += interpolator(childCenter[i].y, posInter[i].y, del);
      }
    }

  }
  //calculate all the width of crystalline children
  void calcAllWid() {
    for(int i = 0; i<iteration; i++) {
      wide[i] = wid1 * pow(decreaseVal, i);
    }

  }

  //calculate all the position of crystalline children
  void calcAllPos(float wid, Position pos, int ID) {
    //if the flow-mode is not yet activated

    //child[ID] = new Position(pos.x - wide[ID]/randomDiv+ overlap*wide[ID] + randomize[ID] +childInter[ID], pos.y -wide[ID]/2 + overlap*wide[ID] + randomize[ID] + childInter[ID]);
   
    //child[ID] = new Position(pos.x - wide[ID]/2 + overlap*wide[ID] + randomize[ID] +childInter[ID], pos.y - wide[ID]/2 + overlap*wide[ID] + randomize[ID] + childInter[ID]);
    //child[ID] = new Position(pos.x + childInter[ID], pos.y + childInter[ID]);
    //child[ID] = new Position(pos.x, pos.y);
    //type a
    if(flow == false && grow ==false && type == 'a') {
      //fill(0, ID);
      //p1[ID] = new Position(origin.x + wide[0], origin.y + wide[0]);
      //p1[ID] = new Position(wide[0], wide[0]); 
       child[ID] = new Position(pos.x + overlap*wide[ID] + randomize[ID] +childInter[ID], pos.y + overlap*wide[ID] + randomize[ID] + childInter[ID]);
      p1[ID] = new Position(0, 0);
      p2[ID] = new Position(posInter[ID].x -childInter[ID], posInter[ID].y + childInter[ID]);
      p3[ID] = new Position(child[ID].x, child[ID].y);
      p4[ID] = new Position(posInter[ID].x +childInter[ID], posInter[ID].y - childInter[ID]);
      c[ID] = new Crystal(p1[ID], p2[ID], p3[ID], p4[ID], child[ID], fillIn, fillOut);
      //fill(red);
      //ellipse(childCenter[ID].x, childCenter[ID].y, 3 ,3);
      //ellipse(child[ID].x, child[ID].y, 3 ,3);
    }
    //type b
    if(flow == false && grow ==false && type == 'b') {
      //fill(0, ID);
      //p1[ID] = new Position(origin.x + wide[0], origin.y + wide[0]);
      //p1[ID] = new Position(wide[0], wide[0]); 
      child[ID] = new Position(pos.x + childInter[ID] - posInter[ID].x, pos.y + childInter[ID] + posInter[ID].y);
      p1[ID] = new Position(0, 0);
      p2[ID] = new Position(posInter[ID].x -childInter[ID], posInter[ID].y + childInter[ID]);
      p3[ID] = new Position(child[ID].x, child[ID].y);
      p4[ID] = new Position(posInter[ID].x +childInter[ID], posInter[ID].y - childInter[ID]);
      c[ID] = new Crystal(p1[ID], p2[ID], p3[ID], p4[ID], child[ID], fillIn, fillOut);
      //fill(red);
      //ellipse(childCenter[ID].x, childCenter[ID].y, 3 ,3);
      //ellipse(child[ID].x, child[ID].y, 3 ,3);
    }
    
    if(flow == false && grow == false && type == 'c') {
      child[ID] = new Position(pos.x + overlap*wide[ID] + randomize[ID] +childInter[ID], pos.y + overlap*wide[ID] + randomize[ID] + childInter[ID]);
      p1[ID] = new Position(0, 0);
      p2[ID] = new Position(posInter[ID].x -childInter[ID], posInter[ID].y + childInter[ID]);
      p3[ID] = new Position(child[ID].x, child[ID].y);
      p4[ID] = new Position(posInter[ID].x +childInter[ID], posInter[ID].y - childInter[ID]);
      c[ID] = new Crystal(p1[ID], p2[ID], p3[ID], p4[ID], child[ID], fillIn, fillOut);
    }
    
    childCenter[ID + 1] = new Position(child[ID].x - wide[ID]*decreaseVal/2, child[ID].y - wide[ID]*decreaseVal/2);
    //childCenter[ID + 1] = new Position(child[ID].x + wide[ID], child[ID].y + wide[ID]);
    //childCenter[ID + 1] = new Position(child[ID].x, child[ID].y);
    //c[ID].centerPosIntake(child[ID]);
    //if the flow-mode is activated
    if(flow == true) {
      c[ID].flow = true; 
      //println("yay");
    }
    //fill(white, trans);
    fill(255, 255, 255, trans);

    c[ID].draw();
    c[ID].flow();
    //noFill();
    //stroke(black, trans);
    noStroke();
    /*
    beginShape(POLYGON);
     //fill(white);
     vertex(origin.x + wide[0], origin.y + wide[0]);
     //fill(black);
     vertex(posInter[ID].x -childInter[ID], posInter[ID].y + childInter[ID]);
     //fill(black);
     vertex(child[ID].x, child[ID].y);
     //fill(black);
     vertex(posInter[ID].x +childInter[ID], posInter[ID].y - childInter[ID]);
     endShape(); 
     */

  }
  //store mouse position
  /*
  void getMouse(float x, float y) {
    origin.x = x;
    origin.y = y;
  }
  */

  //controls the growth timing 
  void growRule() {
    if(orgInter + wide[0]*threshold >= wide[0]){
      startGrow[0] = true;
    }
    for(int i = 0; i<iteration-1; i++) {
      if(startGrow[i] == true) {
        readyGrow[i] = true;
        if(childInter[i] + wide[i]*threshold >= wide[i]) {
          startGrow[i+1] = true;
        }
      }
    }
  }  
  
  //get the number of activated points of crystal
  int getCrystalNum() {
    int me = 0;
    for(int i = 0; i<iteration-1; i++) {
    me += iteration*c[i].returnPosNum();//get the number of activated crystals
    }
    return me;
  }
  //returns the number of counted activated points of crystal
  int returnCrystalNum(){
    return numCrystal;
  }
  
  void keyPressed() {
    if(key == 'a'){
      flow = true;
      numCrystal = getCrystalNum();
      //println(iteration);
      //println(numCrystal);
    } 
    if(key == 's') {
       grow = true; 
    }
  }

}

