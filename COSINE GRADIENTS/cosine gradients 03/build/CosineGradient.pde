

class CosineGradient {
	
	CosineComp cpRed, cpGreen, cpBlue, cpGlobal;
	int num;
	color[] values;

	float amountPhase = 0.25;
	float amountOffset = 5;
	float amountFreq = 0.01;
	float amountAmp = 5;

	boolean updatable = true;
	boolean enableRed = false, enableGreen = false, enableBlue = false, enableGlobal = false;


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
			float r = map(cpRed.getColorAt(i), -255, 255, 0, 255);
			float g = map(cpGreen.getColorAt(i), -255, 255, 0, 255);
			float b = map(cpBlue.getColorAt(i), -255, 255, 0, 255);
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

		displayGradient(gradientOrigin, gradientW, 8*gradientH);

	}

	void displayGradient(PVector orig, float w, float h){
			
		float wp = w/(float)this.num;

		noStroke();
		for(int i=0; i<this.num; i++){
			float redValue = red(this.values[i]);
			float greenValue = green(this.values[i]);
			float blueValue = blue(this.values[i]);
			fill(redValue,greenValue, blueValue);
			rect(orig.x + i*wp, orig.y, wp, h);
		}
	}

	void displayGradientCurve(PVector orig, float w, float h){
		displayGradient(orig, w, h);
		PVector o = new PVector(orig.x, orig.y + h);
		cpRed.displayGraph(o, w, h, RED, false);
		cpGreen.displayGraph(o, w, h, GREEN, false);
		cpBlue.displayGraph(o, w, h, BLUE, false);
	}

	void disableAll(){
		enableRed 		= false;
		enableGreen 	= false;
		enableBlue 		= false;
		enableGlobal 	= false;
	}


	boolean changedFreq(float f){
		if(enableRed){
			return this.cpRed.freq!=f;
		}
		else if(enableGreen){
			return this.cpGreen.freq != f;
		}
		else if(enableBlue){
			return this.cpBlue.freq != f;
		}
		return false;
	}

	boolean changedOffset(float f){
		if(enableRed){
			return this.cpRed.offset!=f;
		}
		else if(enableGreen){
			return this.cpGreen.offset != f;
		}
		else if(enableBlue){
			return this.cpBlue.offset != f;
		}
		return false;
	}

	void setFreq(float value){
		if(enableRed){
			this.cpRed.freq = value;
		}
		else if(enableGreen){
			this.cpGreen.freq = value;
		}
		else if(enableBlue){
			this.cpBlue.freq = value;
		}
		updatable = true;
	}

	void setPhase(float value){
		if(enableRed){
			this.cpRed.phase = value;
		}
		else if(enableGreen){
			this.cpGreen.phase = value;
		}
		else if(enableBlue){
			this.cpBlue.phase = value;
		}
		updatable = true;
	}

	void setOffset(float value){
		if(enableRed){
			this.cpRed.offset = value;
		}
		else if(enableGreen){
			this.cpGreen.offset = value;
		}
		else if(enableBlue){
			this.cpBlue.offset = value;
		}
		updatable = true;
	}

	void changePhase(float value){
		if(enableRed){
			this.cpRed.phase += value;
		}
		else if(enableGreen){
			this.cpGreen.phase += value;
		}
		else if(enableBlue){
			this.cpBlue.phase += value;
		}
		updatable = true;
	}

	void changeFreq(float value){
		if(enableRed){
			this.cpRed.freq += value;
		}
		else if(enableGreen){
			this.cpGreen.freq += value;
		}
		else if(enableBlue){
			this.cpBlue.freq += value;
		}
		updatable = true;
	}

	void changeOffset(float value){
		if(enableRed){
			this.cpRed.offset += value;
		}
		else if(enableGreen){
			this.cpGreen.offset += value;
		}
		else if(enableBlue){
			this.cpBlue.offset += value;
		}
		updatable = true;
	}

	void changeAmp(float value){
		if(enableRed){
			this.cpRed.amp += value;
		}
		else if(enableGreen){
			this.cpGreen.amp += value;
		}
		else if(enableBlue){
			this.cpBlue.amp += value;
		}
		updatable = true;
	}


	void enableRed(){
		disableAll();
		this.enableRed = true;
	}

	void enableGreen(){
		disableAll();
		this.enableGreen = true;
	}

	void enableBlue(){
		disableAll();
		this.enableBlue = true;
	}

	void enableGlobal(){
		disableAll();
		this.enableGlobal = true;
	}
}