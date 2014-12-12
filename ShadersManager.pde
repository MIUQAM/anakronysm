class ShadersManager {

    ArrayList<String> shaders;
    ArrayList<String> usedShaders;
    int currentShader = 0;


    public ShadersManager (){
        this.shaders = new ArrayList<String>();
        this.usedShaders = new ArrayList<String>();
    }

    public void add(String shaderName){
        this.shaders.add(shaderName);
    }

    public void switchShader(){
        if(this.usedShaders.size() == this.shaders.size()){
            this.usedShaders.clear();
        }

        boolean found = false;

        int randomIndex = 0;

        while(!found){
            randomIndex = int(floor(random(0, this.shaders.size())));

            if(!this.usedShaders.contains(this.shaders.get(randomIndex))) {
                this.usedShaders.add(this.shaders.get(randomIndex));
                found = true;
            }
        }



        randomIndex = 6;



        this.currentShader = randomIndex;
    }

    private String getCurrentShader(){
        return this.shaders.get(this.currentShader);
    }

}