
color c1 = color(255, 0, 0);
color c2 = color(0, 255, 255);

float inc = 0.02;
int density = 2;

float zoff = 0.0;

void setup(){
	size(1920,800);
	noStroke();
	colorMode(RGB, 256);
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
			float n = noise(xoff, yoff, zoff);
			color c = lerpColor(c1, c2, n);
			fill(c);
			rect(x, y, density, density);
			yoff+= inc*5;
		}
		xoff+= inc;
	}
	zoff=frameCount/10.0; //inc*5;
}

void mousePressed(){
	c1 = color(random(155), random(55), random(155));
	c2 = color(random(255), random(100,255), random(100,255));
}