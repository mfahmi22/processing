int input = 0;
Ball[] balls = new Ball[10];
int[][] warna = new int[10][3];
int random;

void keyPressed(){
  switch(key){
    case '3' : input=3; break;
    case '4' : input=4; break;
    case '5' : input=5; break;
    case '6' : input=6; break;
    case '7' : input=7; break;
    case '8' : input=8; break;
    case '9' : input=9; break;
    default : input=0; break;
  }
  for (int i = 0; i < balls.length; i++) {
    balls[i] = new Ball(random(30, 100), 120);
  }
}

void setup() {
  size(800, 600);
}

void draw() {
  background(0);
  fill(255,0,0);
  rect(0,0,5,600);
  rect(795,0,5,600);
  fill(0,255,0);
  rect(5,0,790,5);
  fill(0,0,255);
  rect(5,595,790,5);
  for (int i = 0; i < input; i++) {     
    balls[i].display();
    balls[i].move();
    balls[i].edges();
    for (int o = 0; o < input; o++) {
      if (o!=i) {                
        balls[i].overlaps(balls[o]);
        balls[o].overlaps(balls[i]);     
      }
    }
  }
}

class Ball {
  float dia;
  float x;
  float y; 
  float col;
  float xspeed;
  float yspeed;
  float r;
  color fillColor;

  Ball (float tempD, float tempC) {
    x = random(100, 700);
    y = random(100, 400);
    dia = tempD;
    col = tempC;
    r = dia/2;
    xspeed = random(-2,5);
    yspeed = random(-2,5);
    
    for (int i = 0; i < balls.length; i++) {
    random = int(random(3));
      if(random==0){
        warna[i][0] = 255;
        warna[i][1] = 0;
        warna[i][2] = 0;
      }
      else if(random==1){
        warna[i][0] = 0;
        warna[i][1] = 255;
        warna[i][2] = 0;
      }
      else{
        warna[i][0] = 0;
        warna[i][1] = 0;
        warna[i][2] = 255;
      }
      fillColor = color(warna[i][0],warna[i][1],warna[i][2]);
    }
  }
  
  void display() {
    noStroke();
    
    fill(fillColor);
    ellipse(x, y, dia, dia);
  }

  void move() {
    x = x + xspeed;
    y = y + yspeed;
  }

  void edges() {
    if (x > width-r ) {
      xspeed = abs(xspeed) * -1; // always neg
      for (int i = 0; i < balls.length; i++) {
          warna[i][0] = 255;
          warna[i][1] = 0;
          warna[i][2] = 0;
        fillColor = color(warna[i][0],warna[i][1],warna[i][2]);
      }
    }
    if ( x < r) {
      xspeed = abs(xspeed); // always pos
      for (int i = 0; i < balls.length; i++) {
          warna[i][0] = 255;
          warna[i][1] = 0;
          warna[i][2] = 0;
        fillColor = color(warna[i][0],warna[i][1],warna[i][2]);
      }
    }
    if (y > height-r ) {
      yspeed = abs(yspeed) * -1; // always neg
      for (int i = 0; i < balls.length; i++) {
          warna[i][0] = 0;
          warna[i][1] = 0;
          warna[i][2] = 255;
        fillColor = color(warna[i][0],warna[i][1],warna[i][2]);
      }
    }
    if ( y < r) {
      yspeed = abs(yspeed); // always pos
      for (int i = 0; i < balls.length; i++) {
          warna[i][0] = 0;
          warna[i][1] = 255;
          warna[i][2] = 0;
        fillColor = color(warna[i][0],warna[i][1],warna[i][2]);
      }
    }
  }
  void overlaps(Ball o) {
    float d = dist(x, y, o.x, o.y);
    if (d <= r + o.r) {
      if(x<o.x) {
        xspeed= -abs(xspeed);
      }
      if(x>o.x) {
        xspeed= abs(xspeed);
      }
      if(y<o.y) {
        yspeed= -abs(yspeed);
      }
      if(y>o.y) {
        yspeed= abs(yspeed);
      }      
    }
  }
}
