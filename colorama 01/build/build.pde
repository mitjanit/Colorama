//*************************************************************//
// Paleta de colors basada en una imatge gradient.
// Els colors es trien aleatòriament al llarg de la coordenada X de la imatge.
// Els colors flueixen en moure's la seva coordenada X sobre la imatge.
//
//********************** Basic Settings ***********************//

int    sceneWidth   = 800;
int    sceneHeight  = 600;
color  bgColor    = #ECECEC;
String pathDATA = "../../data/";

String[] fileNames	= {"color_1_001.png", 	"color_1_002.png", 	"color_1_003.png"};

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
	createAllPalettes(fileNames[0]);
}

void draw(){
	displayAllPalettes();
}


void createAllPalettes(String fileName){
	palettes = new PaletteImage[numPalettes];
	for(int i=0; i<palettes.length; i++){
		palettes[i] = new PaletteImage(fileName);
		float stepX = palettes[i].getImage().width/numColors;
		float startX = stepX*i;
		palettes[i].createRandomPalette(numColors);
	}
}

void displayAllPalettes(){
	float h = (height - palettes[0].getImage().height)/numPalettes;
	for(int i=0; i<palettes.length; i++){
		palettes[i].updatePalette(10);
		palettes[i].displayImageAt(0, 0, sceneWidth, palettes[i].getImage().height);
		palettes[i].displayAt(0, palettes[i].getImage().height + i*h, sceneWidth, h);
	}
}

void keyPressed(){
	if(key=='0'){
		createAllPalettes(fileNames[0]);
	}
	else if(key=='1'){
		createAllPalettes(fileNames[1]);
	}
	else if(key=='2'){
		createAllPalettes(fileNames[2]);
	}
	else if(key=='p'){
		saveFrame("frame/colorama01-######.png");
	}
}