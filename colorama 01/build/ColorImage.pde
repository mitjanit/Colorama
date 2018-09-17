

class ColorImage {
	
	PImage img;
	int numColors;
	ArrayList<Color> palette;
	Color current;

	ColorImage(int numColors, String fileName){
		this.numColors = numColors;
		this.img = loadImage(pathDATA + fileName);
	}

	ColorImage(int numColors, PImage img){
		this.numColors = numColors;
		this.img = img;
	}

	Color getColor(float x, float y){
		float xPos = constrain(x, 0, img.width);
		float yPos = constrain(x, 0, img.height);
		return new Color(img.get(xPos, yPos));
	}


	void createPalette(int mode){
		palette = new ArrayList<Color>();
		if(mode==0){
			// Random mode
			for (int i = 0; i < numColors; i++) {
				color c = img.get(Math.round( (int)random(img.width)), 1 );
				palette.add(new Color(c));
			}
		}
		else if(mode==1){
			// Equidistant mode
			float w = (img.width / numColors);
			for (int i = 0; i < numColors; i++) {
				color c = img.get(Math.round( w*i , 1 );
				palette.add(new Color(c));
			}
		}
	}
}