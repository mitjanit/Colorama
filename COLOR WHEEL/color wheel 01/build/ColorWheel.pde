

class ColorWheel {
	
	float hueStart, hueEnd;
	int numColors;
	float hueStep;
	color[] wheelColors;

	PVector center;
	float radius;

	ArrayList<Color> selColors;


	ColorWheel(int n){
		this.numColors = n;
		this.hueStep = 360.0 / (float)n;

		selColors = new ArrayList<Color>();
	}

	void setColors(){
		wheelColors = new color[numColors];
		for(int numSector=0; numSector<wheelColors.length; numSector++){
			wheelColors[numSector]=color(hueStep*numSector, 100, 100);
		}
	}


	void display(PVector p, float r){
		this.center = new PVector(p.x, p.y);
		this.radius = r;

		pushMatrix();
			translate(p.x, p.y, 0);
			noStroke();
			float a = 0.0;
			float aStep = radians(hueStep);
			for(int numSector=0; numSector<wheelColors.length; numSector++){
				fill(wheelColors[numSector]); noStroke();
				arc(0, 0, r, r, a, a+aStep);
				a+=aStep;
			}
		popMatrix();
	}

	void selectRandomColors(int num){
		selColors = new ArrayList<Color>();
		while(selColors.size()!=num){
			color ct = color(random(360), 100, 100);
			if(!selectedSector(ct)){
				selColors.add(new Color(ct));
			}
		}
	}

	void selectDistantColors(int num){
		float angDist = 360.0 / (float) num;
		float a = random(360.0);
		selColors = new ArrayList<Color>();
		for(int i=0; i<num; i++){
			color ct = color(a, 100, 100);
			selColors.add(new Color(ct));
			a += angDist;
			a %= 360.0;
		}
	}

	void selectCompColors(){
		selectDistantColors(2);
	}

	boolean selectedSector(color c){
		int ns = getSectorOf(c);
		for(Color sc: selColors){
			color ct = sc.getColor();
			if(ns == getSectorOf(ct)){
				return true;
			}
		}
		return false;
	}

	void addSelectedColor(color c){
		Color sc = new Color(c);
		if(!selectedSector(c)){
			selColors.add(sc);
		}
	}

	void deSelectColors(){
		selColors.clear();
	}


	int getSectorOf(color c){
		return (int)(hue(c)/hueStep);
	}

	color getColorAtSector(int n){
		return wheelColors[n];
	}

	void highlightColors(){
		for(Color c: selColors){
			highlightColor(c.getColor());
			int ns = this.getSectorOf(c.getColor());
			highlightSector(ns);
		}
	}

	void highlightColor(color c){

		float xc = center.x + (radius/2-15)*cos(radians(hue(c)));
		float yc = center.y + (radius/2-15)*sin(radians(hue(c)));
		float xc2 = center.x + (radius/2+15)*cos(radians(hue(c)));
		float yc2 = center.y + (radius/2+15)*sin(radians(hue(c)));
		pushStyle();
			stroke(0, 0, 100); strokeWeight(8);
			line(xc2, yc2, xc, yc);
		popStyle();
	}

	void highlightSector(int n){
		float aStep = radians(hueStep);
		float a = aStep*n;
		pushStyle();
			fill(wheelColors[n]); noStroke();
			arc(center.x, center.y, radius*1.2, radius*1.2, a, a+aStep);
		popStyle();
	}

	void displaySelColors(PVector p, float s){
		stroke(0); strokeWeight(1);
		rectMode(CENTER);
		textAlign(CENTER);
		for(int i=0; i<selColors.size(); i++){
			Color c = selColors.get(i);
			color ct = c.getColor();
			fill(ct);
			rect(p.x, p.y + i*(s+20), s, s);
			fill(0);
			text(nf(hue(ct),3,0), p.x, p.y + i*(s+20) + s/1.25);
			int ns = getSectorOf(c.getColor());
			color ct2 = getColorAtSector(ns);
			fill(ct2);
			rect(p.x + s+10 , p.y + i*(s+20), s, s);
			fill(0);
			text(nf(hue(ct2),3,0), p.x + s +10, p.y + i*(s+20) + s/1.25);
		}
	}



}