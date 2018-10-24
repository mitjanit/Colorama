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
int numGradients = 1;

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
			amp = random(220, 255);
			freq = (PI/500)*(i+1);
			phase = PI/2*(k-i);
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
		
		cg.update();
		cgs.add(cg);
	}

}

void draw(){
	background(bgColor); noStroke();
	for(int i=0; i<cgs.size(); i++){
		CosineGradient cg = cgs.get(i);
		for(int v=cg.values.length-1; v>=0; v--){
			fill(cg.values[v]);
			ellipse(width/2, height/2, v*2, v*2);
		}

		cg.cpRed.phase+=0.05;
		cg.cpGreen.phase-=0.025;
		cg.cpBlue.phase-=0.0125;

		cg.update();
	}

}

void keyPressed() {
	if(key=='P' || key=='p') {
		saveFrame("output/cosineGradient-######.png");
	}
}