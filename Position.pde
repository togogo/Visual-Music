float conversionArc=180/PI;                              //180/PI used for many calculations
class Position                                           //position class that stores 2 values x and y
{
  float x,y;
  Position(){}
  
  Position(float tx,float ty)
  {
    x=(tx);
    y=(ty);
  }
  Position(Position p)
  {
    x=p.x;
    y=p.y;
  }
  Position displace(float angle,float magnitude)         //returns the position displaced by an angle and distance
  {
    Position newP=new Position(x,y);
    newP.x+=(cos(radians(angle))*magnitude);
    newP.y-=(sin(radians(angle))*magnitude);
    return newP;
  }
  void set(float tx,float ty)                            //sets a new coordinate
  {
    x=(tx);
    y=(ty);
  }
 
 void set(Position p) {
    x = p.x;
    y = p.y; 
 } 
}
