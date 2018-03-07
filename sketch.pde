
void blur2()
{
  loadPixels();
  int index,left,right,top,bottom;
  int sumr, sumg, sumb;
  
  for(int j=0;j<width;j++) 
  {
    for(int i=0;i<height;i++)
    {
      index=i*width+j;

      // Wraparound offsets
      if(j>0) left=-1; else left=width-1;
      if(j==(width-1)) right=-width+1; else right=1;
      if(i>0) top=-width; else top=(height-1)*width;
      if(i==(height-1)) bottom=-(height-1)*width; else bottom=width;
      //loadPixels();
      // Calculate the sum of n neighbors
      sumr=Red(pixels[left+index]); // left middle
      sumg=Green(pixels[left+index]);
      sumb=Blue(pixels[left+index]);
      //sum+=pixels[left+top+index] & 255; // left top
      //sum+=pixels[left+bottom+index] & 255; // left bottom
      sumr+=Red(pixels[right+index]); // right middle
      sumg+=Green(pixels[right+index]);
      sumb+=Blue(pixels[right+index]);
      //sum+=pixels[right+top+index] & 255; // right top
      //sum+=pixels[right+bottom+index] & 255; // right bottom
      sumr+=Red(pixels[index]); // middle middle
      updatePixels();
      sumg+=Green(pixels[index]);
      sumb+=Blue(pixels[index]);
      sumr+=Red(pixels[index+top]); // middle top
      sumg+=Green(pixels[index+top]);
      sumb+=Blue(pixels[index+top]);
      sumr+=Red(pixels[index+bottom]); // middle bottom
      sumg+=Green(pixels[index+bottom]);
      sumb+=Blue(pixels[index+bottom]);     
      sumr=(int)((float)sumr/4.99);
      sumg=(int)((float)sumg/4.99);
      sumb=(int)((float)sumb/4.99);
      pixels[index]=(sumr<<16)+(sumg<<8)+sumb;
     // updatePixels();
    }
  }
  
}
int Red(int c)
{
  return (c & 0xFF0000) >> 16;
}
int Green(int c)
{
  return (c & 0x00ff00) >> 8;
}
int Blue(int c)
{
  return c & 0x0000ff;
}

