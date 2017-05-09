import ddf.minim.*;
Player player;
GUI gui;
Swarm swarm;
Level level;
PImage map;
PImage foreground;
View worldView;
Minim minim;
AudioPlayer music;
Bullets bullets;
Ranking ranking;
Orbit orb;

String state = "START";
public static int lifeCount = 9;
public static int score = 0;
public static int winScore = 10;
public static final float ceiling = 0;
public static final float leftEnd = 0;
public static float xTranslationAMT = 0;
public static boolean invulnerable = false;
public float alpha = 100;
public static boolean score_added = false;

void setup(){
  size(1366, 768, P2D);
  background(50);
  player = new Player(new PVector(width/2, height/2));
  gui = new GUI();
  swarm = new Swarm();
  worldView = new View();
  level = new Level(player);
  bullets = new Bullets();
  ranking = new Ranking();
  ranking.load_data();
  map = loadImage("map.png");
  foreground = loadImage("foreground.png");
  orb = new Orbit("goldOrb.png", "highlightOrb.png",1,60);
  
  minim = new Minim(this);
  music = minim.loadFile("DeepHaze.mp3");
  music.loop();
}

void draw(){
  switch(state){   
    case "START":
      gui.displayStartScreen(ranking);
    break;
    case "PLAY":
    score_added = false;
    pushMatrix();
      worldView.track(player);
      xTranslationAMT = worldView.getXTranslation();
      image(map,0,0); 
      swarm.display(bullets);
      player.display(bullets);
      level.build();
      bullets.display();
      image(foreground,0,0);
      orb.display(3730, height/2);
      popMatrix(); 
      player.move();
      gui.displayHUD();
      if(invulnerable){screenFlash();}
      
      for(Enemy enemy : swarm.getEnemyArray()){
        if(!invulnerable && enemy.isPointInside(player.getPos().x, player.getPos().y-10) && enemy.getStatus() == 1){ 
          lifeCount -=1; 
          invulnerable = true; 
          alpha = 100;
        }
      }
      if(lifeCount <= 0) state = "DEFEAT";
    break;   
    case "PAUSED":
      gui.displayPauseScreen();
    break;    
    case "VICTORY":
      gui.displayVictoryScreen();
    break;    
    case "DEFEAT":
      gui.displayDefeatScreen(); //<>//
      if(score_added == false){
        for(int i = ranking.r_datas.size() - 1; i >= 0; i--){
          if(i == ranking.r_datas.size() - 1 && score < ranking.r_datas.get(i).score) break;
          else if(i == 0 && score > ranking.r_datas.get(i).score){
            ranking.r_datas.get(i).rank++;
            Rank_data temp = new Rank_data();
            temp.rank = 1;
            temp.score = score;
            ranking.r_datas.add(0, temp);
            break;
          }
          else if(score > ranking.r_datas.get(i).score) ranking.r_datas.get(i).rank += 1;
          else if(score <= ranking.r_datas.get(i).score){
            Rank_data temp = new Rank_data();
            temp.rank = i + 2;
            temp.score = score;
            ranking.r_datas.add(i+1, temp);
            break;
          }
          
        }
        Table table;
        table = new Table();
    
        table.addColumn("rank");
        table.addColumn("score");
        //table.addColumn("name");
        
        for(int i = 0; i < min(ranking.r_datas.size(),10); i++){
          TableRow newRow = table.addRow();
          newRow.setInt("rank", ranking.r_datas.get(i).rank);
          newRow.setInt("score", ranking.r_datas.get(i).score);
          //newRow.setString("name", "Lion");
        }
        saveTable(table, "ranking.csv");
      }
      score_added = true;
    break;
  }
}

public void resetLevel(){
    state = "START";
    lifeCount = 9;
    score = 0;
    player.setPos(width/2,height/2);
    swarm = new Swarm();
    level = new Level(player);
}

public void screenFlash(){
  if(alpha > 0){
    fill(255,0,0, alpha);
    noStroke();
    rect(0,0,width, height);
    if(alpha > 0) alpha -= 2;
    if(alpha <=0) {alpha = 0; invulnerable = false;}
  }
}

void mousePressed(){
  if((state == "PAUSED" || state == "DEFEAT" || state == "VICTORY") && gui.quitButton.mouseOver()) exit();
  if(state == "PAUSED" && gui.contButton.mouseOver()) state = "PLAY";
  if(state == "PAUSED" && gui.replayButton.mouseOver()) { resetLevel(); }
  if(state == "START" && gui.startButton.mouseOver()) state = "PLAY";
  if((state == "VICTORY" || state == "DEFEAT") && gui.replayButton.mouseOver()) { resetLevel(); }
  if(orb.mousedOver()){player.setLeftBound(0);player.setPos(width/2,height/2); level = new Level(player);}
}

void keyPressed(){
  if((key == 'p' || key == 'P') && state == "PLAY") state = "PAUSED";
  if(key == 'm' || key == 'M') {
    if(music.isMuted()) music.unmute();
    else music.mute();
  }
  if(state == "PLAY"){
    if (key == 'a' || key == 'A' || keyCode == LEFT) player.setKeys(0,true);
    if (key == 'w' || key == 'W' || keyCode == UP) player.setKeys(1,true);
    if (key == 'd' || key == 'D' || keyCode == RIGHT) player.setKeys(2,true);
    if (key == 's' || key == 'S' || keyCode == DOWN) player.setKeys(4,true);
    if (key == ' ') player.setKeys(3, true);
  }
}

void keyReleased(){
    if (key == 'a' || key == 'A' || keyCode == LEFT) player.setKeys(0,false);
    if (key == 'w' || key == 'W' || keyCode == UP) {player.setKeys(1,false);}
    if (key == 'd' || key == 'D' || keyCode == RIGHT) player.setKeys(2,false);
    if (key == 's' || key == 'S' || keyCode == DOWN) player.setKeys(4,false);
    if (key == ' ') {player.setKeys(3,false); player.p_interval = 0;}
}