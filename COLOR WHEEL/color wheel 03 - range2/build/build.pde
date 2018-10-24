
//********************** Basic Settings ***********************//

int    sceneWidth   = 1920;
int    sceneHeight  = 1000;
color  bgColor    = #ECECEC;
String pathDATA = "../../data/";

//********************** Color Management ***********************//
int numColors = 12;
int selSector = -1;

ColorWheel cw;
//********************** Basic Settings ***********************//

void settings() {
	size(sceneWidth,sceneHeight,P3D);
}

void setup(){
	background(bgColor);
	colorMode(HSB, 360, 100, 100);
	smooth();

	cw = new ColorWheel(numColors, 200, 80);
	cw.setColors();
}

void draw(){
	background(bgColor);
	cw.display(new PVector(width/2, height/2), 800);
	//cw.displaySelColors(new PVector(100,100), 50);
	//cw.highlightColors();
	fill(200,100,100);
	rect(1800, 50, 50, 50);
	fill(80, 100, 100);
	rect(1800, 100, 50, 50);
}


void keyPressed(){
	if(key=='p'){
		saveFrame("frame/colorwheel01-######.png");
	}
	else if(key=='n'){
		cw.selectRandomColors(3);
	}
	else if(key=='d'){
		cw.selectDistantColors(5);
	}
	else if(key=='c'){
		cw.selectCompColors();
	}
	else if(key=='x'){
		cw.deSelectColors();
	}
}

void mousePressed(){
	color ct = color(random(cw.hueStart, cw.hueEnd), 100, 100);
	Color c = new Color(ct);
	cw.addSelectedColor(ct);
}