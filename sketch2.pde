/*
void blur(int x, int y,int w,int h){

  int sum,cr,cg,cb,k;
  int pixel,read,i,ri,xl,yl,yi,ym,riw;
  int iw=img.width;

  int wh=width*img.height;

  int r[]=new int[wh];
  int g[]=new int[wh];
  int b[]=new int[wh];

  for (i=0;i<wh;i++){
    ri=pixels[i];
    r[i]=(ri&0xff0000)>>16;
    g[i]=(ri&0x00ff00)>>8;
    b[i]=(ri&0x0000ff);
  }

  int r2[]=new int[wh];
  int g2[]=new int[wh];
  int b2[]=new int[wh];

  x=max(0,x);
  y=max(0,y);
  w=x+w-max(0,(x+w)-width);
  h=y+h-max(0,(y+h)-img.height);
  yi=y*width;

  for (yl=y;yl<h;yl++){
    for (xl=x;xl<w;xl++){
      cb=cg=cr=sum=0;
      ri=xl-radius;
      for (i=0;i<kernelSize;i++){
        read=ri+i;
        if (read>=x && read<w){
          read+=yi;
          cr+=mult[i][r[read]];
          cg+=mult[i][g[read]];
          cb+=mult[i][b[read]];
          sum+=kernel[i];
        }
      }
      ri=yi+xl;
      r2[ri]=cr/sum;
      g2[ri]=cg/sum;
      b2[ri]=cb/sum;
    }
    yi+=width;
  }
  yi=y*width;

  for (yl=y;yl<h;yl++){
    ym=yl-radius;
    riw=ym*width;
    for (xl=x;xl<w;xl++){
      cb=cg=cr=sum=0;
      ri=ym;
      read=xl+riw;
      for (i=0;i<kernelSize;i++){
        if (ri<h && ri>=y){
          cr+=mult[i][r2[read]];
          cg+=mult[i][g2[read]];
          cb+=mult[i][b2[read]];
          sum+=kernel[i];
        }
        ri++;
        read+=width;
      }
      pixels[xl+yi]=0xff000000 | (cr/sum)<<16 | (cg/sum)<<8 | (cb/sum);
    }
    yi+=width;
  }
}
*/
