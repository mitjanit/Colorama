
class CosineComp {
	
	int n;
	float offset; // [-PI, PI]
	float amp; //  [-PI, PI]
	float freq; //  [-PI, PI]
	float phase; //  [-PI, PI]
	float[] values;

	int colorComp;

	CosineComp(int n, float o, float a, float f, float p){
		this.n = n;
		this.offset = o;
		this.amp = a;
		this.freq = f;
		this.phase = p;
	}

	void setRed(){
		this.colorComp = 1;
	}

	void setGreen(){
		this.colorComp = 2;
	}

	void setBlue(){
		this.colorComp = 3;
	}

	void setColor(int n){
		this.colorComp =n;
	}

	void setOffset(float v){
		this.offset = v;
	}

	void setAmp(float v){
		this.amp = v;
	}

	void setFreq(float v){
		this.freq = v;
	}

	void setPhase(float v){
		this.phase = v;
	}

	void calculate(){
		values = new float[this.n];
		for(int i=0; i<this.n; i++){
			float v = constrain(offset + amp*cos(i*freq+phase), -amp, amp);
			values[i] = map(v, -amp, amp, 0, 255);
		}
	}


	void displayGraph(PVector orig, float w, float h, color c, boolean showCoords){
		
		float wp = w/(float)n;

		if(showCoords){
			// Lines
			strokeWeight(1); stroke(0); noFill();
			rect(orig.x, orig.y -h, w, h);
			
			// Horizontal AXIS
			for(float x=orig.x + wp; x<=orig.x + w; x+=wp){
				line (x, orig.y-5, x, orig.y+5);
			}

			// Vertical AXIS
			fill(0);
			for(float j=0.0; j<1.01; j+=0.1){
				line(orig.x-5, orig.y - j*h, orig.x+5, orig.y - j*h); 
				text(nf(j, 1, 2), orig.x -50, orig.y - j*h);
			}
		}

		float x0 = orig.x;
		float x = x0;
		float y0 = map (values[0], 0, 255, orig.y, orig.y - h);
		point(x0, y0);

		stroke(c);
		for(int i=0; i<n; i++){
			x += wp;
			float y = values[i];
			float v = map(y, 0, 255, orig.y, orig.y - h);
			point(x, v);
			line(x0, y0, x, v);
			x0 = x; y0 = v;
		}
	}

	void displayGradient(PVector orig, float w, float h){
		float wp = w/(float)n;
		noStroke();
		for(int i=0; i<n; i++){
			if(colorComp==1){
				fill(255,255-values[i], 255-values[i]);
			}
			else if(colorComp==2){
				fill(255-values[i],255, 255-values[i]);
			}
			else if(colorComp==3){
				fill(255-values[i],255-values[i], 255);
			}
			rect(orig.x + i*wp, orig.y, wp, h);
		}
	}

	void displayInfo(PVector pos, String label){
		float yStep = 20;
		float topMargin=10, leftMargin = 10;
		fill(0);
		text("OFFSET: "+nf(offset, 2, 4), pos.x + leftMargin, pos.y + topMargin);
		text("AMP: "+nf(amp, 2, 4), pos.x + leftMargin, pos.y + topMargin + yStep*1);
		text("FREQ: "+nf(freq, 2, 4), pos.x + leftMargin, pos.y + topMargin + yStep*2);
		text("PHASE: "+nf(phase, 2, 4), pos.x + leftMargin, pos.y + topMargin + yStep*3);
		text(label, pos.x + leftMargin + 150, pos.y + topMargin + yStep*1.5);
		stroke(0);
		line(pos.x + leftMargin+ 140, pos.y, pos.x + leftMargin + 140, pos.y + topMargin + yStep*3);
	}


	void display(PVector orig, float w, float h, float h2, color c){
		displayGraph(orig, w, h, c, true);
		displayGradient(new PVector(orig.x, orig.y+10), w, h2);
		displayInfo(new PVector(orig.x +w, orig.y - h), "RED");
	}

}