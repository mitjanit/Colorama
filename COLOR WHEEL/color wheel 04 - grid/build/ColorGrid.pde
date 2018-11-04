

class ColorGrid {
	
	float hueStart, hueEnd;
	float brightStart, brightEnd;
	int numColors, numBrights;
	float hueStep, brightStep;
	color[][] wheelColors;


	ArrayList<Color> selColors;

	float analogDist = 50;
	float monoDist = 30;

	ColorGrid(int nc, int nb){
		this.numColors = nc;
		this.numBrights = nb;
		this.hueStart = 0.0;
		this.hueEnd = 360.0;
		this.hueStep = 360.0 / (float)nc;
		selColors = new ArrayList<Color>();
	}

	ColorGrid(int nc, int nb, float hStart, float hEnd, float bStart, float bEnd){
		this.numColors = nc;
		this.numBrights = nb;
		this.hueStart = hStart;
		this.hueEnd = hEnd;
		if(hStart<hEnd){
			this.hueStep = (hEnd - hStart) / (float)nc;
		}
		else {
			this.hueStep = ((360.0 - hStart) + hEnd) / (float)nc;
		}

		this.brightStart = bStart;
		this.brightEnd = bEnd;
		this.brightStep = (bEnd - bStart) / (float)nb;

		selColors = new ArrayList<Color>();
	}

	void setColors(){
		wheelColors = new color[numColors][numBrights];
		for(int nh=0; nh<numColors; nh++){
			for(int nb=0; nb<numBrights; nb++){
				float hue = hueStart + hueStep*nh;
				float bright = brightStart + brightStep*nb;
				wheelColors[nh][nb]=color(hue%360.0, 255, bright);
			}
		}
	}

	void displaceColors(float amount){
		for(int nh = 0; nh<numColors; nh++){
			for(int nb = 0; nb<numBrights; nb++){
				float newHue = (hue(wheelColors[nh][nb]) + amount) % 360;
				float b = brightness(wheelColors[nh][nb]);
				float s = saturation(wheelColors[nh][nb]);
				wheelColors[nh][nb] = color(newHue, s, b);
			}
		}
	}


	void display(PVector p, float w, float h){
		
		float wStep = w / (float)numColors;
		float hStep = h / (float)numBrights;

		pushMatrix();
			translate(p.x, p.y, 0);
			stroke(0);
			for(int nc=0; nc<numColors; nc++){
				for(int nb=0; nb<numBrights; nb++){
					fill(wheelColors[nc][nb]);
					rect(wStep*nc, hStep*nb, wStep, hStep);
				}
			}
		popMatrix();
	}

	void selectRandomColors(int num){
		selColors = new ArrayList<Color>();
		while(selColors.size()!=num){
			float h = random(hueStart, hueEnd);
			float b = random(brightStart, brightEnd);
			color ct = color(h, 255, b);
			PVector ns = getSectorOf(ct);
			if(ns!=null && !selectedSector(ct)){
				//selColors.add(new Color(ct));
				selColors.add(new Color(h,255,b));
				println("ADDED COLOR: "+h+", "+b);
			}
		}

		Collections.sort(selColors);
	}

	void selectDistantColors(int num){
		float d = abs(hueEnd - hueStart) / (float) num;
		float h = random(hueStart, hueEnd);
		float b = random(brightStart, brightEnd);
		selColors = new ArrayList<Color>();
		for(int i=0; i<num; i++){
			color ct = color(h, 255, b);
			//selColors.add(new Color(ct));
			selColors.add(new Color(h, 255, b));
			h += d;
			if(h>hueEnd){
				h = (h - hueEnd) + hueStart;
			}
		}
		Collections.sort(selColors);
	}

	void selectAnalogColors(color c, int num){
		float hue = hue(c);
		float b = brightness(c);
		selColors = new ArrayList<Color>();
		selColors.add(new Color(hue, 255, b));
		//selColors.add(new Color(c));
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
				//color ct = color(tHue, 255, b);
				selColors.add(new Color(tHue, 255, b));
			}
			n++;
		}
		Collections.sort(selColors);
	}

	void selectMonoColors(color c, int num){
		float hue = hue(c);
		float b = brightness(c);
		
		selColors = new ArrayList<Color>();
		selColors.add(new Color(hue, 255, b));
		
		int n=0;
		while(selColors.size()<num){
			for(int i=0; i<2; i++){
				float step = monoDist*(n+1) * ((i%2==0)?1:-1);
				float tBright = b + step;
				if(tBright>brightEnd){
					tBright = (tBright - brightEnd) + brightStart;
				}
				else if(tBright<brightStart){
					tBright = brightEnd - (brightStart - tBright);
				}
				//color ct = color(tHue, 255, b);
				selColors.add(new Color(hue, 255, tBright));
			}
			n++;
		}

		Collections.sort(selColors);

	}

	void selectCompColors(){
		selectDistantColors(2);
	}

	boolean selectedSector(color c){
		PVector ns = getSectorOf(c);
		for(Color sc: selColors){
			color ct = sc.getColor();
			PVector sector = getSectorOf(ct);
			if(ns.x == sector.x && ns.y == sector.y){
				return true;
			}
		}
		return false;
	}

	void addSelectedColor(color c){
		Color sc = new Color(c);
		PVector ns = getSectorOf(c);
		if(ns!=null && !selectedSector(c)){
			selColors.add(sc);
		}
	}

	void deSelectColors(){
		selColors.clear();
	}

	void lighterColors(){
		for(Color c : selColors){
			float b = c.b;
			println("Original B: "+b);
			b+=brightStep;
			b = constrain(b, brightStart+1, brightEnd-1);
			println("Displaced B: "+b);
			c.setBrightness(b);
		}
	}

	void darkerColors(){
		for(Color c : selColors){
			float b = c.b;
			b-=brightStep;
			b = constrain(b, brightStart+1, brightEnd-1);
			c.setBrightness(b);
		}
	}


	PVector getSectorOf(color c){
		if(hue(c)<hueStart || hue(c)>hueEnd){
			return null;
		}
		else if(brightness(c)<brightStart || brightness(c)>brightEnd){
			return null;
		}
		else {
			float nh = (int)((hue(c) - hueStart)/hueStep);
			float nb = (int)((brightness(c) - brightStart)/brightStep);
			return new PVector(nh, nb);
		}
	}

	color getColorAtSector(PVector n){
		int x = constrain((int)n.x, 0, wheelColors.length-1);
		int y = constrain((int)n.y, 0, wheelColors[0].length-1);
		return wheelColors[x][y];
	}

	void highlightColors(PVector o, float w, float h){
		for(Color c: selColors){
			PVector ns = this.getSectorOf(c.getColor());
			highlightSector(ns, o, w, h);
		}
	}

	void highlightSector(PVector ns, PVector o, float w, float h){
		
		float wStep = w / (float)numColors;
		float hStep = h / (float)numBrights;
		pushStyle();
			stroke(0, 0, 255);
			int x = constrain((int)ns.x, 0, wheelColors.length-1);
			int y = constrain((int)ns.y, 0, wheelColors[0].length-1);
			fill(wheelColors[x][y]);
			rect(o.x + wStep*ns.x, o.y + hStep*ns.y, wStep, hStep);
		popStyle();
	}

	void displaySelColors(PVector p, float s){
		pushStyle();
		stroke(0); strokeWeight(1);
		for(int i=0; i<selColors.size(); i++){
			Color c = selColors.get(i);
			color ct = c.getColor();
			fill(ct);
			rect(p.x + i*(s+20), p.y , s, s);
			fill(0);
			text(nf(c.h,3,2), p.x + i*(s+20), p.y - 10 );
			

			PVector ns = getSectorOf(c.getColor());
			color ct2 = getColorAtSector(ns);
			fill(ct2);
			rect(p.x + i*(s+20) , p.y + s + 30 , s, s);
			fill(0);
			text(nf(hue(ct2),3,0), p.x + i*(s+20), p.y + s + 20);
			
		}
		popStyle();
	}



}