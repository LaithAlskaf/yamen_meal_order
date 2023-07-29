//xlarg = 960 x 720
//larg = 640 x 480
//normal = 470 x 320
//small = 426 x 320


class CustomScreenLayout {
  CustomScreenLayout(hieght,width){
    if (426<=hieght && hieght<470 && width==320 ){
      smallScreen (hieght,width);
    }
    else if(470<=hieght && hieght<640 && width>320 && width<=480 ){
      normalScreen (hieght,width);
    }
     else if(640<=hieght && hieght<960 && width>480 && width<=720 ){
      largeScreen (hieght,width);
    }
     else if(960<=hieght && width>720){
      xlargeScreen (hieght,width);
    }

  }
  smallScreen (hieght,width){
    
  }normalScreen (hieght,width){

  }largeScreen (hieght,width){

  }xlargeScreen (hieght,width){

  }

}