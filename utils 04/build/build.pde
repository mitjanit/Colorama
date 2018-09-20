
//********************** Basic Settings ***********************//

int    sceneWidth   = 1600;
int    sceneHeight  = 500;
color  bgColor    = #ECECEC;
String pathDATA = "../../data/";

// ********************************************************************************************************************

String[] fileNames = {"color_1_001.png", 	"color_1_002.png",	"color_1_003.png"};
int current = 0;
PImage img;

// ********************************************************************************************************************

void settings() {
	size(sceneWidth,sceneHeight,P3D);
}

void setup(){
	img = loadImage(pathDATA + fileNames[current]);
}

void draw(){
	background(bgColor);
	strokeWeight(0);
	noStroke();

	// tint up to white

	for (int i = 0; i < 255; ++i) {
		image(img, 0, i, width, 1);
		fill(255, 255-i);
		rect(0, i, width, 1);
	}

	// tint down to black

	for (int i = 0; i < 255; ++i) {
		tint(255-i);
		image(img, 0, 255+i, width, 1);
	}

	noTint();

}

void keyPressed() {
	switch (key) {
		case 'p' : saveFrame("output/" + fileNames[current]); break;
	}
}

void mousePressed(){
	current++;
	if(current>=fileNames.length){
		current=0;
	}
	img = loadImage(pathDATA + fileNames[current]);
}


