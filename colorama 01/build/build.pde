
//********************** Basic Settings ***********************//

int    sceneWidth   = 800;
int    sceneHeight  = 600;
color  bgColor    = #ECECEC;
String pathDATA = "../../data/";

//********************** Color Management ***********************//
int numColors = 30;
int numPalettes = 20;
PaletteImage[] palettes = new PaletteImage[numPalettes];

//********************** Basic Settings ***********************//

void settings() {
	size(sceneWidth,sceneHeight,P3D);
}

void setup(){

	background(bgColor);
	for(int i=0; i<palettes.length; i++){
		palettes[i] = new PaletteImage("color_1_003.png");
		float stepX = palettes[i].getImage().width/numColors;
		//float startX = random(palettes[i].getImage().width);
		float startX = stepX*i;
		//palettes[i].createSteppedPalette(numColors, startX, stepX, 1);
		palettes[i].createRandomPalette(numColors);
	}
}

void draw(){

	float h = (height - palettes[0].getImage().height)/numPalettes;
	for(int i=0; i<palettes.length; i++){
		palettes[i].updatePalette(10);
		palettes[i].displayImageAt(0, 0, sceneWidth, palettes[i].getImage().height);
		palettes[i].displayAt(0, palettes[i].getImage().height + i*h, sceneWidth, h);
	}
}

void mousePressed(){
	//colImage.createRandomPalette(10);
	//colImage.updatePalette(5);
}