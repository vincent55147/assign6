class GameState
{
  static final int START = 0;
  static final int PLAYING = 1;
  static final int END = 2;
}
class Direction
{
  static final int LEFT = 0;
  static final int RIGHT = 1;
  static final int UP = 2;
  static final int DOWN = 3;
}
class EnemysShowingType
{
  static final int STRAIGHT = 0;
  static final int SLOPE = 1;
  static final int DIAMOND = 2;
  static final int STRONGLINE = 3;
}
class FlightType
{
  static final int FIGHTER = 0;
  static final int ENEMY = 1;
  static final int ENEMYSTRONG = 2;
}
int  shoothave=0,shootnum=0;
int state = GameState.START;
int currentType = EnemysShowingType.STRAIGHT;
int enemyCount = 8;
int shootCount =99;
Enemy[] enemys = new Enemy[enemyCount];
Fighter fighter;
Background bg;
FlameMgr flameMgr;
Treasure treasure;
HPDisplay hpDisplay;
Bullet[] bullets =new Bullet[shootCount];
Boss[] bosss=new Boss[5];
boolean isMovingUp;
boolean isMovingDown;
boolean isMovingLeft;
boolean isMovingRight;
boolean currck=true;;
int time;
int wait = 4000;



void setup () {
  size(640, 480);
  flameMgr = new FlameMgr();
  bg = new Background();
  treasure = new Treasure();
  hpDisplay = new HPDisplay();
  fighter = new Fighter(20);
  for(int i=0;i<shootCount;i++)
    bullets[i]=new Bullet();
}

void draw()
{
  if (state == GameState.START) {
    bg.draw();  
  }
  else if (state == GameState.PLAYING) {
    bg.draw();
    treasure.draw();
    flameMgr.draw();
    fighter.draw();
   
 
    for(int bullet_draw=0;bullet_draw<shootCount;bullet_draw++ )
    if(bullets[bullet_draw].bullet){
    bullets[bullet_draw].draw();
    bullets[bullet_draw].move();
    bullets[bullet_draw].out();
     if (bullets[bullet_draw].isCollideWithshoot()) {
         
          flameMgr.addFlame(bullets[bullet_draw].x, bullets[bullet_draw].y);
          
        }
  }
  
    //enemys
    for(int boss_ck=0;boss_ck<5;boss_ck++)
    if(bosss[boss_ck]!=null)
    currck=false;
    for(int enemy_ck=0;enemy_ck<5;enemy_ck++)
    if(enemys[enemy_ck]!=null)
    currck=false;
    if(currck){
      addEnemy(currentType++);
      currentType = currentType%4;
    }
    currck=true;
    for (int i = 0; i < enemyCount; ++i) {
      if (enemys[i]!= null) {
        enemys[i].move();
        enemys[i].draw();
        if (enemys[i].isCollideWithFighter()) {
          fighter.hpValueChange(-20);
          flameMgr.addFlame(enemys[i].x, enemys[i].y);
          enemys[i]=null;
        }
        else if (enemys[i].isOutOfBorder()) {
          enemys[i]=null;
        }
      }
    }
     for (int bosd = 0; bosd < 5; ++bosd) {
      if (bosss[bosd]!= null) {
        bosss[bosd].move();
        bosss[bosd].draw();
        if (bosss[bosd].isCollideWithFighter()) {
          fighter.hpValueChange(-50);
          flameMgr.addFlame(bosss[bosd].x, bosss[bosd].y);
          bosss[bosd]=null;
        }
        else if (bosss[bosd].isOutOfBorder()) {
          bosss[bosd]=null;
        }
      }
     }     //
    hpDisplay.updateWithFighterHP(fighter.hp);
  }
  else if (state == GameState.END) {
    bg.draw();
    flameMgr = new FlameMgr();
  bg = new Background();
  treasure = new Treasure();
  hpDisplay = new HPDisplay();
  fighter = new Fighter(20);
  for(int i=0;i<shootCount;i++)
    bullets[i]=new Bullet();
    currentType=0;
   
  }
}
boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh)
{
  // Collision x-axis?
    boolean collisionX = (ax + aw >= bx) && (bx + bw >= ax);
    // Collision y-axis?
    boolean collisionY = (ay + ah >= by) && (by + bh >= ay);
    return collisionX && collisionY;
}

void keyPressed(){
  switch(keyCode){
    case UP : isMovingUp = true ;break ;
    case DOWN : isMovingDown = true ; break ;
    case LEFT : isMovingLeft = true ; break ;
    case RIGHT : isMovingRight = true ; break ;
    default :break ;
  }
}
void keyReleased(){
  switch(keyCode){
  case UP : isMovingUp = false ;break ;
    case DOWN : isMovingDown = false ; break ;
    case LEFT : isMovingLeft = false ; break ;
    case RIGHT : isMovingRight = false ; break ;
    default :break ;
  }
  if (key == ' ') {
    if (state == GameState.PLAYING) {
      
    fighter.shoot();
  }
  }
  if (key == ENTER) {
    switch(state) {
      case GameState.START:
      case GameState.END:
        state = GameState.PLAYING;
    enemys = new Enemy[enemyCount];
    flameMgr = new FlameMgr();
    treasure = new Treasure();
    fighter = new Fighter(20);
      default : break ;
    }
  }
}
