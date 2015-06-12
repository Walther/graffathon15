// Korkkii & Walther @ Graffathon 2015


int CANVAS_WIDTH = 512;
int CANVAS_HEIGHT = 512;

void setup() {
    // Set up the drawing area size and renderer (usually P2D or P3D,
    // respectively for accelerated 2D/3D graphics).
    size(CANVAS_WIDTH, CANVAS_HEIGHT, P3D);
    rectMode(CENTER);

    // Drawing options that don't change, modify as you wish
    frameRate(60);
    //noStroke();
    fill(255);
    smooth();

}

void drawDemo(int time) {
    //text("Hello, Graffathon!", 100, 100);
    //text("Current tick is: " + tick, 100, 120);

    float t = millis();
    float s = millis()/10;

    background(22, 22, 22);
    fill(s%256, s%256, s%256);
    for (int x=32; x<512; x+=32) {
        for (int y=32; y<512; y+=32) {
            for (int z=32; z<512; z+=32) {
                pushMatrix();
                discoCube(x, y, z, t);
                popMatrix();
            }
        }
    }

}

void discoCube(int x, int y, int z, float t) {
    translate(x, y, -z);
    pushMatrix();
    rotateY((float) t/1000);
    box(16);
    translate(-x, -y);
    popMatrix();
    lights();
}

void draw() {
    // Draw demo at the current position.
    drawDemo(millis());
}
