
void blur2(int tt) 
{
  loadPixels();
  for(int i=0;i<(width*height)/20;i++)
  {
    int x=(int)random(width-2)+1;
    int y=(int)random(height-2)+1;
    int dx=0,dy=0;
    if(random(2)<1)
      dx=1;
    else
      dy=-1;
    if(random(2)<1)
      dy=1;
    else
      dy=-1;
      
    int r=pixels[x+y*width]&255;
    int g=(pixels[x+y*width]>>8)&255;
    int b=(pixels[x+y*width]>>16)&255;
    r+=pixels[x+dx+(y+dy)*width]&255;
    g+=(pixels[x+dx+(y+dy)*width]>>8)&255;
    b+=(pixels[x+dx+(y+dy)*width]>>16)&255;
    r/=2;
    g/=2;
    b/=2;
    pixels[x+y*width]=r+(g<<8)+(b<<16);
  }
  //updatePixels();
}

