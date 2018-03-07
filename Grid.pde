class Grid{


  //fields
  int gridWidth;
  int gridHeight;
  int numGrid;
  int maxV;//maximum magnitude for Agent
  int d;//delayer
  int id;//unique id;
  Agent agent[] = new Agent[900];

  Grid(int w, int h, int m, int delayer) {
    gridWidth = w;
    gridHeight = h;
    maxV = m;
    d = delayer;
    numGrid = gridWidth*gridHeight;
    for(int i = 0; i<numGrid; i++) {
    agent[i] = new Agent(i, 0, 0, p, d, maxV);//initialize
    }
  }


  //visualize the grid
  void draw() {
    
    for(int i = 0; i<numGrid; i++) {
      Position p = new Position(mouseX, mouseY);
      agent[i].maxVSet(maxV);
      //agent[i].aSet(0);
      //agent[i].tSet(p);
      //deploy();
      agent[i].draw();
      //println("yay");
    }
    deploy();
    
    /*
    //draw horizontal grid
    for(int i = 0; i<numGrid -3; i++) {
      if(i >= 0 && i<gridWidth-3) { 
        noStroke();
        beginShape(POLYGON); 
        fill(255, 0, 0);
        vertex(agent[i].intP);
        fill(0, 255, 0);
        vertex(agent[i+1].intP);
        fill(0, 0, 255);
        vertex(agent[i+2].intP);
        fill(0, 255, 255);
        vertex(agent[i+3].intP);
        endShape();
      }
      for(int j = 2; j<=gridWidth; j++) {
        if(i >= gridWidth*(j-1) && i < gridWidth*j - 3) {
          beginShape(POLYGON);
          fill(255, 255, 0);
          vertex(agent[i].intP);
          fill(255, 0, 255);
          vertex(agent[i+1].intP);
          fill(0, 0, 255);
          vertex(agent[i+2].intP);
          fill(0, 255, 0);
          vertex(agent[i+3].intP);
          endShape();
        }
      }
    }
    */
    //color square
    //noStroke();
    //noFill();
    //stroke(0, 100);
    fill(255, 255, 255, 50);
    for(int i = 0; i<numGrid - gridWidth - 1; i++) {
      if(i >=0 && i< gridWidth - 1){
      noFill();
      beginShape(LINE_LOOP);
      stroke(0,200);
      vertex(agent[i].intP);
      stroke(255, 50);
      vertex(agent[i+1].intP);
      vertex(agent[i+gridWidth+1].intP);
      vertex(agent[i+gridWidth].intP);
      }
      for(int j = 2; j<=gridWidth; j++) {
      if(i >=gridWidth*(j-1) && i< gridWidth*j- 1){
      beginShape(LINE_LOOP);
      //fill(0,100);
      stroke(0,200);
      vertex(agent[i].intP);
      //fill(255,100);
      stroke(255,50);
      vertex(agent[i+1].intP);
      vertex(agent[i+gridWidth+1].intP);
      vertex(agent[i+gridWidth].intP);
      }
      }
      endShape();
    
  }
/*
    //draw vertical lines
    for(int i = 0; i<numGrid - 3*gridWidth; i++) {
      beginShape(POLYGON);
      fill(0, 0, i/3);
      vertex(agent[i].intP);
      vertex(agent[i+gridWidth].intP);
      vertex(agent[i+2*gridWidth].intP);
      endShape();
    }
    */
    //fill(255, 0, 0);
    //ellipse(agent[99].fp.x, agent[99].fp.y, 5 , 5);

  }

  //calculate all the positions based on gridWidth & gridHeight
  void deploy() {

    for(int i = 0; i<numGrid; i++) {
      if(i >= 0 && i<gridWidth) {  
        agent[i].fp.set((width/gridWidth)*i + (width/gridWidth)*0.5, (height/gridHeight)*0.5);
      }
      for(int j = 2; j<=gridWidth; j++) {
        if(i >= gridWidth*(j-1) && i < gridWidth*j) {
          agent[i].fp.set((width/gridWidth)*(i-gridWidth*(j-1))+(width/gridWidth)*0.5, (height/gridHeight)*(j-1) + (height/gridHeight)*0.5); 
        }
      }
    }

  }



}
