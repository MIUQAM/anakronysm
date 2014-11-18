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
    sendMessage("hey", "ho");
}

void sendMessage(String header, String msg){
    bridge.send(header, msg);
}