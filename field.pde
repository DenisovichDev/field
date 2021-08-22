int totalFrames = 600;
int counter = 0;
boolean record = false;     // Set to true when want to record

float xOff, yOff, zOff;
float inc = 0.1;
int scale = 10;
int cols, rows;
PVector v;
PVector c;
ArrayList<Particle> particles = new ArrayList<Particle>();
PVector[] flowfield;
PVector[] colorVector;

void setup() {
  background(0);

  size(600, 600);
  zOff = 0;
  cols = floor(width/ scale) + 1;
  rows = floor(height/ scale) + 1;
  flowfield = new PVector[rows * cols];
  colorVector = new PVector[rows * cols];

  for (int i = 0; i < 10000; i++) {
    PVector start = new PVector(random(width), random(height));
    particles.add(new Particle(start, random(2, 8)));
  }

  println(flowfield.length);
}

void draw() {
  background(0);


  yOff = 0;
  for (int y = 0; y < rows; y++) {
    xOff = 0;
    for (int x = 0; x < cols; x++) {

      float noiseScale = random(1, 1.3);
      float angle = noise(xOff, yOff, zOff) * TWO_PI * noiseScale;
      int r = floor(map(noise(xOff, yOff, zOff), 0, 1, 0, 255));
      int g = floor(map(noise(xOff + 1000, yOff+1000, zOff), 0, 1, 0, 255));
      int b = floor(map(noise(xOff + 2000, yOff+2000, zOff), 0, 1, 0, 255));
      v = PVector.fromAngle(angle);
      c = new PVector(r, g, b);
      int index = x + y * cols;
      flowfield[index] = v;
      colorVector[index] = c;
      xOff += inc;
    }
    yOff += inc;
  }
  zOff += 0.01;


  for (Particle p : particles) {
    p.setColor(colorVector);
    p.run();
    p.follow(flowfield);
  }

  if (record) {
    saveFrame("output/gif-"+nf(counter, 3)+".png");
    if (counter == totalFrames-1) {
      exit();
    }
  }
  counter++;

  println(frameCount);
}
