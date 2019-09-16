import java.lang.reflect.Method;

ArrayList<Brush> brushes;
int time;

JSONArray displays;

void setup() {

  fullScreen();
  background(0);

  // load display data
  displays = loadJSONArray("mapping.json");

  // init brushes and mood
  brushes = new ArrayList<Brush>();

  for (int i = 0; i < displays.size(); i++) {
    JSONObject display = displays.getJSONObject(i);
    int dHeight = display.getInt("height");
    int dWidth = display.getInt("height");
    int x = display.getInt("x");
    int y = display.getInt("y");
    Boolean small = display.getBoolean("small");
    // add brushes to each display
    int brushCount;
    if (small) {
      brushCount = 3;
    }
    else {
      brushCount = 50;
    }
    for (int j = 0; j < brushCount; j++) {
      brushes.add(new Brush(x, y, dWidth, dHeight, small));
    }
  }

  setTimeout("setup", 60000);
}

void setTimeout(String name,long time){
  new TimeoutThread(this,name,time,false);
}

void draw() {
  for (Brush brush : brushes) {
    brush.paint();
  }
}

void mousePressed() {
  setup();
}

class Brush {
  float angle;
  int components[];
  float x, y;
  color clr;

  Brush(int dX, int dY, int dWidth, int dHeight, Boolean dSmall) {
    angle = random(TWO_PI);
    x = dX+random(dWidth);
    y = dY+random(dHeight);
    clr = color(random(255), random(255), random(255), 5);
    components = new int[2];
    for (int i = 0; i < 2; i++) {
      components[i] = int(random(1, dSmall ? 40 : 30));
    }
  }

  void paint() {
    float a = 0;
    float r = 0;
    float x1 = x;
    float y1 = y;
    float u = random(0.2, 0.9);

    fill(clr);
    noStroke();    

    beginShape();
    while (a < TWO_PI) {
      vertex(x1, y1); 
      float v = random(0.35, 1);
      x1 = x + r * cos(angle + a) * u * v;
      y1 = y + r * sin(angle + a) * u * v;
      a += PI / 180;
      for (int i = 0; i < 2; i++) {
        r += sin(a * components[i]);
      }
    }
    endShape(CLOSE);

    if (x < 0 || x > width ||y < 0 || y > height) {
      angle += HALF_PI;
    }

    x += 2 * cos(angle);
    y += 2 * sin(angle); 
    angle += random(-0.15, 0.15);
  }
}

class TimeoutThread extends Thread{
  Method callback;
  long now,timeout;
  Object parent;
  boolean running;
  boolean loop;

  TimeoutThread(Object parent,String callbackName,long time,boolean repeat){
    this.parent = parent; 
    try{
      callback = parent.getClass().getMethod(callbackName);
    }catch(Exception e){
      e.printStackTrace();
    }
    if(callback != null){
      timeout = time;
      now = System.currentTimeMillis();
      running = true;  
      loop = repeat; 
      new Thread(this).start();
    }
  }

  public void run(){
    while(running){
      if(System.currentTimeMillis() - now >= timeout){
        try{
          callback.invoke(parent);
        }catch(Exception e){
          e.printStackTrace();
        }
        if(loop){
          now = System.currentTimeMillis();
        }else running = false;
      }
    }
  }
  void kill(){
    running = false;
  }

}