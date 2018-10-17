
//********************** Basic Settings ***********************//

int    sceneWidth   = 1920;
int    sceneHeight  = 1000;
color  bgColor    = #ECECEC;
String pathDATA = "../../data/";
String[] fileNames	= {"color_map_001.png"};

//********************** Color Management ***********************//

color red 	= color(255, 0, 0);
color green = color(0, 255, 0);
color blue 	= color(0, 0, 255);

float graphH = 400;
float graphW = 1600;
float graphMarginTop = 50;
float graphMarginLeft = 100;
float gradientH = 80;
float gradientW = graphW;


PVector graphOrigin 	= new PVector(graphMarginLeft, graphH + graphMarginTop);
PVector redOrigin 		= new PVector(graphMarginLeft, graphH + graphMarginTop + 20);
PVector greenOrigin 	= new PVector(graphMarginLeft, graphH + graphMarginTop + gradientH + 20*2);
PVector blueOrigin 		= new PVector(graphMarginLeft, graphH + graphMarginTop + 2*gradientH + 20*3);
PVector gradientOrigin 	= new PVector(graphMarginLeft, graphH + graphMarginTop + 3*gradientH + 20*4);

float xgLabel = graphOrigin.x + graphW;

CosineGradient cg;

CosineComp cpRed, cpGreen, cpBlue;
color[] colors;

//********************** Keyboard Interaction ******************//

boolean updatable = true;
boolean enableRed = false, enableGreen = false, enableBlue = false, enableGlobal = false;

//********************** Basic Settings ***********************//

void settings() {
	size(sceneWidth,sceneHeight,P3D);
}

void setup(){
	background(bgColor);
	smooth();
	//cg = new CosineGradient(100);
	//colors = cg.getGradient();
	cpRed = new CosineComp(300, 0.6, 255, HALF_PI/5, 0.0);
	cpRed.setRed();
	cpRed.calculate();

	cpGreen = new CosineComp(300, 0, 255, 0.03, 0.1);
	cpGreen.setGreen();
	cpGreen.calculate();

	cpBlue = new CosineComp(300, 0, 255, 0.023, 0.5);
	cpBlue.setBlue();
	cpBlue.calculate();
}

void draw(){
	
	float freq = map(mouseX, 0, width, 0, PI/20);
	//float phase = map(mouseY, 0, height, 0, TWO_PI);
	//float offset = map(mouseY, 0, height, -2*cpRed.amp, 2*cpRed.amp);
	if(changedFreq(freq) || updatable){
		updatable = false;

		background(bgColor);
		setFreq(freq);
		//setOffset(offset);

		cpRed.calculate();
		cpRed.displayGraph(graphOrigin, graphW, graphH, red, true);
		cpRed.displayGradient(redOrigin, gradientW, gradientH);
		cpRed.displayInfo(new PVector(xgLabel, 1.5*graphMarginTop), "RED");

		cpGreen.calculate();
		cpGreen.displayGraph(graphOrigin, graphW, graphH, green, false);
		cpGreen.displayGradient(greenOrigin, gradientW, gradientH);
		cpGreen.displayInfo(new PVector(xgLabel, 1.5*graphMarginTop + graphH/3), "GREEN");
		
		cpBlue.calculate();
		cpBlue.displayGraph(graphOrigin, graphW, graphH, blue, false);
		cpBlue.displayGradient(blueOrigin, graphW, gradientH);
		cpBlue.displayInfo(new PVector(xgLabel, 1.5*graphMarginTop + 2*graphH/3), "BLUE");

	}

	

	displayGradient(gradientOrigin, gradientW, 2*gradientH, cpRed, cpGreen, cpBlue);
}



void displayGradient(PVector orig, float w, float h, CosineComp r, CosineComp g, CosineComp b){
		
		float n = r.n;
		float wp = w/(float)n;

		noStroke();
		for(int i=0; i<n; i++){
			float redValue = r.values[i];
			float greenValue = g.values[i];
			float blueValue = b.values[i];
			fill(redValue,greenValue, blueValue);
			rect(orig.x + i*wp, orig.y, wp, h);
		}
	}


void keyPressed(){
	if(key=='R' || key=='r'){
		disableAll();
		enableRed = true;
	}
	else if(key=='G' || key=='g'){
		disableAll();
		enableGreen = true;
	}
	else if(key=='A' || key=='a'){
		disableAll();
		enableGlobal = true;
	}
	else if(key=='B' || key=='b'){
		disableAll();
		enableBlue = true;
	}
	else if(key=='N' || key=='n'){
		disableAll();
	}
	else if(key==CODED && keyCode==LEFT){
		changePhase(-10);
	}
	else if(key==CODED && keyCode==RIGHT){
		changePhase(10);
	}
	else if(key==CODED && keyCode==DOWN){
		changeOffset(-10);
	}
	else if(key==CODED && keyCode==UP){
		changeOffset(10);
	}
}

void disableAll(){
	enableRed 		= false;
	enableGreen 	= false;
	enableBlue 		= false;
	enableGlobal 	= false;
}


boolean changedFreq(float f){
	if(enableRed){
		return cpRed.freq!=f;
	}
	else if(enableGreen){
		return cpGreen.freq != f;
	}
	else if(enableBlue){
		return cpBlue.freq != f;
	}
	return false;
}

boolean changedOffset(float f){
	if(enableRed){
		return cpRed.offset!=f;
	}
	else if(enableGreen){
		return cpGreen.offset != f;
	}
	else if(enableBlue){
		return cpBlue.offset != f;
	}
	return false;
}

void setFreq(float value){
	if(enableRed){
		cpRed.freq = value;
	}
	else if(enableGreen){
		cpGreen.freq = value;
	}
	else if(enableBlue){
		cpBlue.freq = value;
	}
	updatable = true;
}

void setPhase(float value){
	if(enableRed){
		cpRed.phase = value;
	}
	else if(enableGreen){
		cpGreen.phase = value;
	}
	else if(enableBlue){
		cpBlue.phase = value;
	}
	updatable = true;
}

void setOffset(float value){
	if(enableRed){
		cpRed.offset = value;
	}
	else if(enableGreen){
		cpGreen.offset = value;
	}
	else if(enableBlue){
		cpBlue.offset = value;
	}
	updatable = true;
}

void changePhase(float value){
	if(enableRed){
		cpRed.phase += value;
	}
	else if(enableGreen){
		cpGreen.phase += value;
	}
	else if(enableBlue){
		cpBlue.phase += value;
	}
	updatable = true;
}

void changeFreq(float value){
	if(enableRed){
		cpRed.freq += value;
	}
	else if(enableGreen){
		cpGreen.freq += value;
	}
	else if(enableBlue){
		cpBlue.freq += value;
	}
	updatable = true;
}

void changeOffset(float value){
	if(enableRed){
		cpRed.offset += value;
	}
	else if(enableGreen){
		cpGreen.offset += value;
	}
	else if(enableBlue){
		cpBlue.offset += value;
	}
	updatable = true;
}


void mousePressed(){

}