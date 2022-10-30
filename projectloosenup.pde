import processing.sound.*;

SoundFile ambient;

// Music is no copyright. 
// See here: https://www.youtube.com/watch?v=LSqttgJRud8

float x0;
float x1;
float k;
float s;
float timer;
float timer1; 
boolean helppage;
boolean lines;

void setup(){
  size(650, 350);
  k = 16.0;
  s = 0.2;
  timer = 0;
  timer1 = 0;
  frameRate(144);
  ellipseMode(CENTER);
  strokeWeight(1);
  // Music settings
  SoundFile ambient = new SoundFile(this, "ambient.mp3");
  ambient.amp(0.8);
  ambient.play();
  ambient.loop();
  // Finished music settings
  x0 = -117.5;
  x1 = 117.5;
  // Variables affecting velocity and acceleration
}

void draw(){
  // Linking speed and timing variables to timers
  timer += s;
  timer1 += k;
  // Adding colour
  int time = millis() / 30; 
  float rd = 1 / (255.f / PI);
  float fr = float(time % 0xff) * rd;
  float fg = float((time - 0x80) % 0xff) * rd;
  float fb = float(time % 0xff) * rd;
  int r = int(sin(fr) * 255.f);
  int g = int(sin(fg) * 255.f);
  int b = int(cos(fb) * 255.f); 
  // Finished adding colour

  // Settings
  fill(0, 0, 0, map(s, 0, 1, 15, 45));
  strokeWeight(2);
  stroke(0);
  rect(0, 0, width, height);
  fill(255);
  textAlign(CENTER);
  textSize(15);
  text("Press 'H' to toggle the help page", width/2, height-21);   
  translate(width/2, (height/2)-20);
  fill(0, 0, 0, map(s, 0, 1, 15, 45));
  strokeWeight(2);
  stroke(r/2, g/2, b/2);
  ellipse(0, 0, 250, 250);
  // Finished settings
  
  // Timing of ball movement
  for (int i = 0; i < 8; i++){
    float t = timer / 100.0;
    t += i/k;
    t = frac(t);
  
    float x;
    if (t > 0.5){
      t = t - 0.5;
      t *= 2;
      x = accel(x0, x1, x0, x1, t);
    }
    else {
      t *= 2;
      x = accel(x1, x0, x1, x0, t);
    }
    rotate(TWO_PI/16);
    if (lines == true){
    stroke(255, 255, 255, 20);
    line(-125, 0, 125, 0);
  } 
    fill(r, g, b);
    stroke(r, g, b);
    ellipse(x, 0, 15, 15);
  }
  // Drawing help page
  if (helppage == true){
    fill(255, 100, 0, 230);
    stroke(0);
    strokeWeight(1);
    rect(-275, -147.5, width-100, height-75);
    rotate(PI);
    textAlign(LEFT);
    fill(0);
    textSize(20);
    text("This is an optical illusion. The circles are moving in a", -260, -100);
    text("straight line. Hit SPCBR to see!", -260, -70);
    text("UP and DOWN arrow keys increase and decrease the", -260, -30);
    text("speed.", -260, 0);
    text("RIGHT and LEFT arrow keys change the mode.", -260, 40);
    textSize(30);
    fill(r/2, g/2, b/2);
    textAlign(CENTER);
    text("Now go loosen up!", 0, 105);
  }
  println("speed =" +s);
  println("mode ="  +k);
}

// If keyPressed statements
void keyPressed(){
  // Help page
  if (key == 'h'){
    helppage = !helppage;
    background(0);
  }
  // Show lines
  if (key == ' '){
    lines = !lines;
    background(0);
  }
  // Up and down arrow keys
  if (key == CODED){
    if (keyCode == UP){
      s = s/0.8;
    }
    if (keyCode == DOWN){
      s = s*0.8;
    }
  }
  // Right and left arrow keys
  if (key == CODED){
    if (keyCode == RIGHT){
      k = k + 0.5;
    }
    if (keyCode == LEFT){
      k = k - 0.5;
    }
  }
}

// The acceleration code.
float accel(float v0, float v1, float v2, float v3, float x){
  float x2 = x*x;
  float a0 = v3 - v2 - v0 + v1;
  float a1 = v0 - v1 - a0;
  float a2 = v2 - v0;
  float a3 = v1;
  
  return a0 * x * x2 + a1 * x2 + a2 * x + a3;
}
  
float frac(float t){
  return t - float(int(t));
}
