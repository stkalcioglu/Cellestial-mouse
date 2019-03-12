// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;
OpenCV opencv;
Capture cam;
Rectangle[] faces;

ArrayList<BallRed> red = new ArrayList<BallRed>(); 
ArrayList<BallBlue> blue = new ArrayList<BallBlue>(); 
Face[] face = new Face[5];
float g = 0.4;
boolean birth = false;

int total=0;
float orbit=0;

PFont font;
PFont font1;
// The font must be located in the sketch's 
// "data" directory to load successfully



SoundFile[] file;


import processing.sound.*;
Sound s;
SoundFile soundfile;

int numsounds = 5;


void setup() {
  //size(1280, 800);
  fullScreen(P2D);

  //printArray(Capture.list());

  font = createFont("minimal-pixel.ttf", 300);
  font1 = createFont("Kiona-Regular.ttf", 300);

  //cam = new Capture(this, width/3, height/3);
  ////cam = new Capture(this, Capture.list()[2]);
  //cam.start();
  //opencv = new OpenCV(this, cam.width, cam.height); 
  //opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 

  // Create a Sound renderer and an array of empty soundfiles
  file = new SoundFile[numsounds];

  // Load 5 soundfiles from a folder in a for loop. By naming
  // the files 1.aif, 2.aif, 3.aif, ..., n.aif it is easy to iterate
  // through the folder and load all files in one line of code.
  for (int i = 0; i < numsounds; i++) {
    file[i] = new SoundFile(this, (i+1) + ".aif");
  }



  for (int i = 0; i < width; i=i+200) {
    for (int j = 0; j < height; j=j+200) { 
      red.add(new BallRed(random(1, 5), i+50, j+50));
      blue.add(new BallBlue(random(1, 5), i, j));
    }
  }
  for (int i = 0; i < face.length; i++) { //Yüzler için yüz sayısı kadar array
    face[i] = new Face(random(width), random(height));
  }

  // Play two sine oscillators with slightly different frequencies for a nice "beat".
  //SinOsc sin = new SinOsc(this);
  //sin.play(200, 0.1);
  //sin = new SinOsc(this);
  //sin.play(203, 0.1);

  // Create a Sound object for globally controlling the output volume.
  s = new Sound(this);


  // Load a soundfile from the /data folder of the sketch and play it back
  soundfile = new SoundFile(this, "Big_Explosion_Distant.aiff");

  //println(soundfile.channels());
}

void draw() {


  background(0);
  println(frameRate);

  //textFont(font);
  //textAlign(CENTER);
  //fill(255);
  //text("celestial", width/2, height/2);

  //opencv.loadImage(cam);  // We have to always "load" the camera image into OpenCV 
  //faces = opencv.detect();   // Detect the faces

  //image(cam, 0, 0);   // Draw the video

  //loadPixels();
  //for ( int x = 0; x < width; x++) {
  //  for ( int y = 0; y < height; y++) {
  //    float d2 = dist(x,y,width/2,height/2);
  //    pixels[x+y*width] = color(0,0,0,d2*0.1);
  //  }
  //}
  //updatePixels();


  if (total==1) {

    textFont(font);
    textAlign(CENTER);
    fill(255);
    text("c", width/2, height/2);
  }
  if (total==2) {

    textFont(font);
    textAlign(CENTER);
    fill(255);
    text("ce", width/2, height/2);
  }
  if (total==3) {

    textFont(font);
    textAlign(CENTER);
    fill(255);
    text("cel", width/2, height/2);
  }
  if (total==4) {

    textFont(font);
    textAlign(CENTER);
    fill(255);
    text("cele", width/2, height/2);
  }
  if (total==5) {

    textFont(font);
    textAlign(CENTER);
    fill(255);
    text("celes", width/2, height/2);
  }
  if (total==6) {

    textFont(font);
    textAlign(CENTER);
    fill(255);
    text("celest", width/2, height/2);
  }
  if (total==7) {

    textFont(font);
    textAlign(CENTER);
    fill(255);
    text("celesti", width/2, height/2);
  }
  if (total==8) {

    textFont(font);
    textAlign(CENTER);
    fill(255);
    text("celestia", width/2, height/2);
  }
  if (total==9) {

    textFont(font);
    textAlign(CENTER);
    fill(255);
    text("celestial", width/2, height/2);
  }
  if (total>9 && total<100) {

    textFont(font);
    textAlign(CENTER);
    fill(255);
    text("celestial", width/2, height/2);
  }

  //if (total>19 && total<100) {

  //  textFont(font1);
  //  textSize(30);
  //  textAlign(CENTER);
  //  fill(255);
  //  text(" Doruk Yildirim, Tolga Kalcioglu, Aysel Abasova", width/2, height/1.5);
  //}

  for (int b = blue.size() -1; b >= 0; b--) {
    for (int r = red.size() -1; r >= 0; r--) {
      PVector forceA = blue.get(b).attractB(red.get(r));
      PVector forceB = red.get(r).attractR(blue.get(b));

      //dest = dist(red.get(r).position.x,red.get(r).position.y,blue.get(b).position.x,blue.get(b).position.y);
      //dest = map(dest,0,100,100,255);


      blue.get(b).applyForce(forceA);
      red.get(r).applyForce(forceB);

      red.get(r).update();
      blue.get(b).update();

      red.get(r).checkedges();
      blue.get(b).checkedges();

      red.get(r).display();
      blue.get(b).display();


      //line(red.get(r).position.x, red.get(r).position.y, blue.get(b).position.x, blue.get(b).position.y);

      if (red.get(r).collide(blue.get(b))) {

        int sound1 = int(random(-1, 5));
        int sound2 = int(random(0, 5));
        file[sound1].play(sound2, 1.0);
        total++;


        fill(255, 200);
        ellipse(red.get(r).position.x, red.get(r).position.y, 20, 20);
        noFill();

        //EXPLOSION EFFECT WITH PIXELS
        for ( int u = -50; u< 50; u++) {
          for ( int t = -50; t< 50; t++) {
            set(int(red.get(r).position.x) + u, int(red.get(r).position.y) + u, color(255) );
          }
        }

        red.remove(r);
        blue.remove(b);

        blue.add(new BallBlue(random(1, 5), random(width), random(height)));
        red.add(new BallRed(random(1, 5), random(width), random(height)));



        break;
      }
    }
  }




  //if (mousePressed) {
  for (int i = 0; i < 1; i++) {
    face[i].display(orbit);
    //face[i].position.x = faces[i].x*4;
    //face[i].position.y = faces[i].y*4;
    face[i].position.x = mouseX;
    face[i].position.y = mouseY;
    for (int b = blue.size() -1; b >= 0; b--) {
      PVector force = face[i].attract(blue.get(b));
      for (int r = red.size() -1; r >= 0; r--) {
        PVector force2 = face[i].attract2(red.get(r));

        blue.get(b).applyForce(force);
        red.get(r).applyForce(force2);

        red.get(r).update();
        blue.get(b).update();

        red.get(r).checkedges();
        blue.get(b).checkedges();

        red.get(r).display();
        blue.get(b).display();


        ////COLLUSION OF RED PARTICLES
        //if (red.get(b).collideitself(red.get(r))) {
        //  if (r != b) {

        //    //SAVING LOCATIONS TO USE AFTE REMOVE
        //    float redlocationX = red.get(r).position.x;
        //    float redlocationY = red.get(r).position.y;


        //    //SAVING MASSES TO USE AFTE REMOVE
        //    float redwidthR = red.get(r).mass;
        //    redwidthR = constrain(redwidthR, 0, 2 );

        //    float redwidthB = red.get(r).mass;
        //    redwidthB = constrain(redwidthB, 0, 2 );

        //    red.remove(r);
        //    //red.remove(b);
        //    //red.remove(b);
        //    //red.get(b).mass = redwidthR + redwidthB;
        //    red.add(new BallRed(redwidthR + redwidthB, redlocationX, redlocationY));

        //    break;
        //  }
        //}
      }
    }
  }
  //}


  // Map vertical mouse position to volume.
  float amplitude = map(mouseY, 0, height, 0.4, 0.0);

  // Instead of setting the volume for every oscillator individually, we can just
  // control the overall output volume of the whole Sound library.
  s.volume(amplitude);


  orbit++;
  if ( orbit > 6) {
    orbit = -6;
  }
}
