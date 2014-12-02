/**
* Project : ProcessingToMax 
* Author : Erwan
* Version : 1.0.0
* Date : 18-11-2014
* Quick class for Processing to Max MSP communication via OSC
*/

P5toMSPBridge bridge = new P5toMSPBridge("127.0.0.1", 5001);

void setup() {
    size(960, 540);
    
}

void draw() {
    background(0);
    //println(bridge.send("float", 10.1));
    println(bridge.send("int", 50));
    //println(bridge.send("string", "Hello motherfucker"));
}