//*************************************************************//
//		COSINE GRADIENTS
//
//********************** Basic Settings ***********************//

int    sceneWidth   = 1920;
int    sceneHeight  = 1000;
color  bgColor    = #ECECEC;
String pathDATA = "../../../data/";

//********************** Color Management ***********************//

int num = 300;
CosineGradient cg;
CosineComp cpRed, cpGreen, cpBlue;


//********************** Keyboard Interaction ******************//

float amountPhase = 0.1;
float amountOffset = 1;
float amountFreq = 0.001;
float amountAmp = 1;
boolean updatable = true;
boolean enableRed = false, enableGreen = false, enableBlue = false, enableGlobal = false;

//********************** Basic Settings ***********************//

void settings() {
	size(sceneWidth,sceneHeight,P3D);
}

void setup(){
	background(bgColor);
	smooth();
	
	cg = new CosineGradient(num);
	cg.setRed(new CosineComp(num, 0.0, 255, PI/100, 0.05));
	cg.setGreen(new CosineComp(num, 0.6, 255, PI/200, 0.012));
	//cg.setBlue(new CosineComp(num, 0.2, 255, PI/5, 0.04));
	cg.update();

}

void draw(){
	background(bgColor);
	cg.display();

	if(updatable){
		cg.update();
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
	else if(key=='O' || key=='o'){
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
	else if(key=='A' || key=='a'){
		changeAmp(-amountAmp);
	}
	else if(key=='S' || key=='s'){
		changeAmp(amountAmp);
	}
	else if(key=='W' || key=='w'){
		println("CHANGING FREQ");
		changeFreq(amountFreq);
	}
	else if(key=='Z' || key=='z'){
		changeFreq(-amountFreq);
	}
	else if(key==CODED && keyCode==LEFT){
		changePhase(-amountPhase);
	}
	else if(key==CODED && keyCode==RIGHT){
		changePhase(amountPhase);
	}
	else if(key==CODED && keyCode==DOWN){
		changeOffset(-amountOffset);
	}
	else if(key==CODED && keyCode==UP){
		changeOffset(amountOffset);
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
		return cg.cpRed.offset!=f;
	}
	else if(enableGreen){
		return cg.cpGreen.offset != f;
	}
	else if(enableBlue){
		return cg.cpBlue.offset != f;
	}
	return false;
}

void setFreq(float value){
	if(enableRed){
		cg.cpRed.freq = value;
	}
	else if(enableGreen){
		cg.cpGreen.freq = value;
	}
	else if(enableBlue){
		cg.cpBlue.freq = value;
	}
	updatable = true;
}

void setPhase(float value){
	if(enableRed){
		cg.cpRed.phase = value;
	}
	else if(enableGreen){
		cg.cpGreen.phase = value;
	}
	else if(enableBlue){
		cg.cpBlue.phase = value;
	}
	updatable = true;
}

void setOffset(float value){
	if(enableRed){
		cg.cpRed.offset = value;
	}
	else if(enableGreen){
		cg.cpGreen.offset = value;
	}
	else if(enableBlue){
		cg.cpBlue.offset = value;
	}
	updatable = true;
}

void changePhase(float value){
	if(enableRed){
		cg.cpRed.phase += value;
	}
	else if(enableGreen){
		cg.cpGreen.phase += value;
	}
	else if(enableBlue){
		cg.cpBlue.phase += value;
	}
	updatable = true;
}

void changeFreq(float value){
	if(enableRed){
		cg.cpRed.freq += value;
	}
	else if(enableGreen){
		cg.cpGreen.freq += value;
	}
	else if(enableBlue){
		cg.cpBlue.freq += value;
	}
	updatable = true;
}

void changeOffset(float value){
	if(enableRed){
		cg.cpRed.offset += value;
	}
	else if(enableGreen){
		cg.cpGreen.offset += value;
	}
	else if(enableBlue){
		cg.cpBlue.offset += value;
	}
	updatable = true;
}

void changeAmp(float value){
	if(enableRed){
		cg.cpRed.amp += value;
	}
	else if(enableGreen){
		cg.cpGreen.amp += value;
	}
	else if(enableBlue){
		cg.cpBlue.amp += value;
	}
	updatable = true;
}


void mousePressed(){

}