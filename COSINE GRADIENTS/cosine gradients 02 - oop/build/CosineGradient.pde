

class CosineGradient {
	
	CosineComp cpRed, cpGreen, cpBlue, cpGlobal;
	int num;
	color[] values;

	color RED 	= color(255, 0, 0);
	color GREEN = color(0, 255, 0);
	color BLUE 	= color(0, 0, 255);

	float graphH = 400;
	float graphW = 1600;
	float graphMarginTop = 50;
	float graphMarginLeft = 100;
	float gradientH = 40;
	float gradientW = graphW;

	float stepGradients = 10;


	PVector graphOrigin 	= new PVector(graphMarginLeft, graphH + graphMarginTop);
	PVector redOrigin 		= new PVector(graphMarginLeft, graphH + graphMarginTop + stepGradients);
	PVector greenOrigin 	= new PVector(graphMarginLeft, graphH + graphMarginTop + gradientH + stepGradients*2);
	PVector blueOrigin 		= new PVector(graphMarginLeft, graphH + graphMarginTop + 2*gradientH + stepGradients*3);
	PVector gradientOrigin 	= new PVector(graphMarginLeft, graphH + graphMarginTop + 3*gradientH + stepGradients*4);

	float xgLabel = graphOrigin.x + graphW;


	CosineGradient(int n){
		this.num 	= n;
		this.setRed(new CosineComp(n, 0.0, 255, 0, 0));
		this.setGreen(new CosineComp(n, 0.0, 255, 0, 0));
		this.setBlue(new CosineComp(n, 0.0, 255, 0, 0));
		this.values = new color[n];
	}

	void setRed(CosineComp r){
		this.cpRed = r;
		this.cpRed.setRed();
	}

	void setGreen(CosineComp g){
		this.cpGreen = g;
		this.cpGreen.setGreen();
	}

	void setBlue(CosineComp b){
		this.cpBlue = b;
		this.cpBlue.setBlue();
	}

	void setGlobal(CosineComp g){
		this.cpGlobal = g;
	}


	void update(){
		cpRed.calculate();
		cpGreen.calculate();
		cpBlue.calculate();

		for(int i=0; i<values.length; i++){
			float r = cpRed.getColorAt(i);
			float g = cpGreen.getColorAt(i);
			float b = cpBlue.getColorAt(i);
			this.values[i] = color(r, g, b);
		}
	}

	void display(){
		
		cpRed.displayGraph(graphOrigin, graphW, graphH, RED, true);
		cpRed.displayGradient(redOrigin, gradientW, gradientH);
		cpRed.displayInfo(new PVector(xgLabel, 1.5*graphMarginTop), "RED");

		
		cpGreen.displayGraph(graphOrigin, graphW, graphH, GREEN, false);
		cpGreen.displayGradient(greenOrigin, gradientW, gradientH);
		cpGreen.displayInfo(new PVector(xgLabel, 1.5*graphMarginTop + graphH/3), "GREEN");
		
		
		cpBlue.displayGraph(graphOrigin, graphW, graphH, BLUE, false);
		cpBlue.displayGradient(blueOrigin, graphW, gradientH);
		cpBlue.displayInfo(new PVector(xgLabel, 1.5*graphMarginTop + 2*graphH/3), "BLUE");

		displayGradient(gradientOrigin, gradientW, 8*gradientH, cpRed, cpGreen, cpBlue);

	}

	void displayGradient(PVector orig, float w, float h, CosineComp r, CosineComp g, CosineComp b){
			
		float n = r.n;
		float wp = w/(float)n;

		noStroke();
		for(int i=0; i<n; i++){
			float redValue = red(this.values[i]);
			float greenValue = green(this.values[i]);
			float blueValue = blue(this.values[i]);
			fill(redValue,greenValue, blueValue);
			rect(orig.x + i*wp, orig.y, wp, h);
		}
	}
}