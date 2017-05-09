public class Bullet {
  float x,y; // the position of the bullet
  int direction; //0 means left , 1 means right
  float b_width, b_height;  //these are the height and the width of the bullet
  float speed;  //the speed of bullet flying
  
  public Bullet(){
    b_width = 20;
    b_height = 10;
    speed = 15;  //15 pixels per loop
    
  }
  
  public Bullet(float _x, float _y, int direc){
    b_width = 20;
    b_height = 10;
    x = _x;
    y = _y;
    direction = direc;
    speed = 15; //15 pixels per loop
  }
  
  public void display(){
    if(direction == 1){
      x += speed;
    }
    else if(direction == 0){
      x -= speed;
    }
    
    rect(x,y,b_width,b_height);
  }
  
  
}

public class Bullets {
  ArrayList<Bullet> array = new ArrayList<Bullet>();
  
  public Bullets(){}
  
  public void display(){
    for(int i = 0; i < array.size(); i++){
      array.get(i).display();
    }
  }
  
}