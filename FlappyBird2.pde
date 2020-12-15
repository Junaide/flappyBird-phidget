PFont FlappyFont;
PrintWriter HighScore;
PImage bird, pillarup, pillardown, bg, bg2;
import processing.sound.*;
SoundFile ding;
import com.phidget22.*;

int gamestate = 0;
int x = -200, y,vy = 0;
int score = 0;
pillar[] p = new pillar[3];
boolean end=false;
boolean intro=true;
int[] wx = new int[2];
int[] wy = new int[2];
Bird FlappyBird = new Bird();
void setup(){
  
  size(600,800);
  FlappyFont = createFont("Flappy-Bird.ttf", 60);
  bg = loadImage("r_large.jpg");
  ding = new SoundFile(this, "ding.mp3");
  pillarup = loadImage("pillarup.png");
  pillardown = loadImage("pillardown.png");
  bird = loadImage("bird.png");
  for(int i = 0;i<3;i++){
      p[i]=new pillar(i);
      }
}

class Bird{
    float xPos, yPos, ySpeed; 
 Bird(){
  xPos = 200;
  yPos = 300;
 }
 void drawBird(){
      image(bird, xPos,yPos,70,70); 
 }
 
 void moveUp(){
      ySpeed -= 10;
       
 }
 
  void drag(){
     ySpeed+=0.4; 
    }
    void move(){
     yPos+=ySpeed; 
     for(int i = 0;i<3;i++){
      p[i].xPos-=3;
     }
    }
    void checkCollisions(){
     if(yPos>800){
      end=false;
     }
    for(int i = 0;i<3;i++){
    if((xPos<p[i].xPos+10&&xPos>p[i].xPos-50)&&(yPos<p[i].opening-118||yPos>p[i].opening+50)){ // Checks collision with pillar
     end=false; 
        }
      }
    }
}
  



    



void draw(){
      background(bg);
      if(end){
      FlappyBird.move();
      }
      FlappyBird.drawBird();
      if(end){
      FlappyBird.drag();
      }
      FlappyBird.checkCollisions();
      for(int i = 0;i<3;i++){
      p[i].drawPillar();
      p[i].checkPosition();
      }
      fill(0);
      stroke(255);
      textSize(32);
      if(end){
      textFont(FlappyFont);
      textSize(70);
      fill(0,0,0);
     text(score,290,108);
      
      
         textSize(60);
           fill(255,255,255);
      text(score,290,108);
  
      
   
      
     
      }else{
      rect(150,100,200,50);
      rect(150,200,200,50);
      fill(255);
      if(intro){
        text("Flappy Code",155,140);
        text("Click to Play",155,240);
      }else{
      text("game over",170,140);
      text("score",180,240);
      text(score,280,240);
      }
      }
    }


 class pillar{
      float xPos, opening;
      boolean cashed = false;
     pillar(int i){
      xPos = 100+(i*200);
      opening = random(600)+100;
     }
     void drawPillar(){
       
       image(pillardown,xPos,opening-900,50,800);
       image(pillarup,xPos,opening+100,50,800);
       //line(xPos,0,xPos,opening-100);  
       //line(xPos,opening+100,xPos,800);
     }
     void checkPosition(){
      if(xPos<0){
       xPos+=(200*3);
       opening = random(600)+100;
       cashed=false;
      } 
      if(xPos<200&&cashed==false){
       cashed=true;
       ding.play();
       score++; 
       
      }
     }
    }
    void reset(){
     end=true;
     score=0;
     FlappyBird.yPos=400;
     for(int i = 0;i<3;i++){
      p[i].xPos+=550;
      p[i].cashed = false;
     }
    }
    
void mousePressed(){
FlappyBird.moveUp();
     intro=false;
     if(end==false){
       reset();
     }
  }
  
  void keyPressed(){
FlappyBird.moveUp();

     intro=false;
     if(end==false){
       reset();
     }
  }