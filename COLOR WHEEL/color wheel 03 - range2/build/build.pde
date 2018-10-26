
//********************** Basic Settings ***********************//

int    sceneWidth   = 1920;
int    sceneHeight  = 1000;
color  bgColor    = #ECECEC;
String pathDATA = "../../data/";

//********************** Color Management ***********************//
int numColors = 64;
int selSector = -1;

ColorWheel cw;
float hue1 = 90;
float hue2 = 270;
//********************** Basic Settings ***********************//

void settings() {
	size(sceneWidth,sceneHeight,P3D);
}

void setup(){
	background(bgColor);
	colorMode(HSB, 360, 100, 100);
	smooth();

	cw = new ColorWheel(numColors, hue1, hue2);
	cw.setColors();
}

void draw(){
	background(bgColor);
	cw.display(new PVector(width/2, height/2), 800);
	cw.displaySelColors(new PVector(100,100), 50);
	cw.highlightColors();
	
	fill(hue1,100,100);
	rect(1800, 50, 50, 50);
	fill(hue2, 100, 100);
	rect(1800, 100, 50, 50);


}


void keyPressed(){
	if(key=='p'){
		saveFrame("frame/colorwheel01-######.png");
	}
	else if(key=='n'){
		cw.selectRandomColors(6);
	}
	else if(key=='d'){
		cw.selectDistantColors(6);
	}
	else if(key=='c'){
		cw.selectCompColors();
	}
	else if(key=='a'){
		color ct = color(random(cw.hueStart, cw.hueEnd), 100, 100);
		cw.selectAnalogColors(ct, 5);
	}
	else if(key=='x'){
		cw.deSelectColors();
	}
	else if(key=='z'){
		cw.displaceColors(map(mouseX, 0, width, 0, 100));
	}
}

void mousePressed(){
	color ct = color(random(cw.hueStart, cw.hueEnd), 100, 100);
	Color c = new Color(ct);
	cw.addSelectedColor(ct);
}