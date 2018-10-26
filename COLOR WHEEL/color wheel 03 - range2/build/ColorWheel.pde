

class ColorWheel {
	
	float hueStart, hueEnd;
	int numColors;
	float hueStep;
	color[] wheelColors;

	PVector center;
	float radius;

	ArrayList<Color> selColors;

	float analogDist = 10;

	ColorWheel(int n){
		this.numColors = n;
		this.hueStart = 0.0;
		this.hueEnd = 360.0;
		this.hueStep = 360.0 / (float)n;
		selColors = new ArrayList<Color>();
	}

	ColorWheel(int n, float hStart, float hEnd){
		this.numColors = n;
		this.hueStart = hStart;
		this.hueEnd = hEnd;
		if(hStart<hEnd){
			this.hueStep = (hEnd - hStart) / (float)n;
		}
		else {
			this.hueStep = ((360.0 - hStart) + hEnd) / (float)n;
		}

		selColors = new ArrayList<Color>();
	}

	void setColors(){
		wheelColors = new color[numColors];
		for(int numSector=0; numSector<wheelColors.length; numSector++){
			float hue = hueStart + hueStep*numSector;
			wheelColors[numSector]=color(hue%360.0, 100, 100);
		}
	}

	void displaceColors(float amount){
		for(int n = 0; n<wheelColors.length; n++){
			float newHue = (hue(wheelColors[n]) + amount) % 360;
			wheelColors[n] = color(newHue, 100, 100);
		}
	}


	void display(PVector p, float r){
		this.center = new PVector(p.x, p.y);
		this.radius = r;

		pushMatrix();
			translate(p.x, p.y, 0);
			noStroke();
			float a = 0.0;
			float aStep = radians(360.0 / (float)numColors);
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
			color ct = color(random(hueStart, hueEnd), 100, 100);
			int ns = getSectorOf(ct);
			if(ns!=-1 && !selectedSector(ct)){
				selColors.add(new Color(ct));
			}
		}
	}

	void selectDistantColors(int num){
		float angDist = abs(hueEnd - hueStart) / (float) num;
		float a = random(hueStart, hueEnd);
		selColors = new ArrayList<Color>();
		for(int i=0; i<num; i++){
			color ct = color(a, 100, 100);
			selColors.add(new Color(ct));
			a += angDist;
			if(a>hueEnd){
				a = (a - hueEnd) + hueStart;
			}
		}
	}

	void selectAnalogColors(color c, int num){
		float hue = hue(c);
		selColors = new ArrayList<Color>();
		selColors.add(new Color(c));
		int n=0;
		while(selColors.size()<num){
			for(int i=0; i<2; i++){
				float step = analogDist*(n+1) * ((i%2==0)?1:-1);
				float tHue = hue + step;
				if(tHue>hueEnd){
					tHue = (tHue - hueEnd) + hueStart;
				}
				else if(tHue<hueStart){
					tHue = hueEnd - (hueStart - tHue);
				}
				color ct = color(tHue, 100, 100);
				selColors.add(new Color(ct));
			}
			n++;
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
		int ns = getSectorOf(c);
		if(ns!=-1 && !selectedSector(c)){
			selColors.add(sc);
		}
	}

	void deSelectColors(){
		selColors.clear();
	}


	int getSectorOf(color c){
		if(hue(c)<hueStart || hue(c)>hueEnd){
			return -1;
		}
		else {
			return (int)((hue(c) - hueStart)/hueStep);
		}
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
		fill(bgColor); noStroke();
		ellipse(center.x,center.y, radius/3, radius/3);
	}

	void highlightColor(color c){

		float a = map(hue(c), hueStart, hueEnd, 0, 360.0);
		float xc = center.x + (radius/2-15)*cos(radians(a));
		float yc = center.y + (radius/2-15)*sin(radians(a));
		float xc2 = center.x + (radius/2+15)*cos(radians(a));
		float yc2 = center.y + (radius/2+15)*sin(radians(a));
		pushStyle();
			stroke(0, 0, 100); strokeWeight(8);
			line(xc2, yc2, xc, yc);
		popStyle();
	}

	void highlightSector(int n){
		float aStep = radians(360.0/numColors);
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