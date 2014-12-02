// Based on: 
// http://www.learningprocessing.com
// Example 10-5: Object-oriented timer

// Author : Marc-Antoine Brodeur
// Method isStarted + variable started + method Time
// How to use:
// TimeoutP5 myTimer = new TimeoutP5(500);      500 is the timing in milliseconds
// You can also initialize the timer with a second parameter TimeoutP5 myTimer = new TimeoutP5(500, true); which fill make the timer loop indefinitely until you stop it with the stop() method.
// To start de timer : myTimer.start();
// To check if timer is finished : if(myTimer.isFinished()) { /* Your actions here */ }
// myTimer.isStarted() can be useful to check if the timer is already running so you don't start it again before it ends.
// myTimer.getTime() returns the time in milliseconds from when it started and the current time if the timer is running.

class TimeoutP5 {
 
  int savedTime; // When TimeoutP5 started
  int totalTime; // How long TimeoutP5 should last
  boolean started = false;
  boolean finished = false;
  boolean looped = false;
  boolean paused = false;
  boolean stopped = true;
  
  TimeoutP5(int totalTime) {
    this.totalTime = totalTime;
  }

  TimeoutP5(int totalTime, boolean looped) {
    this.totalTime = totalTime;
    this.looped = looped;
  }
  
  // Starting the timer
  void start() {
    if(!this.started){
      // When the timer starts it stores the current time in milliseconds.
      if(this.paused){
        this.savedTime = millis() - this.savedTime;
      } else {
        this.savedTime = millis();
      }

      this.started = true;
      this.finished = false;
      this.paused = false;
      this.stopped = false;
    }
  }
  
  void stop(){
    if(!this.stopped){
      this.started = false;
      this.finished = true;
      this.paused = false;
      this.stopped = true;
    }
  }
  
  void pause(){
    if(!this.paused){
      this.started = false;
      this.finished = false;
      this.paused = true;
      this.stopped = false;

      this.savedTime = millis() - this.savedTime;
    }
  }

  // The function isFinished() returns true if totalTime has passed. 
  // The work of the timer is farmed out to this method.
  boolean isFinished() { 
    // Check how much time has passed
    int passedTime = millis() - this.savedTime;
    if(!this.finished){
    
      if (passedTime > this.totalTime && this.started) {
        this.stop();

        if(looped){
          this.start();
          return true;
        }

      } else {
        this.finished = false;
      }

    }

    return this.finished;
  }

  // The function isStarted() returns true if the timer started.
  boolean isStarted() { 
    return this.started;
  }

  // The function getTime() returns the time in milliseconds from when it started and the current time if the timer is running.
  int getTime() {
    if(this.started && !this.finished)
      return millis() - this.savedTime;
    else
      return 0;
  }

  // The function getNormalizedTime() returns the time from when it started and the current time if the timer is running, normalized in values from 0 to 1
  float getNormalizedTime() {
    return norm(this.getTime(), 0, this.totalTime);
  }
}