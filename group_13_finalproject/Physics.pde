public class Physics{
  
  private PVector pos;
  private PVector move;
  private final float airResist = 0.2;
  private final PVector gravity = new PVector(0,2);
  
  private boolean useGravity = true;
  private BoundingType boundingType;
  
  private final float floor = height-70;
  private final float rightEnd = 4300;
  
  private float lowerBound = floor;
  private float upperBound = ceiling;
  private float leftBound = leftEnd;
  private float rightBound = rightEnd;
  
  private final float terminalVelocity = 60;
  private final float bounceFactor = 2;
  
  private ArrayList<PVector> activeForces = new ArrayList<PVector>();
  
  public Physics(PVector _pos){
    pos = _pos;
    move = new PVector(0,0);
  }
  
  public void applyForce(PVector force){
    activeForces.add(force);
  }
  
  private void applyResistance(){
    move = move.mult(1-airResist);
    
    if(abs(move.x) < 0.001){
      move.x = 0;
    }
    
    if(abs(move.y) < 0.001){
      move.y = 0;
    }
  }
  
  public void setBoundingType (BoundingType boundingType){
    this.boundingType = boundingType;
  }
  
  public void setGravity(boolean useGravity){
    this.useGravity = useGravity;
  }
  
  private void applyGravity(){
    if(pos.y < height) applyForce(gravity);
  }
  
  public void boundPosition(){
    switch(boundingType){
      case BOUNCE:
        if(pos.x < leftBound) move.x = abs(move.x * bounceFactor);
        if(pos.x > rightBound) move.x = -1 * abs(move.x * bounceFactor);
        if (pos.y < upperBound) move.y = abs(move.y * bounceFactor);
        if (pos.y > lowerBound) move.y = -1 * abs(move.y * bounceFactor);
        break;
        case CLAMPING:
        if (pos.x < leftBound) {pos.x = leftBound; move.x = 0;}
        if (pos.x > rightBound) {pos.x = rightBound-1; move.x = 0;}
        if (pos.y < upperBound) {pos.y = upperBound; move.y = 0;}
        if (pos. y > lowerBound) {pos.y = lowerBound; move.y = 0;}
        break;
        case WRAP:
        if (pos.x < leftBound) pos.x = rightBound;
        if (pos.x > rightBound) pos.x = leftBound;
        if (pos.y < upperBound) pos.y = lowerBound;
        if (pos. y > lowerBound) pos.y = upperBound;
        break;      
    }
  }
  
  private void getNewMovementVector(){
    for(PVector force : activeForces){
      move.add(force);
    }
    
    move.limit(terminalVelocity);
    
    activeForces.clear();
  }
  
  public void updatePos(){
    applyResistance();
    if(useGravity){
      applyGravity();
    }
    getNewMovementVector();
    pos = pos.add(move);
    boundPosition();
  }
  
  public PVector getPos(){
    return pos;
  }
  
  public void setPos(PVector newPos){
    pos = newPos;
  }
  
  public float getFloor(){
    return floor;
  }
  
  public float getRightEnd(){
    return rightEnd;
  }
}