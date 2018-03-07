/*
terminology:
"vehicle" : the little guy that appears on screen
"controler" : the invisible controler that jitters so that the vehicle seems to be moving randomly
*/

class Vehicle
{
  //vectors 
  Vector controller;//vector data of the controller 
  Position location;//coordinate of vehicle
  Vector velocity;//velocity vector of vehicle, orientation uses velocity angle
  Vector acceleration;//acceleration vector added to velocity per frame
  Vector steer;//behavior steering vector
  Vector desired;//desired vector to steer to
  //scalars
  float mass;//vehicle mass
  float maxAccel;//maximum force
  float maxSpeed;//maximum speed
  float minSpeed;//minimum speed
  float maxTurn;//maximum turning angle
  float vSize;//vehicle's visual size
  float rad = 100;//radius of the vehicle
  Position d[] = new Position[contNum];
  Position temp;//assign random initial value
  Position closest;//stores the id of the closest controller
  int placeHolder = 0;//store ID data
  Vehicle(){
    
    }
  
  Vehicle(Position p,float angle,float magnitude, float m, float maxA, float maxS, float maxT)
  {
    location=new Position(p);
    velocity=new Vector(location,angle,magnitude);
    acceleration=new Vector(velocity);
    steer=new Vector(velocity);
    controller = new Vector(random(0, width), random(0, height), 5, 5);  
    vSize=15;//not implemented for this program
    mass=m;
    maxAccel = maxA;             
    maxSpeed = maxS;
    minSpeed = maxSpeed/2;           
    maxTurn= maxT;   
    temp = new Position(100, 100);
    closest = new Position(100, 1);
    for(int i = 0; i<d.length; i++) {
      d[i] = new Position(0, 0);//initialize all the values
    }
    
  }
  void update()
  {
    steer=seek();                                       //using seek behavior against target
    acceleration=new Vector(steer);                     //apply the steering force
    acceleration.p=location;                           
    acceleration.m=steer.m/mass;                        //acceleration=force / mass
    if(velocity.m>0)                                    //prevent 0 velocity rotation
      velocity=velocity.add(acceleration);              //time-step force to the velocity vector
    velocity.m=constrain(velocity.m,minSpeed,maxSpeed);        //constrain the velocity vector to maximum vehicle speed
    location=location.displace(velocity.a,velocity.m);  //set new position based on velocity vector
    velocity.p=location;
  }
  /*
    seek: Attempts to steer the velocity vector parallel to the desired vector
          which is a straight line from the vehicle to the target.
  */
  Vector seek()
  {
    //desired vector would be a straight line from the vehicle to the target
    desired=new Vector(location,getHeading(location,controller.p),dist(location,controller.p));
    Vector desiredTruncate=new Vector(desired);
    //desiredTruncate.m=dist(desired.p,desired.endPoint())/(10/mass);
    desiredTruncate.m = dist(desired.p, desired.endPoint())/10;
    //desiredTruncate.m=maxSpeed*.4;    //alternative truncation
    //drawVector(desiredTruncate);
    //steer the currenty velocity towards a particular point on the desired vector
    Vector steer=new Vector(velocity.endPoint(),getHeading(velocity.endPoint(),desiredTruncate.endPoint()),dist(velocity.endPoint(),desiredTruncate.endPoint()));
    //constrain the steering to maximum vehicle force
    steer.m=constrain(desired.m,0,maxAccel);  
    return steer;
  }
  void draw() {
    //drawVehicle();
    //drawController();
    //drawAllVectors();
    updateController();
    drawController();
    //rapController();
  }
  void drawAllVectors() {
    drawVector(velocity,255,0,0,10);
    drawVector(steer,0,255,255,10);        
    drawVector(desired,255,255,0);    
  }
  void drawVehicle()  {
    stroke(255);
    //line(location.displace(velocity.a,vSize).x,location.displace(velocity.a,vSize).y,location.displace(velocity.a,-1*vSize).x,location.displace(velocity.a,-1*vSize).y);
    //ellipseMode(CENTER);
    //noStroke();
    //fill(light_orange);
    rect(location.x,location.y, 2, 2); 
    //println(location.x);
    //fill(255, 0, acceleration.m);
    //ellipse(location.x, location.y, rad, rad); 
  }
  
  void drawController() {
    noFill();
    //stroke(255, 255, 0);
    //ellipse(controller.p.x, controller.p.y, rad, rad);
    //println(d.length);
    //fill(0, 0, 255);
    //ellipse(m[placeHolder].x, m[placeHolder].y, rad, rad);
  }
  
  Position sort() {
    temp = compare(d[1], d[2]);
    for(int i =  3; i<contNum; i++) {
      temp = compare(temp, d[i]);
    }
    return temp;
  }
  
  void updateController() {
    /*IMPLEMENT!! this part is from Casey_imitation program*/
      getDistance();
      closest = sort();
      placeHolder = (int)closest.y;
      //controller.p.x = m[placeHolder].p.x;
      //controller.p.y = m[placeHolder].p.y;
      //controller.p = m[placeHolder].p;
      //controller.p.x++;
   
      //println(randomAng);
      //controller = controller.add(randomAng, 0.5);
      //controller.p = controller.p.displace(random(0, 360), controller.m*4);
      //drawVector(controller,255,0,0);
      
      /*if random flow mode is true ..... */
      
      //controller.p.x += random(-5, 5);
      //controller.p.y += random(-5, 5);
  }
  
  void getDistance() {
    for(int i = 1; i<contNum; i++) {
      d[i].x = dist(this.location, m[i].p);
      d[i].y = m[i].getId();
    }
  }
  
  Position compare(Position m, Position n) {
    if(m.x > n.x) {
      return n;
    }
    if(m.x < n.x) {
      return m;
    }
    else
      return null;
  }
  
  void rapController() {
    if(controller.p.x > width) {
      controller.p.x = 0;
    }
    if(controller.p.x < 0) {
      controller.p.x = width;
    }
    if(controller.p.y > height) {
      controller.p.y = 0;
    }
    if(controller.p.y < 0) {
      controller.p.y = height;
    }
  }
}
