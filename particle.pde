class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector previousPos;
  float maxSpeed;
  color colour;

  Particle(PVector start, float maxspeed) {
    maxSpeed = maxspeed;
    pos = start;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    previousPos = pos.copy();
  }
  void run() {
    update();
    edges();
    show();
  }
  void update() {
    pos.add(vel);
    vel.limit(maxSpeed);
    vel.add(acc);
    acc.mult(0);
  }
  void applyForce(PVector force) {
    acc.add(force);
  }
  void show() {
    stroke(colour, 90);
    strokeWeight(2);
    point(pos.x, pos.y);
  }

  void edges() {
    if (pos.x > width) {
      pos.x = 0;
    }
    if (pos.x < 0) {
      pos.x = width;
    }
    if (pos.y > height) {
      pos.y = 0;
    }
    if (pos.y < 0) {
      pos.y = height;
    }
  }
  void follow(PVector[] vectors) {
    int x = floor(pos.x / scale);
    int y = floor(pos.y / scale);
    int index = x + y * cols;
    PVector force = vectors[index];
    applyForce(force);
  }
  void setColor(PVector[] colors) {
    int x = floor(pos.x / scale);
    int y = floor(pos.y / scale);
    int index = x + y * cols;
    colour = color(colors[index].x, colors[index].y, colors[index].z);
  }
}
