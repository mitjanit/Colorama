
float r = 150;
color c1 = color(255);
color c2 = color(0);

NoiseGradient ng;

void setup(){

	size(1920,1000);
	c1 = color(0);
	c2 = color(255);

	ng = new NoiseGradient(32*46, c1, c2);
	ng.setColors(0.01);

	

}

void draw(){
	ng.display(new PVector(10,10), width-20, height-20, 32, 46);
	fill(c1);
	ellipse(width/2-r, height/2, r,r);
	fill(c2);
	ellipse(width/2+r, height/2, r,r);
	fill(ng.getColor());
	ellipse(width/2, height/2, r, r);
}

void mousePressed(){
	c1 = color(random(155), random(55), random(155));
	c2 = color(random(255), random(100,255), random(100,255));
	ng = new NoiseGradient(32*48, c1, c2);
	ng.setColors(0.01);
}