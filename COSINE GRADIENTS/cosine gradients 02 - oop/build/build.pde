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

//********************** Basic Settings ***********************//

void settings() {
	size(sceneWidth,sceneHeight,P3D);
}

void setup(){
	background(bgColor);
	smooth(8);
	
	cg = new CosineGradient(num);
	cg.setRed(new CosineComp(num, 0.0, 127, PI/100.0, 0.00));
	cg.setGreen(new CosineComp(num, 0.6, 255, PI/200, 0.012));
	cg.setBlue(new CosineComp(num, 0.2, 155, PI/50, 0.04));
	cg.update();

}

void draw(){
	background(bgColor);
	cg.display();
	if(cg.updatable){
		cg.update();
	}
}



void keyPressed(){
	if(key=='R' || key=='r'){
		cg.enableRed();
	}
	else if(key=='G' || key=='g'){
		cg.enableGreen();
	}
	else if(key=='O' || key=='o'){
		cg.enableGlobal();
	}
	else if(key=='B' || key=='b'){
		cg.enableBlue();
	}
	else if(key=='N' || key=='n'){
		cg.disableAll();
	}
	else if(key=='A' || key=='a'){
		cg.changeAmp(-cg.amountAmp);
	}
	else if(key=='S' || key=='s'){
		cg.changeAmp(cg.amountAmp);
	}
	else if(key=='W' || key=='w'){
		cg.changeFreq(cg.amountFreq);
	}
	else if(key=='Z' || key=='z'){
		cg.changeFreq(-cg.amountFreq);
	}
	else if(key==CODED && keyCode==LEFT){
		cg.changePhase(-cg.amountPhase);
	}
	else if(key==CODED && keyCode==RIGHT){
		cg.changePhase(cg.amountPhase);
	}
	else if(key==CODED && keyCode==DOWN){
		cg.changeOffset(-cg.amountOffset);
	}
	else if(key==CODED && keyCode==UP){
		cg.changeOffset(cg.amountOffset);
	}
}




void mousePressed(){

}