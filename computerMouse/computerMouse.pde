//0:mouseX, 1:mouseY, 2:dx, 3:dy, 4:targetX, 5:targetY
float[] vals = {0, 0, 4, 2, 40, 40};
boolean done = false;
boolean move = false;
boolean moved = false;
boolean pressed = false;

PImage input;

void advance(float[] vals, int sizeX, int sizeY) {
  if (vals[0] >= sizeX)
    done = true;
  else if (vals[1] >= sizeY) {
    vals[1] = 0;
    vals[4] += 40;
    pressed = true;
    move = false;
  }
  else if (move) {
    vals[0] -= 40;
    vals[1] += 5;
    vals[2] = 4;
    vals[3] = 2;
    move = false;
    pressed = true;
  }
  else {
    vals[0] += vals[2];
    vals[1] += vals[3];
    if(vals[0] >= vals[4])
      move = true;
  }
}

color c;

void setup(){
  size(500, 500);
  background(255);
  input = loadImage("flower.jpg");
  image(input, 0, 0, input.width / 5, input.height / 3);
  
}

float[] xbristles = new float[400];
float[] ybristles = new float[400];
float brushVelocity = 0;
float brushRange = 10;

float xpos = 0;
float ypos = 0;

void draw() {
  if(!done) {
    advance(vals, 500, 500);
    c = get((int)vals[0], (int)vals[1]);
    stroke(c);
    //transparency *= .99;
    //c = color(100, 200,  50, transparency);
    //stroke(c);
    /*brushVelocity = sqrt(pow(vals[0], 2) + 
                       pow(vals[1], 2));
    if(brushVelocity >= 5);
      //brushRange *= .9;
    else {
      //brushRange *= 1.01;
      if(brushRange > 20)
      brushRange = 20;
    }*/
    if(pressed) {
      for(int i = 0; i < 400; i++) {
        xpos = random(vals[0] - brushRange, vals[0] + brushRange);
        ypos = random(vals[1] - brushRange, vals[1] + brushRange);
        point(xpos, ypos);
        xbristles[i] = xpos;
        ybristles[i] = ypos;
        pressed = false;
      }
    }
    else {
      for(int i = 0; i < 400; i++) {
        xpos = random(vals[0] - brushRange, vals[0] + brushRange);
        ypos = random(vals[1] - brushRange, vals[1] + brushRange);
        line(xbristles[i], ybristles[i], vals[0], vals[1]);
        xbristles[i] = xpos;
        ybristles[i] = ypos;
      }
    }
  }
}