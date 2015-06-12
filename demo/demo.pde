// Korkkii & Walther @ Graffathon 2015


int CANVAS_WIDTH = 480;
int CANVAS_HEIGHT = 360;
int tick = 0;

void setup() {
    // Set up the drawing area size and renderer (usually P2D or P3D,
    // respectively for accelerated 2D/3D graphics).
    size(CANVAS_WIDTH, CANVAS_HEIGHT, P2D);

    // Drawing options that don't change, modify as you wish
    frameRate(60);
    noStroke();
    fill(255);
    smooth();

}

void drawDemo(int time) {
      text("Hello, Graffathon!", 100, 100);
}

void draw() {
    // Reset all transformations.
    resetMatrix();
    // Clear screen before every new frame
    clear();
    tick++;

    // Draw demo at the current position.
    drawDemo(tick);
}

