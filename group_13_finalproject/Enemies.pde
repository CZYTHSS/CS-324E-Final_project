public class Enemy {
  
  float x,y;  //stands for the x, y coordinate of this enemy
  int size;  //the size of the object.  now we'll just let the enemy be an square
  int status;  //indicate the status of enemy. 1 means alive and moving, 0 means died and waiting in the stack
  Animation creature; 
  Animation death;
  float range; // the range that the enemy moves left and right
  float dist_moved; //distance already moved
  int direction ;  //0 means moving right, 1 means moving left
  int revive_time;  //after enemy died, it takes 100 time units to revive
  int cd_time;
  
  public Enemy (){
    x = -200;  //set x location negative to prevent it appear before setting its location in swarm class
    size = int(random(90,120));
    y = height - size - 70;
    status = 0;
    creature = new Animation("enemy",".gif", 24, 38, size, size);
    range = random(150,500);
    dist_moved = 0;
    direction = 0;
    cd_time = 500;
    revive_time = cd_time;
  }
  
  void move(){
    if(direction == 0){
      x += 1;
      dist_moved += 1;
      if(dist_moved >= range){
        direction = 1;
      }
    }
    else if(direction == 1){
      x -= 1;
      dist_moved -= 1;
      if(dist_moved <= 0){
        direction = 0;
      }
    }
    //y += 1;
    //if(y > height){
    //  status = 0;
    //  y = -size;
    //  lifeCount -= 1;
    //}
  }
  
  boolean isPointInside(float x2, float y2){
    if (x2 > x && x2 < (x+size) && y2 > y && y2 < (y+size)) {return true;}
    else {return false;}
  }
    
  void init(){
    status = 1;
  }
  
  void display(){
    if(status == 1){
      move();
      //fill(233);
      //rect(x,y,size,size);
      creature.display(x,y);
    }
    if(status == 0){
      revive_time -= 1;
      if(revive_time <= 0){
        status = 1;
        revive_time = cd_time;
      }
    }
  }
  
  float x() { return x; }
  float y() { return y; }
  int getSize() { return size;}
  public int getStatus(){ return status; }
}
  

public class Swarm{
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  ArrayList<Animation> deaths = new ArrayList<Animation>();
  ArrayList<PVector> deathPositions = new ArrayList<PVector>();
  int count = 0;  //a way to count time, add 1 in each loop.
  int interval = 100;  //how many loops to emit one enemy
  float transparency = 255;
  boolean game_start = false;
  
  public Swarm(){
    //initialize 10 enemies
    for(int i = 0; i < 15; i++){
      Enemy temp = new Enemy();
      temp.x = 500 * i;
      enemies.add(temp);
    }
  }
  
  public ArrayList<Enemy> getEnemyArray(){ return enemies;}
  
  public void die(){
    //death animation
    for(int i = 0; i< deaths.size(); i++){//Animation death : deaths){
      if(transparency > 0) transparency -= 5;
      tint(255, transparency);
      deaths.get(i).display(deathPositions.get(i).x, deathPositions.get(i).y);
      if(transparency <= 0) {deaths.remove(i); deathPositions.remove(i); transparency = 255;}
      tint(255);
    }
  }
  
  public void display(Bullets bullets){
    count += 1;
    for(int i = enemies.size()-1; i >= 0; i--){
      //if(count % interval == 0){
      //  enemies.get((count/interval)%enemies.size()).init();
      //}
      if(!game_start) {
        enemies.get(i).init();
      }
      enemies.get(i).display(); 
      if(enemies.get(i).status == 1){
        for(int j = 0; j < bullets.array.size(); j++){
          Enemy e = enemies.get(i);
          Bullet b = bullets.array.get(j);
          //collision judgement
          if(b.x + b.b_width > e.x && b.x < e.x + e.size && b.y + b.b_height > e.y && b.y < e.y + e.size){
            deaths.add(new Animation("enemyDeath",".gif", 28, 38, enemies.get(i).getSize(),enemies.get(i).getSize()));
            deathPositions.add(new PVector(enemies.get(i).x(), enemies.get(i).y()));
            enemies.get(i).status = 0;
            score++;
            bullets.array.remove(j);
          }
        }
      }
      //if(player.isLaserOn() && enemies.get(i).isPointInside(mouseX, mouseY)) {
      //  deaths.add(new Animation("enemyDeath", 28, 38, enemies.get(i).getSize(),enemies.get(i).getSize()));
      //  deathPositions.add(new PVector(enemies.get(i).x(), enemies.get(i).y()));
      //  enemies.get(i).status = 0;
      //  score++;
      //} 
    }
    game_start = true;
    die();
  }
}