

class NoiseGradient {
	
	color c1, c2;
	color[] values;
	float[] noises;

	float speed;
	int index;

	NoiseGradient(int n, color c1, color c2){
		this.values = new color[n];
		this.noises = new float[n];
		this.c1 = c1;
		this.c2 = c2;
		this.index=0;

		this.speed = 1;
	}

	void setColors(float inc){
		float min = 1.0, max = 0.0;
		noiseSeed(frameCount);
		noiseDetail(8, 0.1);
		float coff = 0.0;
		for(int i=0; i<values.length; i++){
			float n = noise(coff);
			if(n<min){
				min = n;
			}
			if(n>max){
				max = n;
			}
			noises[i] = n;
			values[i] = lerpColor(c1, c2, n);
			coff+=inc;
			//noiseDetail(8, map(i,0, values.length, 0.0, 0.6));
		}
		for(int i=0; i<values.length; i++){
			float n = map (noises[i], min, max, 0.0, 1.0);
			noises[i] = n;
			values[i] = lerpColor(c1, c2, n);
		}
	}

	void display(PVector orig, float w, float h, int rows, int cols){
		
		float wStep = w/(float)cols;
		float hStep = h/(float)rows;
		stroke(1);

		for(int r=0; r<rows; r++){
			for(int c=0; c<cols; c++){
				color col = values[c + r*cols];
				fill(col); 
				strokeWeight((index==c+r*cols)?5:1);
				rect(orig.x + wStep*c, orig.y + hStep*r, wStep, hStep);
				
				fill(255);
				textAlign(CENTER, CENTER);
				float n = noises[c+r*cols];
				text(nf(n, 1, 3), orig.x + wStep*c + wStep/2, orig.y + hStep*r + hStep/2);
			}
		}
	}


	color getColor(){
		if(frameCount%speed == 0){
			updateIndex();
		}
		return values[index];
	}

	void updateIndex(){
		index++;
		if(index>=values.length){
			index=0;
		}
	}


}