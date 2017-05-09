public class Button{
  float x, y, w, h;
  String tag;
  
  public Button(float x, float y, float w, float h, String tag){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.tag = tag;
  }
  
  boolean mouseOver(){
    if(x < mouseX && (x+w) > mouseX && y < mouseY && (y+h) > mouseY)
      return true;
    return false;
  }
  
  void display(){
    fill(50,50,50,25);
    stroke(255);
    rect(x,y,w,h);
    fill(255);
    noStroke();
    textAlign(CENTER);
    textSize(30);
    if(mouseOver()) fill(#8BD9FF);
    text(tag, x+w/2, y+h/2+10);  
  }
}

public class CircleButton{
  float x, y, size;
  String label = "";
  
  public CircleButton(float x, float y, float size){
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  public CircleButton(float x, float y, float size, String label){
    this.x = x;
    this.y = y;
    this.size = size;
    this.label = label;
  } 
  
  public boolean mouseOver(){
    return sqrt(sq(mouseX- x) + sq(mouseY- y)) <= size/2;
  }
  
  public boolean isOver(float xPos, float yPos){
    return sqrt(sq(xPos - x) + sq(yPos- y)) <= size/2;
  }
  
  void display(){
    noFill();
    strokeWeight(2);
    stroke(0);
    ellipse(x,y,size,size); 
    
    textSize(12);
    textAlign(CENTER);
    fill(255);
    text(label, x,y);
  }
}

public class GUI{
  
  Button contButton;
  Button quitButton;
  Button startButton;
  Button replayButton;

  public GUI(){
    contButton = new Button(width/2-85, height/2+15, 170, 45, "Continue");
    quitButton = new Button(width/2-85, height/2+68, 170, 45, "Quit");
    startButton = new Button(width/2-350, height/2+60, 170, 45, "Start");
    replayButton = new Button(width/2-85, height/2+121, 170, 45, "Restart");
  }
  
  void displayStartScreen(Ranking ranking){  
      background(50);
      fill(0);
      rect(width/2-400, 220, 800, 300);
      fill(255);
      noStroke();
      textAlign(LEFT);
      textSize(20);
      text("Use arrow keys or WASD to move.", width/2-350, height/2 - 110);
      text("Press the SPACEBAR to shoot in the direction you are facing.", width/2-350, height/2 - 80);
      text("Shooting enemies will destroy them.", width/2-350, height/2 - 50);
      text("You lose lives if you run into enemies.", width/2-350, height/2 - 20);
      text("Kill as many as you can for a high score! If you run out of lives, you lose.", width/2-350, height/2 + 10);
      text("Press 'P' to pause. Press M to toggle the music.", width/2-350, height/2 + 40);
      startButton.display();
      
      //ranking.load_data();
      //ranking.print_data();
      textSize(25);
      textAlign(LEFT);
      fill(255);
      text("Ranking", 20, 40);
      for(int i = 0; i < ranking.r_datas.size(); i++){
        Rank_data temp = ranking.r_datas.get(i);
        text("Rank: " + temp.rank + ",  " + "Score: " + temp.score,20, 40 + 40*(i+1));
      }
    }

  void displayHUD(){
      textAlign(LEFT);
      textSize(15);
      fill(255);
      text("Lives: " + lifeCount, 15,20);
      text("Score " + score, 15, 40);
  }

  void displayPauseScreen(){
      fill(50,50,50,1);
      rect(0,0,width,height);
      fill(0);
      rect(width/2 - 152, height/2 - 70, 300, 80);
      contButton.display();
      quitButton.display();
      replayButton.display();
      fill(255);
      noStroke();
      textAlign(CENTER);
      textSize(40);
      text("GAME PAUSED", width/2, height/2);
      textSize(12);
      text("Press M to toggle music", width/2, height/2 - 50);    
  }

  void displayVictoryScreen(){
    fill(50,50,50,1);
      rect(0,0,width,height);
      replayButton.display();
      quitButton.display();
      fill(#85BC8B);
      noStroke();
      textAlign(CENTER);
      textSize(40);
      text("VICTORY", width/2, height/2); 
  }

  void displayDefeatScreen(){
    fill(50,50,50,1);
      rect(0,0,width,height);
      replayButton.display();
      quitButton.display();
      fill(#BC8585);
      noStroke();
      textAlign(CENTER);
      textSize(40);
      text("DEFEAT", width/2, height/2); 
      
  }
}

public enum BoundingType{
  CLAMPING,
  WRAP,
  BOUNCE;
}