//code for pressing multiple keys simultaneously adapted from: https://www.openprocessing.org/sketch/100827

public class Player{
  
  private final float speed = 1.0;
  private final float thrust = -45.0;
  private final float xOffset = 60;
  private final float yOffset = 72;
  
  private final BoundingType bounding = BoundingType.CLAMPING;
  
  boolean keys[] = new boolean [5];
  private Physics phy;
  private final PVector xMoveR = new PVector(speed,0);
  private final PVector xMoveL = new PVector(speed * -1,0);
  private final PVector yMoveUp = new PVector(0, thrust);
  //private final PVector yMoveDown = new PVector(0, 10);
  
  Animation idleL = new Animation("idleL",".png", 3, 120, 100, 100);
  Animation idleR = new Animation("idleR",".png", 3, 120, 100, 100);
  Animation walkL = new Animation("walkL",".png", 3, 150, 100, 100);
  Animation walkR = new Animation("walkR",".png", 3, 150, 100, 100);
  PImage jumpL = loadImage("jumpL.png"); 
  PImage jumpR = loadImage("jumpR.png");
  
  int dir = 0; // 0 = left facing, 1 = right facing
  int moveState = 0; // 0 = idle, 1 = walking, 2 = jumping
  int p_interval;  //this records the interval between bullets
  int shoot_interval;  //this is a static variable, it represents the fixed time interval between two bullets. 

  public Player(){
    phy = new Physics(new PVector(width/2,height/2));
    phy.setBoundingType(bounding);
    shoot_interval = 20;  //shoot a bullet every 20 loops.
    
    jumpL.resize(100,100);
    jumpR.resize(100,100);
  }
  
  public Player(PVector pos){
    phy = new Physics(pos);
    phy.setBoundingType(bounding);
    shoot_interval = 20;  //shoot a bullet every 20 loops.
    
    jumpL.resize(100,100);
    jumpR.resize(100,100);
  }
  
  void setKeys(int k, boolean b){
    keys[k] = b;
  }
  
  void move(){
    if(keys[0]){
      phy.applyForce(xMoveL);
      dir = 0;
    }
    if(keys[2]){
      phy.applyForce(xMoveR);
      dir = 1;
    }
    if(keys[1] && isGrounded()){
      phy.applyForce(yMoveUp);
      keys[1] = false;
    }
    if(keys[4] && phy.lowerBound < phy.floor){
      setLowerBound(phy.floor);
    }
  }
  
  public boolean isLaserOn(){
    if(keys[3]) return true;
    return false;
  }
  
  public boolean isGrounded(){
    return phy.getPos().y >= phy.lowerBound-5;
  }
  
  void setPos(float x, float y){
    phy.setPos(new PVector(x,y));
  }
  
  public PVector getPos(){
    return phy.getPos();
  }
  
  public float getLeftBound(){
    return phy.leftBound;
  }
  
  public float getRightBound(){
    return phy.rightBound;
  }
  
  public float getFloor(){
    return phy.floor;
  }
  
  public float getRightEnd(){
    return phy.rightEnd;
  }
  
  void setLowerBound(float bound){
    phy.lowerBound = bound;
  }
  
  void setUpperBound(float bound){
    phy.upperBound = bound;
  }
  
  void setLeftBound(float bound){
    phy.leftBound = bound;
  }
  
  void setRightBound(float bound){
    phy.rightBound = bound;
  }
  
  public void checkMoveState(){
    if(!isGrounded()) { moveState = 2;}
    else if(!keys[0] && !keys[2]) { moveState = 0;}
    else { moveState = 1; }
  }
  
  void display(Bullets bullets){
    phy.updatePos();
    checkMoveState();
    //laser
    if(keys[3]){
      if(p_interval % shoot_interval == 0){
        Bullet temp = new Bullet(phy.getPos().x, phy.getPos().y-50, dir);
        bullets.array.add(temp);
      }
      p_interval++;
      
    }
    fill(#FF0000);
    //noStroke(); ellipse(phy.getPos().x, phy.getPos().y,50,50);
  
    if(dir == 0) {
      if (moveState == 0){idleL.display(phy.getPos().x - xOffset, phy.getPos().y - yOffset);}
      else if (moveState == 1){walkL.display(phy.getPos().x - xOffset, phy.getPos().y - yOffset);}
      else {image(jumpL,phy.getPos().x - xOffset, phy.getPos().y - yOffset); }
    }
    else {
      if (moveState == 0){idleR.display(phy.getPos().x - xOffset + 10, phy.getPos().y - yOffset);}
      else if (moveState == 1){walkR.display(phy.getPos().x - xOffset + 10, phy.getPos().y - yOffset);}
      else {image(jumpR,phy.getPos().x - xOffset + 10, phy.getPos().y - yOffset); }
    }
  }
}  