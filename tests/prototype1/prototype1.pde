/**
* Project : anakronysm
* Author : marcantoinebrodeur, th3m4rio, Adaav, pierrelucgithub
* Version : 1.0.0
* Date : 14-11-2014
* Prototype 1
*/




/*

Movie

Example 

  import processing.video.*;
  Movie myMovie;

  void setup() {
    size(200, 200);
    myMovie = new Movie(this, "totoro.mov");
    myMovie.loop();
  }

  void draw() {
    tint(255, 20);
    image(myMovie, mouseX, mouseY);
  }

  // Called every time a new frame is available to read
  void movieEvent(Movie m) {
    m.read();
  }
  


frameRate() Sets the target frame rate
speed() Sets the relative playback speed
duration()  Returns length of movie in seconds
time()  Returns location of playback head in units of seconds
jump()  Jumps to a specific location
available() Returns "true" when a new movie frame is available to read.
play()  Plays movie one time and stops at the last frame
loop()  Plays a movie continuously, restarting it when it's over.
noLoop()  Stops the movie from looping
pause() Pauses the movie
stop()  Stops the movie
read()  Reads the current frame

*/

import processing.video.*;
Movie myMovie;

void setup() {
  size(640, 480);
  myMovie = new Movie(this, "skeleton_dance_1929.mp4");
  myMovie.loop();
}

void draw() {
  tint(255, 20);
  image(myMovie, mouseX, mouseY);
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}
