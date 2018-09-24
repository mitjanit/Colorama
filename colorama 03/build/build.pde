
//********************** Basic Settings ***********************//

int    sceneWidth   = 800;
int    sceneHeight  = 600;
color  bgColor    = #ECECEC;
String pathDATA = "../../data/";
String[] fileNames	= {"color_1_001.png", 	"color_1_002.png", 	"color_1_003.png"};

//********************** Color Management ***********************//
int numMinColors = 5;
int numMaxColors = 40;
int numPalettes = 40;
PaletteImage[] palettes = new PaletteImage[numPalettes];
float speed = 1;

//********************** Basic Settings ***********************//

void settings() {
	size(sceneWidth,sceneHeight,P3D);
}

void setup(){
	background(bgColor);
	createAllPalettes();
}

void draw(){
	speed = map(mouseX, 0, width, 1, 20);
	displayAllPalettes();
}


void createAllPalettes(){
	palettes = new PaletteImage[numPalettes];
	for(int i=0; i<palettes.length; i++){
		int n = (int)random(fileNames.length);
		int numColors = (int)random(numMinColors, numMaxColors);
		palettes[i] = new PaletteImage(fileNames[n]);
		float stepX = palettes[i].getImage().width/numColors;
		float startX = random(palettes[i].getImage().width);
		
		palettes[i].createSteppedPalette(numColors, startX, stepX, 1);
	}
}

void displayAllPalettes(){
	float h = height/numPalettes;
	for(int i=0; i<palettes.length; i++){
		palettes[i].updatePalette(speed);
		palettes[i].displayAt(0, i*h, sceneWidth, h);
	}
}

void mousePressed(){
	createAllPalettes();
}

void keyPressed(){
	if(key=='p'){
		saveFrame("frame/colorama03-######.png");
	}
}