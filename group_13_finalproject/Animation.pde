// Class for animating a sequence of GIF frames adapted from https://processing.org/examples/animatedsprite.html
class Animation{
  int animationTimer = 0;
  int animationTimerValue;
  int currentFrame = 0;
  int numFrames;
  int alpha = 100;
  PImage[] frames;
  
  Animation(String imagePrefix, String imageSuffix, int _numframes, int t, int _width, int _height){
    numFrames = _numframes;
    animationTimerValue = t;
    
    frames = new PImage[numFrames];
    for(int i = 0; i < numFrames; i ++) {
      String filename = imagePrefix + " (" + (i+1) + ")" + imageSuffix;
      frames[i] = loadImage(filename);
      frames[i].resize(_width, _height);
    }
  }
  
  Animation(String imagePrefix, String imageSuffix, int _numframes, int t){
    numFrames = _numframes;
    animationTimerValue = t;
    
    frames = new PImage[numFrames];
    for(int i = 0; i < numFrames; i ++) {
      String filename = imagePrefix + " (" + (i+1) + ")" + imageSuffix;
      frames[i] = loadImage(filename);
    }
  }
  
  void display(float x, float y) {
    image(frames[currentFrame], x, y);
    if((millis()-animationTimer) >= animationTimerValue) {
      currentFrame = (currentFrame + 1) % numFrames;
      animationTimer = millis();
    }
  }
}

//code to draw objects along a curve adapted from https://processing.org/tutorials/text/
class Orbit {
  PImage img, img2, displayImage;
  float speed;
  float range;
  float yMove;
  float radius;
  float x,y;
  boolean up = true;
  float count = 0;
  CircleButton portal;
  
  Orbit(String fileName,String fileName2, float sp, float r){
    img = loadImage(fileName);
    img2 = loadImage(fileName2);
    img.resize(80,80);
    img2.resize(80,80);
    displayImage = img;
    speed = sp;
    range = r;
    yMove = -r;
    radius = 190;
    portal = new CircleButton(200, 200, 100);
  }
  
  public boolean mousedOver(){
    return portal.isOver(mouseX+xTranslationAMT, mouseY);
  }
  
  void display(float xPos, float yPos){
    x = xPos;
    y = yPos;
    portal = new CircleButton(x,y,350, "Click to Teleport to Start");
    portal.display();

  // keep image rotating and moving up/down
  pushMatrix();
    count+=speed;
    translate(xPos, yPos + yMove);
    rotate(count * TWO_PI/360);
  

  // draw 15 objects along a circle
  int totalObjects = 15;
  float arclength = 0;
  
  for (int i = 0; i < totalObjects; i++) {
    arclength += img.width/2;
    float theta = arclength / radius;     
    pushMatrix();
    // Polar to cartesian coordinate conversion
    translate(radius*cos(theta), radius*sin(theta));
    rotate(theta);
    if(mousedOver()){displayImage = img2;}
    else{displayImage = img;}
    image(displayImage,0,0);

    popMatrix();
    arclength += img.width/2;
  }  
  
    // move objects up and down in a range
    if(up)
      {yMove+=speed;}
    else
      {yMove -=speed;}
    if(yMove >= range)
      { up = false;}
    if(yMove <= -range)
      { up = true;}
  popMatrix();
  }
}  