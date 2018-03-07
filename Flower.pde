class Flower {

  int numPet;
  int del;
  float trans;
  float radius;
  //float percentage;
  float over;
  float dVal;
  int numIt;
  Position origin;
  Position now;
  Crystalline petals[];
  float randomize[];//randomizes the angle that flower is being formed.
  float randomVal = PI/10;//variation of random value
  color fillIn;
  color fillOut;
  char type;

  //defaault constructor
  Flower() {  
  }

  Flower(Position o, float r, int numIteration, int d, float decreVal, float t, float ov, int numPetal, Position curPos, color c1, color c2, char character) {
    origin = new Position(o);
    radius = r;
    numIt = numIteration;
    numPet = numPetal;
    dVal = decreVal;
    del = d;
    over = ov;
    trans = t;
    type = character;
    now = new Position(curPos);
    petals = new Crystalline[numPet]; 
    randomize = new float[numPet];
    fillIn = c1;
    fillOut = c2;


    for(int i = 0; i<numPet; i++) {
      /*order:
      (pos)position, (float)width, (int)iteration, (int)del, (float)decPer, (int)trans, (float)over, (color)c1, (color)c2
      */
      randomize[i] = random(-randomVal, randomVal);
      petals[i] = new Crystalline(
      //origin, genWid(radius), genIter(numPet), del, genDecre(percentage), genTrans(trans), genOver(percentage) 
      //origin, genWid(radius), numIt, del, dVal, trans, over
      //nullPoint, radius, (int)random(7, 10), (int)random(20, 40), random(0.6, 0.8), trans, random(0.1, 0.3)
      nullPoint, radius,  (int)random(numIt/2, numIt), (int)random(del/1.5, del), random(0.6, 0.8), trans, (int)random(0.1, 0.3), fillIn, fillOut, type
      );
    } 
  }
  
  void drawAll() {
    if(type == 'a' || type == 'b') {
     pushMatrix();
     translate(now.x, now.y);
     for(int i = 0; i<numPet; i++) {
       //pushMatrix();
     //translate(radius, -radius/2);
     rotate(TWO_PI/numPet + randomize[i]);
     //petals[i].wid1+=(int)random(0, radius/2);
     //fill(0, i);
     petals[i].drawAll();
     //petals[i].keyPressed();   
     //popMatrix();
     }   
     popMatrix();
     keyPressed();
    }
  }
  //void updateTrans(
  int getPetal() {
     return numPet; 
  }

  //generate width for Crystalline 
  float genWid(float me) {
    me += random(-me/10, me/10);
    return me; 
  }
  //generate num of iteration for Crystalline
  int genIter(int me) {
    me += (int)random(-me/2, me/2);
    return me; 
  }
  //generate delayer for Crystalline
  int genDel(int me) {
    me += (int)random(-me/10, me/10);
    return me; 
  }
  //generate decreaser for Crystalline
  float genDecre(float me) {
    me += random(-0.1, 0.1);
    return me; 
  } 
  //generate transparency for Crystalline
  float genTrans(float me) {
    me += random(-10, 10);
    return me; 
  }
  //generate overlap for Crystalline
  float genOver(float me) {
    me += random(-0.05, 0.05);
     return me; 
  }
  
  void keyPressed() {
  if(key == 'a') {
    
  }
    
  }
  
  void fadeAway() {
    for(int i = 0; i<numPet; i++) {
       petals[i].trans--;
      //println("yay"); 
    } 
    println("yay");
  }
  
}
