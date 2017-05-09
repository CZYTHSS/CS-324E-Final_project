public static boolean onPlatform = false;
public static boolean belowBoundary = false;
public static boolean leftOfWall = false;
public static boolean rightOfWall = false;

public class Boundary {

  private float startX;
  private float endX;
  private float y;
  private Player character;
  private final float floor;
  private final float rightEnd;
  private PVector pos;

  private float yOffset = 25;

  Boundary(float startX, float endX, float y, Player player) {
    this.startX = startX;
    this.endX = endX;
    this.y = y;
    floor = player.getFloor();
    rightEnd = player.getRightEnd();
    character = player;
    pos = character.getPos();
  }

  public void display() {
    stroke(255);
    strokeWeight(3);
    line(startX, y, endX, y);
  }

  public boolean withinRange() {
    return(pos.x > startX && pos.x < endX);
  }

  public void bound() {
    //display();

    if (withinRange()) {
      if (pos.y <= y-yOffset) { 
        character.setLowerBound(y-yOffset); 
        onPlatform = true;
      }
    } else if (!onPlatform) {
      character.setLowerBound(floor);
    }
  }
}

public class Wall{

  private float startY;
  private float endY;
  private float x;
  private Player character;
  private final float floor;
  private final float rightEnd;
  private PVector pos;

  private float xOffset = 25;

  Wall(float startY, float endY, float x, Player player) {
    this.startY = startY;
    this.endY = endY;
    this.x = x;
    floor = player.getFloor();
    rightEnd = player.getRightEnd();
    character = player;
    pos = character.getPos();
  }

  public void display() {
    stroke(255);
    strokeWeight(3);
    line(x, startY, x, endY);
  }

  public boolean withinRange() {
    return(pos.y > startY && pos.y < endY);
  }

  public void bound() {
    //display();
    
    // check left and right collission
    if (withinRange()) {
      if (pos.x <= x-xOffset) { 
        character.setRightBound(x-xOffset);
        leftOfWall = true;
      }
      else if (pos.x >= x+xOffset) {
        character.setLeftBound(x+xOffset);
        rightOfWall = true;
      }
    } 
    else {
      if (!leftOfWall) {
        character.setRightBound(rightEnd);
      }
      if (!rightOfWall) {
        character.setLeftBound(0);
      }
    }
  }
}

public class RectBoundary {
  private float x;
  private float y;
  private float w;
  private float h;
  private Player character;
  private final float floor;
  private final float ceiling;
  private final float rightEnd;
  private PVector pos;

  private float yOffset = 30;
  private float xOffset = 30;

  RectBoundary(float startX, float startY, float w, float h, Player player) {
    x = startX;
    y = startY;
    this.w = w;
    this.h = h;
    character = player;
    floor = player.getFloor();
    rightEnd = player.getRightEnd();
    ceiling = 0;
    pos = character.getPos();
  }

  public void display() {
    stroke(255);
    strokeWeight(3);
    noFill();
    rect(x, y, w, h);
  }

  public boolean withinXRange() {
    return(pos.x > x && pos.x < x+w);
  }

  public boolean withinYRange() {
    return(pos.y > y && pos.y < y+h);
  }

  public void bound() {
    //display();

    // check top and bottom collission
    if (withinXRange()) {
      if (pos.y <= y-yOffset) { 
        character.setLowerBound(y-yOffset); 
        onPlatform = true;
      }
      else if (pos.y >= y+h+30) {
        character.setUpperBound(y+h+yOffset);
        belowBoundary = true;
      }
    } 
    else {
      if (!onPlatform) {
        character.setLowerBound(floor);
      }
      if (!belowBoundary) {
        character.setUpperBound(ceiling);
      }
    }

    // check left and right collission
    if (withinYRange()) {
      if (pos.x <= x-xOffset) { 
        character.setRightBound(x-xOffset);
        leftOfWall = true;
      }
      else if (pos.x >= x+w+xOffset) {
        character.setLeftBound(x+w+xOffset);
        rightOfWall = true;
      }
    } 
    else {
      if (!leftOfWall) {
        character.setRightBound(rightEnd);
      }
      if (!rightOfWall) {
        character.setLeftBound(0);
      }
    }
  }
  
}

  public class Level {
    // wall platforms 1
    Boundary platform0;
    Boundary platform1;
    Boundary platform2;
    Boundary platform3;
    Boundary platform4;
    Boundary platform5;
    // wall platforms 2
    Boundary platform6;
    Boundary platform7;
    Boundary platform8;
    Boundary platform9;
    Boundary platform10;
    Boundary platform11;
    // chandelier and box platforms
    Boundary platform12;
    Boundary platform13;
    Boundary platform14;
    
    /*
    RectBoundary wall0;
    RectBoundary wall1;
    RectBoundary wall2;
    */
    
    Wall wall0;
    Wall wall1;
    ArrayList<Boundary> platforms;
    ArrayList<Wall> walls;
    Player player;

    Level(Player player) {
      this.player = player;
      platform0 = new Boundary(2058, 2175, height-165, player);
      platform1 = new Boundary(2058, 2175, height-260, player);
      platform2 = new Boundary(2058, 2175, height-345, player);
      platform3 = new Boundary(2058, 2175, height-440, player);
      platform4 = new Boundary(2058, 2175, height-535, player);
      platform5 = new Boundary(2058, 2175, height-620, player);
      
      platform6 = new Boundary(2485, 2602, height-165, player);
      platform7 = new Boundary(2485, 2602, height-260, player);
      platform8 = new Boundary(2485, 2602, height-345, player);
      platform9 = new Boundary(2485, 2602, height-440, player);
      platform10 = new Boundary(2485, 2602, height-535, player);
      platform11 = new Boundary(2485, 2602, height-620, player);
      
      platform12 = new Boundary(2210, 2460, height-590, player);
      platform13 = new Boundary(2835, 2920, height-150, player);
      platform14 = new Boundary(2925, 3100, height-223, player);
      
      platforms = new ArrayList<Boundary>();
      platforms.add(platform0);
      platforms.add(platform1);
      platforms.add(platform2);
      platforms.add(platform3);
      platforms.add(platform4);
      platforms.add(platform5);
      platforms.add(platform6);
      platforms.add(platform7);
      platforms.add(platform8);
      platforms.add(platform9);
      platforms.add(platform10);
      platforms.add(platform11);
      platforms.add(platform12);
      platforms.add(platform13);
      platforms.add(platform14);
      
      //wall0 = new RectBoundary(1552, -50, 12, 560, player);//new RectBoundary(2200, 500, 100, 100, player);
      //wall1 = new RectBoundary(3082, -50, 12, 360, player);//new RectBoundary(2400, 500, 100, 100, player);
      //wall2 = new RectBoundary(3088, 440, 12, 500, player);
      //walls.add(wall0);
      //walls.add(wall1);
      //walls.add(wall2);
      wall0 = new Wall(440, height, 3088, player);
      wall1 = new Wall(440, height, 3092, player);
      walls = new ArrayList<Wall>();
      walls.add(wall0);
      walls.add(wall1);

    }

    public void build() {

      for (Boundary platform : platforms) {
        platform.bound();
      }
      
      for (Boundary platform : platforms) {
        if (platform.withinRange()) {
          onPlatform = true;
          break;
        } else onPlatform = false;
      }
      
      for (Wall wall : walls) { 
        wall.bound();
      }
      
      for (Wall wall : walls) {
        if (wall.withinRange()) {
          leftOfWall = true;
          rightOfWall = true;
          break;
        } 
        else {
          leftOfWall = false;
          rightOfWall = false;
        }
      }
      
      /*
      for (RectBoundary wall : walls) { 
        wall.bound();
      }
      
      // check all horizontal boundaries
      for (RectBoundary wall : walls) {
        if (wall.withinXRange()) {
          onPlatform = true;
          belowBoundary = true;
          break;
        } 
        else {
          onPlatform = false;
          belowBoundary = false;
        }
      }
      
      // check all vertical boundaries
      for (RectBoundary wall : walls) {
        if (wall.withinYRange()) {
          leftOfWall = true;
          rightOfWall = true;
          break;
        } 
        else {
          leftOfWall = false;
          rightOfWall = false;
        }
      }
      */
    }
  }

  public class View {
    PVector pos;
    float xTranslation;

    public View() {
      pos = new PVector(0, 0);
      xTranslation = 0;
    }
    
    public float getXTranslation(){
      return -xTranslation;
    }

    public void track(Player player) {
      if (player.getPos().x <= 0 + width/2) { 
        translate(0, -pos.y);
        xTranslation = 0;
      } 
      else if (player.getPos().x >= player.getRightEnd() - width/2) {
        translate(-player.getRightEnd()+width, -pos.y);
        xTranslation = -player.getRightEnd()+width;
      } 
      else {
        pos.x = player.getPos().x;
        translate(-pos.x+width/2, -pos.y);
        xTranslation = -pos.x+width/2;
      }
    }
  }