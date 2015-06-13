// Korkkii & Walther @ Graffathon 2015


int CANVAS_WIDTH = displayWidth;
int CANVAS_HEIGHT = displayHeight;

boolean sketchFullScreen() {
  return true;
}

void setup() {
    // Set up the drawing area size and renderer (usually P2D or P3D,
    // respectively for accelerated 2D/3D graphics).
    if (CANVAS_WIDTH < 1366) { CANVAS_WIDTH = 1366; };
    if (CANVAS_HEIGHT < 768) { CANVAS_HEIGHT = 768; };

    size(CANVAS_WIDTH, CANVAS_HEIGHT, P3D);
    rectMode(CENTER);

    // Drawing options that don't change, modify as you wish
    frameRate(60);
    fill(255);
    smooth();

}

void draw() {

    // Define a useful timescale: t = seconds
    float t = (float) millis() / 1000;

    // Define colors
    background(22, 22, 22);

    // Loading text, so that the effects don't start before the screen is actually drawn
    if (t<10) {
    text("Loading...", 100, 100, 0);
    } else { // After loading period, start main draw

        // Define initial width of the biggest cube
        int W = 512;
        // Center the big cube
        translate(CANVAS_WIDTH/2 - W/2, 0, 0);
        translate(0, CANVAS_HEIGHT/2 - W/2, 0);

        // Zoom in and out based on tick
        if (t>20) {
            translate(0, 0, (512 - abs(512 - (t*100)%1024)));
        }
        // More rotates after more time
        if (t>30) {
            rotateX(t/2);
        }


        bigCube(W, t);

        // End of drawing content to frame, hit the lights!
        lights();
    }
}

void bigCube(int C_width, float t) {

    // Define big cube width
    int W = C_width;
    // Define amount of small cubes per side of big cube
    int n = (int) (16 - abs(16 - (t/10)%32));
    //int n = 8;
    if (n == 0) { n=2; };
    // Define small cube width
    int w = C_width / (n*2);

    // Define standard rotation
    pushMatrix();
    translate(W/2, 0, -W/2);
    float rot = (float) t/5;
    rotateY(rot);
    translate(-W/2, 0, W/2);

    // Draw the small cubes to form a big meta-cube
    for (int x=0; x<=W; x+=W/n) {
        for (int y=0; y<=W; y+=W/n) {
            for (int z=0; z<=W; z+=W/n) {
                if (W > 256) { // TODO: fix this. Must go deeper ;)
                    pushMatrix();
                    translate(x, y, z);
                    bigCube(w, t);
                    popMatrix();
                } else {
                    discoCube(x, y, z, w, t);
                }
            }
        }
    }
    popMatrix();
}

// A disco cube is a blinking, rotating cube at x,y
void discoCube(int x, int y, int z, int c_width, float t) {

    // Colouring options!

    if (t<20) {
        fill(255,255,255); // Plain white
    }
    if (t>20) {
        int col = (int) abs(255-(t*50)%512); // Back-and-forth grayscale
        fill(col, col, col);
    }
    if (t>30) {
        int col = (int) abs(255-(t*50)%512); // Back-and-forth white-colourcube
        fill(col+x, col+y, col+z);
    }
    if (t>40) {
        fill(x, y, z); // static colorcube
    }


    pushMatrix();
    translate(x, y, -z);
    pushMatrix();

    // Rotating options!

    float rot = (float) t/5;

    if (t<20) {
        rotateX(rot);
    }
    if (t>20) {
        rotateX(rot+x);
        rotateY(rot);
    }
    if (t>30) {
        rotateX(rot+x);
        rotateY(rot+y);
        rotateZ(rot);
    }
    if (t>40) {
        rotateX(rot+x);
        rotateY(rot+y);
        rotateZ(rot+z);
    }


    box(c_width);
    translate(-x, -y);
    popMatrix();
    popMatrix();
}

