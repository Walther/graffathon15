// Korkkii & Walther @ Graffathon 2015


int CANVAS_WIDTH = 1280;
int CANVAS_HEIGHT = 700;

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

    // Define some useful timescales
    float t = millis();
    float s = (float) millis()/10;
    float c = (float) millis()/1000;

    // Define colors
    background(22, 22, 22);
    fill(s%256, s%256, s%256);


    // Define big cube width
    int C_width = 512;
    // Define small cube width
    int c_width = 16;

    // Center the big cube
    translate(CANVAS_WIDTH/2 - C_width/2, 0, 0);
    translate(0, CANVAS_HEIGHT/2 - C_width/2, 0);

    // Rotate big cube along its center axis
    pushMatrix();
    translate(C_width/2, 0, -C_width/2);
    rotateY(PI*c/10);
    translate(-C_width/2, 0, C_width/2);

    // Draw the small cubes to form a big meta-cube
    for (int x=0; x<=C_width; x+=32) {
        for (int y=0; y<=C_width; y+=32) {
            for (int z=0; z<=C_width; z+=32) {
                discoCube(x, y, z, c_width, t);
            }
        }
    }
    popMatrix();
}

// A disco cube is a blinking, rotating cube at x,y
void discoCube(int x, int y, int z, int c_width, float t) {
    pushMatrix();
    translate(x, y, -z);
    pushMatrix();
    rotateY((float) t/1000);
    box(c_width);
    translate(-x, -y);
    popMatrix();
    lights();
    popMatrix();
}

void draw() {
    // Draw demo at the current position.
    drawDemo(millis());
}

