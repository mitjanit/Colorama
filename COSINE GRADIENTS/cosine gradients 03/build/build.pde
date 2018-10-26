//*************************************************************//
//		COSINE GRADIENTS
//
//********************** Basic Settings ***********************//

int    sceneWidth   = 1920;
int    sceneHeight  = 1080;
color  bgColor    = #ECECEC;
String pathDATA = "../../../data/";

//********************** Color Management ***********************//

int num = 500;
ArrayList<CosineGradient> cgs;
int numGradients = 14;

//********************** Basic Settings ***********************//

void settings() {
	size(sceneWidth,sceneHeight,P3D);
}

void setup(){
	background(bgColor);
	smooth(8);
	
	cgs = new ArrayList<CosineGradient>();
	for(int i=0; i<numGradients; i++){
		CosineGradient cg = new CosineGradient(num);
		float offset=0, amp=0, freq=0, phase=0;

		for(int k=0; k<3; k++){
			offset = random(-50, 50);
			amp = random(200, 255);
			freq = random(PI/500, PI/1500); //(PI/1500)*(i+1);
			phase = random(PI/2, PI/10); //*(k-i);
			if(k==0){
				cg.setRed(new CosineComp(num, offset, amp, freq, phase));
			}
			else if(k==1){
				cg.setGreen(new CosineComp(num, offset, amp, freq, phase));
			}
			else {
				cg.setBlue(new CosineComp(num, offset, amp, freq, phase));
			}
			

		}
		/*
		cg.setRed(new CosineComp(num, offset, amp, freq, phase));
		cg.setGreen(new CosineComp(num, offset, amp, freq, phase));
		cg.setBlue(new CosineComp(num, offset, amp, freq, phase));*/
		
		cg.update();
		cgs.add(cg);
	}

}

void draw(){
	background(bgColor);
	for(int i=0; i<cgs.size(); i++){
		CosineGradient cg = cgs.get(i);
		float w = width;
		float h = height / (float)cgs.size();
		PVector orig = new PVector(0, h*i);
		PVector orig2 = new PVector(w/2, h*i);
		cg.displayGradient(orig, w, h);
		//cg.displayGradientInv(orig2, w/2, h);
		//cg.displayGradientCurve(orig, w, h);

		cg.cpRed.phase+=0.05;
		//cg.cpGreen.phase-=0.025;
		//cg.cpBlue.phase-=0.0125;

		cg.update();
	}

}

void keyPressed() {
	if(key=='P' || key=='p') {
		saveFrame("output/cosineGradient-######.png");
	}
}