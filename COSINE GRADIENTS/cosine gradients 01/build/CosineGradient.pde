

class CosineGradient {
	
	CosineComp red, green, blue, global;
	int num;

	CosineGradient(int n){
		this.num = n;
		this.red = new CosineComp(n, 0.0, height/2-50, PI/10, 0.0);
		this.green = new CosineComp(n, 0.0, 255, -PI, PI/8);
		this.blue = new CosineComp(n, 0.0, 255, 0, 0);
	}

	void setRed(CosineComp r){
		this.red = r;
	}

	void setGreen(CosineComp g){
		this.green = g;
	}

	void setBlue(CosineComp b){
		this.blue = b;
	}

	void setGlobal(CosineComp g){
		this.global = g;
	}

	color[] getGradient(){
		color[] colors = new color[this.num];
		for(int i=0; i<this.num; i++){
			float r = red.offset + red.amp*cos(i*red.freq + red.phase);
			float g = green.offset + green.amp*cos(i*green.freq + green.phase);
			float b = blue.offset + blue.amp*cos(i*blue.freq + blue.phase);
			color c = color(r, g, b);
			colors[i]= c;
		}
		return colors;
	}

	void display(){

	}
}