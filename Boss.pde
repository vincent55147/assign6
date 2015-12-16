// Boss image is "img/enemy2.png" 
class Boss {
  int x = 0;
  int y = 0;
  int boss_hp=0;
  PImage bossImg;


  Boss(int x, int y) {
    this.x=x;
    this.y=y;
    boss_hp=5;
    bossImg= loadImage("img/enemy2.png");
   
  }

  void move() {
    x+=2;
  }

  void draw() {
    image(bossImg, x, y);
  }
  boolean isCollideWithFighter() {  
    if (isHit(this.x, this.y, this.bossImg.width, this.bossImg.height, fighter.x, fighter.y, fighter.fighterImg.width, fighter.fighterImg.height)) 
      return true;
    else
      return false;
  }

  boolean isOutOfBorder() {
    if (this.x>=1040)
      return true;
    else
      return false;
  }
}
