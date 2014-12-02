class P5toMSPBridge {

    OscP5 oscP5;
    NetAddress remote;

    public P5toMSPBridge(String adress, int port) {
        this.oscP5 = new OscP5(this,port);
        
        this.remote = new NetAddress(adress,port);
    }

    public OscMessage send(String header, String msg){
        OscMessage oscMessage = new OscMessage("/" + header);
        oscMessage.add(msg);
        this.oscP5.send(oscMessage, this.remote);
        return oscMessage;
    }

    public OscMessage send(String header, int msg){
        OscMessage oscMessage = new OscMessage("/" + header);
        oscMessage.add(msg);
        this.oscP5.send(oscMessage, this.remote);
        return oscMessage;
    }

    public OscMessage send(String header, float msg){
        OscMessage oscMessage = new OscMessage("/" + header);
        oscMessage.add(msg);
        this.oscP5.send(oscMessage, this.remote);
        return oscMessage;
    }
}