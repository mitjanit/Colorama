
//********************** Basic Settings ***********************//

int    sceneWidth   = 1920;
int    sceneHeight  = 1080;
color  bgColor    = #ECECEC;
String pathDATA = "../../data/";

//********************** Color Management ***********************//
ColorImage colImage;

//********************** Basic Settings ***********************//

void settings() {
	size(sceneWidth,sceneHeight,P3D);
}

void setup(){
	background(bgColor);

	colImage = new ColorImage(5, )
}

void draw(){

	image(colImage.getImage(), 0, 0);

}