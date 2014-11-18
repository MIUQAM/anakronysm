import processing.serial.*;


String portName = "/dev/tty.usbmodem1451";
Serial serial;
String messageFirstElement = "";
int messageSecondElement = 0;
float encodedValue = 0;
float relativeValue = 0;

void setup() {
    size(300, 300);

    // Affiche les noms des ports.
    println(Serial.list());

    serial = new Serial(this, portName, 57600);

    // Indiquer a l'instance serial de lancer la fonction serialEvent()
    // lorsque l'octet 13 est recu. L'octet 13 est envoye par
    // l'Arduino pour indiquer la fin du message
    serial.bufferUntil(13);
}

// Definir une fonction pour recevoir les donnees du port serie:
void serialEvent(Serial p) {

    // Lire le message.
    String chaine = p.readString();

    // Separer les elements du message
    // selon les espaces:
    String[] elements = splitTokens(chaine);

    // S'assurer qu'il y a bien deux mots
    // dans le message et les appliquer aux variables :
    if ( elements.length == 2 ) {
        messageFirstElement = elements[0];
        messageSecondElement = int(elements[1]);
        // On peut "router" les messages en comparant le premier Ã©lÃ©ment :
        if ( messageFirstElement.equals("Encoded") ){
            encodedValue = messageSecondElement;
            println("encodedValue : " + encodedValue);
        }

        if ( messageFirstElement.equals("Relative") ){
            relativeValue = messageSecondElement;
            println("relativeValue : " + relativeValue);
        }
    }
}

void draw() {
    
}