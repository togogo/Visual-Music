class Transition {
 /*
 -this guy will keep track of all the positions of given crytal into a single array of positions.
 -this guy can allocate the recorded arrays into a grid.(refer to the Grid)
 */ 
 Position singleArray[];
 int num = 100;//just for now
 
 Transition() {
   singleArray = new Position[num];
   
   for(int i = 0; i<num; i++) {
      singleArray[i] = new Position(0, 0); 
   }
   }
 
//get all position data into singleArray (or get as much pos as possible, for now)
void getAllPos() {
  for(int i = 0; i<num; i++) {
     //singleArray[i] = p1. 
  }
  
}

//transition all flower-pos to the grid-np-pos
void translateAllPos() {
  
}
 
}
