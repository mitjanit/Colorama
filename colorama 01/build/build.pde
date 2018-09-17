
//********************** Basic Settings ***********************//

int    sceneWidth   = 1920;
int    sceneHeight  = 1080;
color  bgColor    = #ECECEC;
String pathDATA = "../../data/";


//********************** Basic Settings ***********************//

void settings() {
	size(sceneWidth,sceneHeight,P3D);
}

void setup(){
	background(bgColor);
}