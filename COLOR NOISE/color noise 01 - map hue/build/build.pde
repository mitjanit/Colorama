

float inc = 0.02;
int density = 4;

float zoff = 0.0;

void setup(){
	size(800,800);
	noStroke();
	colorMode(HSB, 256);
	frameRate(4);

}

void draw(){
	background(0);
	float detail = map(mouseX, 0, width, 0.1, 0.6);
	noiseDetail(8, detail);
	float xoff = 0.0;
	for(int x=0; x<width; x+=density){
		float yoff = 0.0;
		for(int y=0; y<height; y+=density){
			float n = noise(xoff, yoff, zoff)*256;
			fill(n, 255, 255);
			rect(x, y, density, density);
			yoff+= inc*1.5;
		}
		xoff+= inc;
	}
	zoff+=inc;
}