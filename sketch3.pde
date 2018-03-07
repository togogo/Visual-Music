/*
void blur2(int tt) {
  loadPixels();
  for(int ttt = 0; ttt <= tt; ttt++)
  {
    //println("this is the beginning");
    int R,G,B,left,right,top,bottom;
    color c,cl,cr,ct,cb;
    int w1=width-1;
    int h1=height-1;
    int index=1;
    for(int y=0;y<height; y++) 
    {
      //println("I am executing no.");
      //println(y);
      //top=(y>0) ? -width : h1*width;
      if(y>0) {
         top = -width; 
      }
      else {
         top = h1*width;
         //println("am I being executed? else y = 0"); 
      }
      
      //bottom=(y==h1) ? -h1*width : width;
      if(y==h1) {
        bottom = -h1*width; 
         //println("am I being executed? y ==h1");
      }
      else {
        bottom = width; 
         //println("am I being executed?else y ==h1");
         //println(h1);
      }
      
      for(int x=0; x<width; x++) 
      {
        // Wraparound offsets
        left=(x>0) ? -1 : w1;
        right=(x<w1) ? 1 : -w1;
        //println("how about here?");
        //println(pixels[0]);
        c=pixels[index];
        //println("how about here 2?");
        cl=pixels[left+index];
        cr=pixels[right+index];
        ct=pixels[top+index];
        cb=pixels[bottom+index];
        if(c+cl+cr+ct+cb!=0)
        {
          // Calculate the sum of all neighbors
          R=((cl>>16 & 255) + (cr>>16 & 255) + (c>>16 & 255) + (ct>>16 & 255) + (cb>>16 & 255)) / 5;
          G=((cl>>8 & 255) + (cr>>8 & 255) + (c>>8 & 255) + (ct>>8 & 255) + (cb>>8 & 255)) / 5;
          B=((cl & 255) + (cr & 255) + (c & 255) + (ct & 255) + (cb & 255)) / 5;
          pixels[index++]=(R<<16)+(G<<8)+B;
        }
        else
        {
          index++;
        }
        //println(index);
      }
    }
  }
  //updatePixels();
}
*/
