void blur() {
  int index,sum,left,right,top,bottom;
  loadPixels();
  for(int j=0;j<width;j++) {
    for(int i=0;i<height;i++) {
      index=i*width+j;
      //loadPixels();
      // Wraparound offsets
      if(j>0) left=-1; else left=width-1;
      if(j==(width-1)) right=-width+1; else right=1;
      if(i>0) top=-width; else top=(height-1)*width;
      if(i==(height-1)) bottom=-(height-1)*width; else bottom=width;

      // Calculate the sum of n neighbors
      sum=pixels[left+index] & 255; // left middle
      //sum+=pixels[left+top+index] & 255; // left top
      //sum+=pixels[left+bottom+index] & 255; // left bottom
      sum+=pixels[right+index] & 255; // right middle
      //sum+=pixels[right+top+index] & 255; // right top
      //sum+=pixels[right+bottom+index] & 255; // right bottom
      sum+=(pixels[index] & 255); // middle middle
      sum+=pixels[index+top] & 255; // middle top
      sum+=pixels[index+bottom] & 255; // middle bottom
      sum=(sum/5);
      pixels[index]=(sum<<16)+(sum<<8)+sum;
    }
  }
  //updatePixels(0, 0, width, height);
}
