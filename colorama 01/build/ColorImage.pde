

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

	PImage getImage(){
		return img;
	}

	Color getColorAt(float x, float y){
		float xPos = constrain(x, 0, img.width);
		float yPos = constrain(x, 0, img.height);
		return new Color(img.get(xPos, yPos));
	}

	void createRandomPalette(){
		palette = new ArrayList<Color>();
		for (int i = 0; i < numColors; i++) {
			color c = img.get(Math.round( (int)random(img.width)), 1 );
			palette.add(new Color(c));
		}
	}

	void createSteppedPalette(float start, float step, float y){
		palette = new ArrayList<Color>();
		for (int i = 0; i < numColors; i++) {
			float xPos = (start + step*i) % img.width;
			float yPos = constrain(y, 0, img.height);
			color c = img.get(Math.round( xPos , yPos );
			palette.add(new Color(c));
		}
	}


}