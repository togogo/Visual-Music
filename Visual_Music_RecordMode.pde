import processing.opengl.*;

int mX, mY;
char keys;
char tempKey;
char recordKey;
boolean keyisPressed;
int RECORD = 1;
int SAVEFRAMES = 2;
int mode = RECORD;
//int mode = SAVEFRAMES;    

// Variables for recording
PrintWriter outputX;//x-position output
PrintWriter outputY;//y-position output
PrintWriter outputKeys;//keyboard entry output 

// Variables for playback
String[] X;//record X
String[] Y;//record Y
String[] K;//record keys
int index = 0;

/*
TO-DO LIST
 -make small crystals
 -make one-way crystals
 -make continuous growing guys(three random positions)
 */

/*for fullscreen
 static public void main(String args[]) {
 PApplet.main(new String[] {"--present", "--display=1", "merged08"); 
 }
 
 */
/* color palette */
color white = color(255);
color black = color(0);
color whiteT = color(255, 255, 255, 20);
color blackT = color(0, 0, 0, 20);
color red = color(255, 0, 0);
color green = color(0, 255, 0);
color blue = color(0, 0, 255);
color gray = color(150);
color orange = color(248, 122, 0);
color light_orange = color(255, 175, 0);
color normal_blue = color(88, 125, 255);
color light_blue = color(92, 125, 255);
color dark_blue = color(52, 2, 255);
color pinky = color(255, 155, 209);
color dark_pinky = color(255, 57, 129);
color light_green = color(150, 255, 40);
/* color palette */

//switch for whether the crystalline structure should grow or not
boolean crys_grw;
boolean big_crys_grw;
int count_crys_grw;          //counts how many times the buttons:medium black
int count_big_crys_grw;      //counts how many times the buttons:big white
int count_sing_crys_grw;          //counts how many time the buttons:single black
int count_singW_crys_grw;        //counts how many thime the buttons:single white
int count_forever_crys_grw;    //counts how many time the buttons: forever black


//number of the modifier
int contNum = 4;
Modifier m[] = new Modifier[contNum];
Position mousePoint;//pos of mouse point
Position nullPoint;//pos of null point
Position randPoint;//pos of random point
//number of instantiating flowers
int numFlower = 10;//number of normal flowers
int numBigFlower = 10;//number of big flowers
int numForeverFlower = 1;
//actual instantiated flowers
Flower single;//works together with blur();
Flower flower[]= new Flower[numFlower];
Flower smallFlower[] = new Flower[numFlower];
Flower singleWhite;
Flower biggerFlower[] = new Flower[numBigFlower];
Flower foreverFlower1[] = new Flower[numForeverFlower];
Flower foreverFlower2[] = new Flower[numForeverFlower];
Flower foreverFlower3[] = new Flower[numForeverFlower];
//number of switches needed to manually activate the flowers
boolean flowerSwitch[] = new boolean[numFlower];
//number of switches needed to manually activate bigger flowers
boolean biggerFlowerSwitch[] = new boolean[numBigFlower];
boolean singleFlower;
boolean singleFlowerWhite;
boolean foreverFlower;


//This part is from VFIELD
int gridWidth = 30;
int gridHeight = 30;
int numGrid = gridWidth*gridHeight;
/*
Position np[] = new Position[numGrid];//end point
 Position fp[] = new Position[numGrid];//front point
 Position intP[] = new Position[numGrid];//interpolator Position
 Vector v[] = new Vector[numGrid];
 */
Position p;
/*
float a[] = new float[numGrid];
 float m[] = new float[numGrid];
 float intA[] = new float[numGrid];
 */

float maxV = -100;
int del = 10;
//int del = 1;
Grid grid;
Grid grid2;
Modifier test;
Modifier test02;
Modifier test03;
//VFIELD ends here




void setup() {

  size(800, 600, OPENGL);
  //size(800, 600, P3D);
  //background(black);
  background(white);
  rectMode(CENTER);
  count_crys_grw = 0; //initialize
  mX = mouseX;
  mY = mouseY;
  mousePoint = new Position(mX, mY);
  loadPixels();
  //initialize the position of flowers
  for(int i = 0; i<numFlower; i++) {
    flower[i] = new Flower(mousePoint, 0, 0, 0, 0, 0, 0, 0, mousePoint, whiteT, blackT, 'a');
    smallFlower[i] = new Flower(mousePoint, 0, 0, 0, 0, 0, 0, 0, mousePoint, whiteT, blackT, 'a');

  }
  //initialize the position of forever flowers
  for(int i = 0; i<numForeverFlower; i++) {
    foreverFlower1[i] = new Flower(mousePoint, 0, 0, 0, 0, 0, 0, 0, mousePoint, whiteT, blackT, 'a');
  }
  //initialize the position of big flowers
  for(int i = 0; i<numBigFlower; i++) {
    biggerFlower[i] = new Flower(mousePoint, 0, 0, 0, 0, 0, 0, 0, mousePoint, blackT, whiteT, 'a');
  }
  //initialize the single flowers
  single = new Flower(mousePoint, 0, 0, 0, 0, 0, 0, 0, mousePoint, whiteT, blackT, 'a');
  singleWhite = new Flower(mousePoint, 0, 0, 0, 0, 0, 0, 0, mousePoint, blackT, whiteT, 'a');


  /*VECTOR FIELD CODE!!*/
  p = new Position(mX, mY);
  grid = new Grid(gridWidth, gridHeight, 30, del);
  grid2 = new Grid(gridWidth, gridHeight, 30, del/2);
  for(int i = 0; i<contNum; i++) {
    m[i] = new Modifier((int)random(width), (int)random(height), (int)random(200, 400), 100, i); 
  }

  /*DOCUMENTATION MODE */
  framerate(30);
  if(mode == RECORD) {
    outputX = writer("positionX.txt");      // Create a new file in the sketch directory
    outputY = writer("positionY.txt");
    outputKeys = writer("keys.txt");
  } 
  if(mode == SAVEFRAMES) {
    X = loadStrings("positionX.txt");  // Load a new file in the sketch directory
    Y = loadStrings("positionY.txt");
    K = loadStrings("keys.txt");

  }

}

void draw() {
  noStroke();
  keyTracker();
  //println(key);
  if(mode == RECORD) {
    mX = mouseX;
    mY = mouseY;
    keys = tempKey;
    // Write the coordinate to a file
    outputX.println(mX);
    outputY.println(mY);
    outputKeys.println(keys);
  } 
  // Set variables when saving frames
  if(mode == SAVEFRAMES) {
    mX = int(X[index]);
    mY = int(Y[index]);
    recordKey = K[index].charAt(0);
    // Go to the next line for the next trip through draw()
    index = index + 1;
    if(index >= X.length) {
      exit(); 
    }
  }
  
  for(int i = 0; i<numForeverFlower; i++) {
    foreverFlower1[i].drawAll();
  }
  for(int i = 0; i<numFlower; i++) {
    flower[i].drawAll();
    smallFlower[i].drawAll();
  }
  for(int i = 0; i<numBigFlower; i++) {
    biggerFlower[i].drawAll(); 
  }
  single.drawAll();
  singleWhite.drawAll();
  if(mode == RECORD) {
    if(key == 't') {
      blur();
      //println("hey");
    } 
    if(key == 'r') {
      blur2(2); 
    }
  }
  if(mode == SAVEFRAMES) {
    if(recordKey == 't') {
      blur();
      //println("hey");
    } 
    if(recordKey == 'r') {
      blur2(2); 
    }
    
  }
  
  activateFlower();
  blossomFlower();
  foreverFlower();
  growFlower();
  for(int i = 0; i<contNum; i++) {
    m[i].drawController(); 
  }


  semikeyPressed();
  keyisPressed = false;
  if(mode == SAVEFRAMES) {
    saveFrame(); 
  }
}



//press keyboard to initiate crystalline growth process
void keyPressed() {
  keyisPressed = true;
  if(keyisPressed == true) {
  tempKey = key;
  }
  if(mode == RECORD) {
  //white-out
  if(key == ' ') {
    fill(255, 255, 255, 10);
    rect(width/2, height/2, width+1, height+1);
    //setup();
    //blur();
    //println("yay"); 
  }
  if(key == 'z') {
    fadeAway();
    //setup(); 
  }

  //normal-sized flower
  if(key == 'i') {
    /* this part is the switch part*/
    count_crys_grw++; 
    for(int i = 0; i<numFlower; i++) {
      if(count_crys_grw == i) {
        flowerSwitch[i] = true;
      }
      if(count_crys_grw == numFlower) {
        count_crys_grw = 0; 
      }
    }  
  }
  //bigger-sized flower
  if(key == 'o') {
    /* this part is the switch part*/
    count_big_crys_grw++; 
    for(int i = 0; i<numBigFlower; i++) {
      if(count_big_crys_grw == i) {
        biggerFlowerSwitch[i] = true;
      }
      if(count_big_crys_grw == numBigFlower) {
        count_big_crys_grw = 0; 
      }
    }  
  }
  if(key == 'p') {
    count_sing_crys_grw++;
    //blur();
    if(count_sing_crys_grw == 0) {
    }
    if(count_sing_crys_grw == 1) {
      singleFlower = true; 
    }
    if(count_sing_crys_grw == 2) {
      count_sing_crys_grw = 0; 
    }

  }
  if(key == '[') {
    count_singW_crys_grw++;
    //blur();
    if(count_singW_crys_grw == 0) {
    }
    if(count_singW_crys_grw == 1) {
      singleFlowerWhite = true; 
    }
    if(count_singW_crys_grw == 2) {
      count_singW_crys_grw = 0; 
    }

  }
    // Press 'Q' to quit when in RECORD mode
    if(mode == RECORD && (key == 'q' || key == 'Q')) {
      outputX.flush(); // Writes the remaining data to the file
      outputX.close(); // Finishes the file
      outputY.flush();
      outputY.close();
      outputKeys.flush();
      outputKeys.close();
      exit(); // Stops the program
    }
  }
}

void blossomFlower() {
  if(keyPressed == true) {
    if(key == 'w') {
      for(int i = 0; i < numFlower; i++) {
        randPoint = new Position(random(width), random(height));
        nullPoint = new Position(0, 0);
        /*
      (pos)position, (float)width, (int)iteration, (int)del, (float)decPer, (int)trans, (float)over, (int)numPetla, (pos)currentPos
      */
        //flower[i] = new Flower(nullPoint, random(3, 6), 5, (int)random(6, 12), 0.7, (int)random(100, 200), (int)random(0.1, 0.3), 8, randPoint, whiteT, blackT, 'a');
        smallFlower[i] = new Flower(nullPoint, random(3, 6), 5, (int)random(6, 12), 0.7, (int)random(100, 200), (int)random(0.1, 0.3), 8, randPoint, whiteT, blackT, 'a');
      }
    } 
  }
}

void foreverFlower() {
   if(keyPressed == true) {
      if(key == 'q') {
        for(int i = 0; i <numForeverFlower; i++) {
           //randPoint = new Position(random(width), random(height));
           mousePoint = new Position(mX, mY);
           nullPoint = new Position(0, 0);
           /*
      (pos)position, (float)width, (int)iteration, (int)del, (float)decPer, (int)trans, (float)over, (int)numPetla, (pos)currentPos
      */
          //foreverFlower1[i] = new Flower(nullPoint, random(20, 40), 20, (int)random(6, 12),0.9 , (int)random(100, 200), (int)random(0.1, 0.3), 15, mousePoint, whiteT, blackT);
          //foreverFlower1[i] = new Flower(nullPoint, random(10, 20), 5, (int)random(12, 20), 0.7, (int)random(100, 200), (int)random(0.1, 0.3), 10, mousePoint, whiteT, blackT);
          //foreverFlower1[i] = new Flower(nullPoint, random(10, 20), 5, (int)random(12, 20), 0.7, (int)random(100, 200), (int)random(0.1, 0.3), 10, mousePoint, whiteT, blackT);
        }
      }
   } 
}

void growFlower() {
   for(int i = 0; i<numFlower; i++) {
    //flower[i].radius++;
    //flower[i].petals[i].wid1++;
   } 
   
   //println(flower[1].petals[1].wid1);
}



void activateFlower() {
  //if 'i' is pressed
  for(int i = 0; i<numFlower; i++) {
    if(flowerSwitch[i] == true) {
      mousePoint = new Position(mX, mY);
      nullPoint = new Position(0, 0);
      /*
      (pos)position, (float)width, (int)iteration, (int)del, (float)decPer, (int)trans, (float)over, (int)numPetla, (pos)currentPos
      */
      flower[i] = new Flower(nullPoint, random(10, 20), 10, (int)random(30, 50), 0.7, (int)random(100, 200), (int)random(0.1, 0.3), 10, mousePoint, whiteT, blackT, 'a');
      flowerSwitch[i] = false;
    }
  } 
  //if 'o' is pressed
  for(int i = 0; i<numBigFlower; i++) {
    if(biggerFlowerSwitch[i] == true) {
      mousePoint = new Position(mX, mY);
      nullPoint = new Position(0, 0);
      /*
      (pos)position, (float)width, (int)iteration, (int)del, (float)decPer, (int)trans, (float)over, (int)numPetla, (pos)currentPos
      */
      flower[i] = new Flower(nullPoint, random(30, 50), 10, (int)random(25, 35), 0.8, (int)random(2, 3), (int)random(0.1, 0.3), 13, mousePoint, blackT, whiteT, 'a');
      biggerFlowerSwitch[i] = false;
    }
  }
  //if 'p' is pressed
  if(singleFlower == true) {
      mousePoint = new Position(mX, mY);
      nullPoint = new Position(0, 0);
      //println("yay");
      /*
      (pos)position, (float)width, (int)iteration, (int)del, (float)decPer, (int)trans, (float)over, (int)numPetla, (pos)currentPos
      */
      //blur();
      //blur();
      //blur();
      single = new Flower(nullPoint, random(3, 7), 4, (int)random(10, 15), 0.7, (int)random(50, 80), (int)random(0.1, 0.3), 13, mousePoint, whiteT, blackT, 'a');
      blur();
      //blur();
      //blur();
      singleFlower = false;
  }
  //if '[' is pressed
  if(singleFlowerWhite == true) {
      mousePoint = new Position(mX, mY);
      nullPoint = new Position(0, 0);
      //println("yay");
      /*
      (pos)position, (float)width, (int)iteration, (int)del, (float)decPer, (int)trans, (float)over, (int)numPetla, (pos)currentPos
      */
      //blur();
      //blur();
      //blur();
      singleWhite = new Flower(nullPoint, random(3, 7), 4, (int)random(10, 15), 0.7, (int)random(50, 80), (int)random(0.1, 0.3), 13, mousePoint, blackT, whiteT, 'a');
      blur();
      //blur();
      //blur();
      singleFlowerWhite = false;
  }
}

//take away all of the transparent values of all crystals
void fadeAway() {
  //initialize the position of flowers
  for(int i = 0; i<numFlower; i++) {
    flower[i] = new Flower(mousePoint, 0, 0, 0, 0, 0, 0, 0, mousePoint, whiteT, blackT, 'a');
    smallFlower[i] = new Flower(mousePoint, 0, 0, 0, 0, 0, 0, 0, mousePoint, whiteT, blackT, 'a');
    
  }
  //initialize the position of forever flowers
  for(int i = 0; i<numForeverFlower; i++) {
    foreverFlower1[i] = new Flower(mousePoint, 0, 0, 0, 0, 0, 0, 0, mousePoint, whiteT, blackT, 'a');
  }
  //initialize the position of big flowers
  for(int i = 0; i<numBigFlower; i++) {
    biggerFlower[i] = new Flower(mousePoint, 0, 0, 0, 0, 0, 0, 0, mousePoint, blackT, whiteT, 'a');
  }
  //initialize the single flowers
  single = new Flower(mousePoint, 0, 0, 0, 0, 0, 0, 0, mousePoint, whiteT, blackT, 'a');
  singleWhite = new Flower(mousePoint, 0, 0, 0, 0, 0, 0, 0, mousePoint, blackT, whiteT, 'a');
  
}

void keyTracker() {
  if(keyPressed == true) {
    //tempKey = key; 
  }
  if(keyisPressed == false) {
    tempKey = '?';
  } 

}

void semikeyPressed() {
 if(mode == SAVEFRAMES) {
   if(recordKey == ' ') {
    fill(255, 255, 255, 10);
    rect(width/2, height/2, width+1, height+1);
    //setup();
    //blur();
    //println("yay"); 
  }
  if(recordKey == 'z') {
    fadeAway();
    //setup(); 
  }

  //normal-sized flower
  if(recordKey == 'i') {
    /* this part is the switch part*/
    count_crys_grw++; 
    for(int i = 0; i<numFlower; i++) {
      if(count_crys_grw == i) {
        flowerSwitch[i] = true;
      }
      if(count_crys_grw == numFlower) {
        count_crys_grw = 0; 
      }
    }  
  }
  //bigger-sized flower
  if(recordKey == 'o') {
    /* this part is the switch part*/
    count_big_crys_grw++; 
    for(int i = 0; i<numBigFlower; i++) {
      if(count_big_crys_grw == i) {
        biggerFlowerSwitch[i] = true;
      }
      if(count_big_crys_grw == numBigFlower) {
        count_big_crys_grw = 0; 
      }
    }  
  }
  if(recordKey == 'p') {
    count_sing_crys_grw++;
    //blur();
    if(count_sing_crys_grw == 0) {
    }
    if(count_sing_crys_grw == 1) {
      singleFlower = true; 
    }
    if(count_sing_crys_grw == 2) {
      count_sing_crys_grw = 0; 
    }

  }
  if(recordKey == '[') {
    count_singW_crys_grw++;
    //blur();
    if(count_singW_crys_grw == 0) {
    }
    if(count_singW_crys_grw == 1) {
      singleFlowerWhite = true; 
    }
    if(count_singW_crys_grw == 2) {
      count_singW_crys_grw = 0; 
    }

  }
 }   
}