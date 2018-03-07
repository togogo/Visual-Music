class Modifier {

  //fields
  float x;//x position
  float y;//y position
  Position p;//position data, combination of xy
  float r;//radius that affects the Agents
  int gridNum = 900;//max number  of Agents to search
  Position d[] = new Position[gridNum];//for storing the distance of
  Position temp[] = new Position[gridNum];
  Position close[] = new Position[gridNum];//x is used for distance, y is used for storing the ID number.
  Position nullPos = new Position(-1, -1);//null position
  int id;//unique id


    Modifier(float xpos, float ypos, float radius, int naxNum, int ID) {
    x = xpos;
    y = ypos;
    p = new Position(xpos, ypos);
    r = radius;
    id = ID;
    for(int i = 0; i<gridNum; i++) {
      d[i] = new Position(0, 0);
      close[i] = new Position(0, 0);
      temp[i] = new Position(0, 0); 
    }
  }



  void draw() {
    //fill(0, 255, 0);
    //ellipse(x, y, r, r);
    sort();
    getClosest();
    sendT();
    //println(d[0].x);
  }

  void setP(Position pos) {
    x = p.x;
    y = p.y;
    p = new Position(pos);

  }

  // search if there are any points within the radius
  void getDistance() {
    for(int i = 0; i<numGrid; i++) {
      d[i].x = dist(p, grid.agent[i].fp);
      d[i].y = grid.agent[i].getID();
    }

  }

  Position compareR(Position n) {
    if(r/2 >= n.x) {
      //println(n.y);
      //fill(0, 0, 255);
      //rect(grid.agent[(int)n.y].fp.x, grid.agent[(int)n.y].fp.y, 10, 10);
      //println("yay");
      return n;
    }
    else
      return nullPos;
  }

  void set(Position pos) {
    p = pos;
  }

  void sort() {
    getDistance();
    for(int i = 0; i<gridNum; i++) {
      close[i].set(compareR(d[i]));
    }
  }

  void getClosest() {
    getDistance();
    //println(sort().x);
    /*
    if(sort().y > 0) {
     fill(0, 0, 255);
     rect(grid.agent[(int)sort().y].fp.x, grid.agent[(int)sort().y].fp.y, 10, 10);
     close[(int)sort().y] = new Position(sort());
     //println("yay");
     }
     */
    /*
    if(keyPressed == true) {
     if(key == 'd') {
     print("the value of d[0].x is: ");
     println(d[0].x);
     }
     if(key == 'c') {
     print("the value of closest.y is: ");
     print((int)closest.y);
     print(" the id if closest object is: ");
     println(grid.agent[(int)closest.y].getID());
     }
     }
     */

  }

  int getId() {
    return id; 
  }
  void drawController() {
    noFill();
    stroke(255, 0, 0);
    //ellipse(p.x, p.y, 10, 10);
  }
  //sends the position of the target to Agents.
  void sendT() {
    //println(closest.y);
    for(int i = 0; i<gridNum; i++) {
      if((int)close[i].y > 0) {
        grid.agent[(int)close[i].y].tSet(p);
        grid2.agent[(int)close[i].y].tSet(p);
        //grid.agent[(int)close[i].y].maxVSet(2);
        //fill(255, 0, 0);
        //ellipse(grid.agent[(int)close[i].y].fp.x, grid.agent[(int)close[i].y].fp.y, 4, 4);
        //println("yay");
      }
    }
  }

  void keyPressed() {
    if(key == 'k') {
      // r++;

    } 

  }

}
