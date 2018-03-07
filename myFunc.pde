

//interpolates value
float interpolator(float frst, float scnd, float delayer) {
  float returnMe;//value that will be returned
  returnMe = (frst - scnd)/delayer;
  return returnMe;
}

//draws line based on position
void line(Position p1, Position p2) {
  line(p1.x, p1.y, p2.x, p2.y);
}


float normalizer(float angle) {
  while(angle > TWO_PI) {
  angle -= TWO_PI;
  }
  while(angle < 0) {
  angle += TWO_PI;
  }
  return angle;
}
//normalizes degree angle from 0 to 360
float normalizerDEG(float ang) {
	while (ang > 360) {
		ang -= 360;
	}
	while (ang < 0) {
		ang += 360;
	}
	return ang;
}

void vertex(Position p){
vertex(p.x, p.y);
}

void curveVertex(Position p) {
 curveVertex(p.x, p.y); 
}
