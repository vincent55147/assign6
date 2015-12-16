class Bullet {
  int x = 0;
  int y = 0;
  PImage shootImg;
  boolean collidecheck;
  boolean bullet;

  Bullet() {
    this.x = 0;
    this.y = 0;
    shootImg = loadImage("img/shoot.png");
    bullet=false;  
    collidecheck=false;
  }
  void move() {
    if (this.y>=-31)
      this.x-= 5;
  }
  void draw() {
    image(shootImg, x, y);
  }

  void out() {
    if (this.y<-31) {
      this.y=-100;
      this.x=-100;
    }
  }

  boolean isCollideWithshoot() {  
    for (int i=0; i<enemyCount; i++) {
      if (enemys[i]!= null&&isHit(enemys[i].x, enemys[i].y, enemys[i].enemyImg.width, enemys[i].enemyImg.height, this.x, this.y, this.shootImg.width, this.shootImg.height)) {
        shoothave--;  
        this.bullet=false;
        collidecheck=true;  
        enemys[i]=null;
      }
      
    }
     for (int a=0; a<5; a++) {
      if (bosss[a]!= null)
      if(isHit(bosss[a].x, bosss[a].y, bosss[a].bossImg.width, bosss[a].bossImg.height, this.x, this.y, this.shootImg.width, this.shootImg.height)) {
       shoothave--;
        bosss[a].boss_hp--;
       this.bullet=false;
       if(bosss[a].boss_hp==0){
        bosss[a]=null;
      collidecheck=true;   
       }
      }
      
    }
    if (collidecheck)
      return true;
    else
      return false;
  }
}
