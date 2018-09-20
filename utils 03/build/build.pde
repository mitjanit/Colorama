
//********************** Basic Settings ***********************//

int    sceneWidth   = 1600;
int    sceneHeight  = 800;
color  bgColor    = #ECECEC;

String[] fileNames	= {"sea01.jpg", 	"forest01.jpg", 	"rainbow01.jpg"};
String pathDATA = "../../data/";
int current = 0;
PImage img; 


ColorThief t; 
int numColors = 10;
int quality = 5;
boolean ignoreWhite = false;
int[][] palette;

//********************** Basic Settings ***********************//

void settings() {
	size(sceneWidth,sceneHeight,P2D);
}

void setup(){

  background(bgColor);

  displayImageAt(fileNames[current], 0, 0, width/2, height);

  t = new ColorThief(); 
  palette = t.getPalette((BufferedImage) img.getImage(), numColors, quality, ignoreWhite);

  displayPaletteAt(palette, width/2, 0, width/2, height);

}

void draw() {
	displayImageAt(fileNames[current], 0, 0, width/2, height);
	displayPaletteAt(palette, width/2, 0, width/2, height);
}

void displayImageAt(String fileName, float x, float y, float w, float h){
  img = loadImage(pathDATA + fileName);
  image(img, x, y, w, h);
}

void displayPaletteAt(int[][] palette, float x, float y, float w, float h){

	float step = w / palette.length;
	float yPos = y;
	float xPos = x;
	float ww = step;

	noStroke(); 

	for (int i = 0; i < palette.length; i++) {
	  int r = palette[i][0];
	  int g = palette[i][1];
	  int b = palette[i][2];
	  fill(r,g,b);
	  rect(xPos, yPos, ww, h);
	  xPos+=step;
	}
}

void mousePressed(){
	current++;
	if(current>=fileNames.length){
		current=0;
	}
	 img = loadImage(pathDATA + fileNames[current]);
	palette = t.getPalette((BufferedImage) img.getImage(), numColors, quality, ignoreWhite);

}

