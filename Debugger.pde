class Debugger {

    ArrayList<String> names = new ArrayList<String>();
    ArrayList<String> content = new ArrayList<String>();

    Debugger () {
        
    }

    int add(String name, String content){
        this.names.add(name);
        this.content.add(content);
        //return index
        return this.names.size() - 1;
    }

    void set(int index, String content){
        this.content.set(index, content);
    }

    void draw(){
        pushMatrix();
            fill(255,255,255,100);
            rect(10,10,200,this.names.size() * 20);
            fill(0);
            stroke(0);
            textSize(10);
            println("this.names.get(0): "+this.names.get(0));
            for (int i = 0; i < this.names.size(); i++) {
                pushMatrix();
                // translate(0, i * 10, 0);
                text(this.names.get(i) + " : " + this.content.get(i), 0, 0);
                popMatrix();
            }
        popMatrix();
    }

}