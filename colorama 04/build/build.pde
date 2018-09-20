
//********************** Basic Settings ***********************//

int    sceneWidth   = 1600;
int    sceneHeight  = 1000;
color  bgColor    = #ECECEC;
String pathDATA = "../../data/";
String[] fileNames	= {"color_map_001.png"};

//********************** Color Management ***********************//
int numColors = 5;
int numPalettes = 1;
PaletteImage[] palettes = new PaletteImage[numPalettes];
float speedX = 5, speedY= 5;

//********************** Basic Settings ***********************//

void settings() {
	size(sceneWidth,sceneHeight,P3D);
}

void setup(){
	background(bgColor);
	createAllPalettes();
}

void draw(){
	speedX = map(mouseX, 0, width, 1, 20);
	speedY = map(mouseY, 0, height, 1, 20);
	displayAllPalettes();
}


void createAllPalettes(){
	palettes = new PaletteImage[numPalettes];
	for(int i=0; i<palettes.length; i++){
		int n = 0; //(int)random(fileNames.length);
		palettes[i] = new PaletteImage(fileNames[n]);
		float stepX = palettes[i].getImage().width/numColors;
		float startX = 0; //stepX*i;
		float startY = palettes[i].getImage().height/2;
		palettes[i].createSteppedPalette(numColors, startX, startY, stepX, 1);
	}
}

void displayAllPalettes(){
	palettes[0].displayImageAt(0, 0, sceneWidth, sceneHeight/2);
	float h = (sceneHeight/2) / palettes.length;
	for(int i=0; i<palettes.length; i++){
		palettes[i].updatePalette(speedX, speedY);
		palettes[i].displayAt(0, sceneHeight/2 + h*i, sceneWidth, h);
		palettes[i].displayPointers();
	}
}

void mousePressed(){
	createAllPalettes();
}