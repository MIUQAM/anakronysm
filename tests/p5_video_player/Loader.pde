//Loader class thanks to jmcouillard.com

public class Loader extends Thread {

    private PApplet p;
    private ConcurrentHashMap<Integer, PImage> imgs;
    private int threshold;
    private int framesTotal;

    private boolean stop = false;
    private int currentFrame = 0;
    private int updateDelay = 20;
    private float health = 0;
    private float loops = 0;

    private String source;

    public Loader(PApplet p, ConcurrentHashMap<Integer, PImage> imgs, int threshold, int framesTotal, String source) {
        this.p = p;
        this.imgs = imgs;
        this.threshold = threshold;
        this.framesTotal = framesTotal;
        this.source = source;
    }

    public void run() {
        // println("stop: "+stop);

        while (!stop) {
            //println("stop: "+stop);

            int found = 0;

            // Chargement des images de papillon
            for (int i=0; i<threshold; i++) {
                int frame = (i + currentFrame - (threshold/2)) % framesTotal;
                if (frame <0) frame = framesTotal + frame;
                if (!imgs.containsKey(frame)) {
                    String src = source+fixedDigits(frame+1)+".jpg";
                    imgs.put(frame, p.loadImage(src));
                    // println("src: "+src);

                    //System.out.println("Loaded " + frame);
                } else {
                    found++;
                    //System.out.println("Already exists " + frame);
                }
            }
            //println("Images loaded : " + imgs.size());

            health = (float)found / threshold;

            loops++;

            if(loops >= 50){
                clean();
                loops = 0;
            }

            // Sleep
            try {
                sleep(updateDelay);
            } 
            catch (InterruptedException e) {
            }
        }
    }

    public void clean() {

        for (Integer key : imgs.keySet ()) {
            if (key < currentFrame - threshold) {

                PImage img = imgs.get(key);
                img = null;
                imgs.remove(key);
                // System.out.println("Key " + key + " needs to be disposed");
            }
        }
    }

    public void setFrame(int frame) {
        this.currentFrame = frame;
    }

    public boolean ready() {
        return imgs.size() > threshold/2;
    }
    
    public float getHealth() {
        return health;
    }

    public void setUpdateDelay(int val) {
        updateDelay = val;
    }

    // public String fixedDigits(int value) { 
    //     if (value < 10) {
    //         return "0000" + value;
    //     } else  if (value < 100) {
    //         return "000" + value;
    //     } else  if (value < 1000) {
    //         return "00" + value;
    //     } else  if (value < 10000) {
    //         return "0" + value;
    //     } else {
    //         return Integer.toString(value);
    //     }
    // }

    public String fixedDigits(int value) { 
        if (value < 10) {
            return "000" + value;
        } else  if (value < 100) {
            return "00" + value;
        } else  if (value < 1000) {
            return "0" + value;
        } else  if (value < 10000) {
            return "" + value;
        } else {
            return Integer.toString(value);
        }
    }
}