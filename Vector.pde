//-----------------------------------------VECTOR/COORDINATE LIBRARY

class Vector                                            //vector class that stores a position, angle, and magnitude
{
  float a,m;
  Position p;
  
  Vector(){}
  Vector(float tx,float ty,float angle,float magnitude)
  {
    p=new Position(tx,ty);
    a=angle;
    m=magnitude;
  }
  Vector(Position pos,float angle,float magnitude)
  {
    p=new Position(pos);
    a=angle;
    m=magnitude;
  }
  Vector(Vector v)
  {
    p=new Position(v.p);
    a=v.a;
    m=v.m;
  }
  Position endPoint()                                    //returns the endpoint of the vector as type position
  {
    return displace(p,a,m);
  }
  Vector add(Vector v)                                   //returns a vector addition
  {
    Position newEnd = new Position(endPoint().displace(v.a, v.m));
    float newAngle = getHeading(p, newEnd);
    Vector newVector = new Vector(p, newAngle, dist(p.x, p.y, newEnd.x, newEnd.y));
    return newVector;
  }
  Vector add(float angle,float magnitude)                //returns a vector addition
  {
    Vector v = new Vector(p,angle,magnitude);
    Position newEnd=new Position(endPoint().displace(v.a,v.m));
    float newAngle=getHeading(p,newEnd);
    Vector newVector=new Vector(p,newAngle,dist(p.x,p.y,newEnd.x,newEnd.y));
    return newVector;    
  }
  Vector sub(Vector v)                                   //returns a vector subration (unimplemented)
  {
    return v;
  }
  void setStart(Position np)                             //sets a new starting point for the vector
  {
    p=np;
  }
  void setEnd(Position np)                               //sets a new ending point for the vector
  {
    a=getHeading(p,np);
    m=dist(p.x,p.y,np.x,np.y);
  }
  void setEnd(float px,float py)                         //sets a new ending point for the vector
  {
    Position np=new Position(px,py);
    a=getHeading(p,np);
    m=dist(p.x,p.y,np.x,np.y);
  }  
}

Position displace(Position p,float angle,float magnitude) //displaces a position by an angle and a magnitude, then returns it
{
  Position newP=new Position(p);
//  angle=atan2(my-y,mx-x);
//  angle=-1*angle*180/PI;
//  if(my>y)
//    angle=360-(angle*-1);
  newP.x+=(cos(radians(angle))*magnitude);
  newP.y-=(sin(radians(angle))*magnitude);
  return newP;
}
float getHeading(Position p1,Position p2)                //gets the absolute heading between one position and another relative to the first
{
  float angle=atan2(p2.y-p1.y,p2.x-p1.x);
  angle=-1*angle*conversionArc;
  if(p2.y>=p1.y)
    angle=360-(angle*-1);
  return angle;
}
float dist(Position p1, Position p2)
{
  return dist(p1.x,p1.y,p2.x,p2.y);
}
float normalizeHeading(float ang)                        //normalizes a heading between 0 and 180
{
  while(ang >= 360)ang -= 360;
  while(ang <= 0)ang += 360;
  return ang;
}
void drawVector(Vector v)                                //draws a vector in white
{
  colorMode(RGB,255,255,255);
  stroke(255);  
  noFill();  
  ellipseMode(CENTER);
  ellipse(v.p.x,v.p.y,5,5);
  Position e=v.endPoint();
  line(v.p.x,v.p.y,e.x,e.y);
}
void drawVector(Vector v,float s)                           //draws a vector with a longer line for representation in white
{
  colorMode(RGB,255,255,255);
  stroke(255);  
  noFill();  
  ellipseMode(CENTER);
  ellipse(v.p.x,v.p.y,5,5);
  Vector temp=new Vector(v);
  temp.m*=s;
  Position e=temp.endPoint();
  line(temp.p.x,temp.p.y,e.x,e.y);
}
void drawVector(Vector v,int r,int g,int b,float s)                           //draws a vector with a longer line for representation in white
{
  colorMode(RGB,255,255,255);
  stroke(r,g,b);  
  noFill();  
  ellipseMode(CENTER);
  ellipse(v.p.x,v.p.y,5,5);
  Vector temp=new Vector(v);
  temp.m*=s;
  Position e=temp.endPoint();
  line(temp.p.x,temp.p.y,e.x,e.y);
}
void drawVector(Vector v,int r,int g,int b)              //draws a vector in RGB
{
  colorMode(RGB,255,255,255);
  stroke(r,g,b);  
  noFill();  
  ellipseMode(CENTER);
  ellipse(v.p.x,v.p.y,5,5);
  Position e=v.endPoint();
  line(v.p.x,v.p.y,e.x,e.y);
}
