
//********************** Basic Settings ***********************//

int    sceneWidth   = 1920;
int    sceneHeight  = 1000;
color  bgColor    = #ECECEC;
String pathDATA = "../../data/";

//********************** Color Management ***********************//
int numColors = 36;
int numBrights = 18;
int selSector = -1;

ColorGrid cg;
float hue1 = 0;
float hue2 = 270;
float bri1 = 50;
float bri2 = 255;
//********************** Basic Settings ***********************//

void settings() {
	size(sceneWidth,sceneHeight,P3D);
}

void setup(){
	background(bgColor);
	colorMode(HSB, 360, 100, 255);
	smooth();

	cg = new ColorGrid(numColors, numBrights, hue1, hue2, bri1, bri2);
	cg.setColors();
}

void draw(){
	background(bgColor);
	cg.display(new PVector(20, 20), width-40, height-240);
	cg.displaySelColors(new PVector(50, 850), 40);
	cg.highlightColors(new PVector(20, 20), width-40, height-240);
}


void keyPressed(){
	if(key=='p'){
		saveFrame("frame/colorwheel01-######.png");
	}
	else if(key=='n'){
		cg.selectRandomColors(6);
	}
	else if(key=='d'){
		cg.selectDistantColors(6);
	}
	else if(key=='c'){
		cg.selectCompColors();
	}
	else if(key=='a'){
		color ct = color(random(cg.hueStart, cg.hueEnd), 100, 100);
		cg.selectAnalogColors(ct, 5);
	}
	else if(key=='x'){
		cg.deSelectColors();
	}
	else if(key=='z'){
		cg.displaceColors(map(mouseX, 0, width, 0, 100));
	}
}

void mousePressed(){
	color ct = color(random(cg.hueStart, cg.hueEnd), 100, 100);
	Color c = new Color(ct);
	cg.addSelectedColor(ct);
}