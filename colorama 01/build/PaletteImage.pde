
class PaletteImage {
	
	PImage img;
	ArrayList<PVector> pos;
	ArrayList<Color> palette;

	PaletteImage(String fileName){
		this.img = loadImage(pathDATA + fileName);
		this.palette = new ArrayList<Color>();
		this.pos = new ArrayList<PVector>();
	}

	PImage getImage(){
		return this.img;
	}

	Color getColor(int num){
		return this.palette.get(num);
	}

	Color getColorAt(float x, float y){
		float xPos = constrain(x, 0, img.width);
		float yPos = constrain(x, 0, img.height);
		return new Color(img.get((int)xPos, (int)yPos));
	}

	Color getColorAt(int n){
		return palette.get(n);
	}

	void createRandomPalette(int numColors){
		palette = new ArrayList<Color>();
		pos = new ArrayList<PVector>();
		for (int i = 0; i < numColors; i++) {
			float xPos = (int)random(img.width);
			float yPos = (int)random(img.height);
			color c = img.get( (int)xPos , (int)yPos );
			palette.add(new Color(c));
			pos.add(new PVector(xPos, yPos));
		}
	}

	void createSteppedPalette(int numColors, float startX, float stepX, float y){
		palette = new ArrayList<Color>();
		pos = new ArrayList<PVector>();
		for (int i = 0; i < numColors; i++) {
			float xPos = (startX + stepX*i) % img.width;
			float yPos = constrain(y, 0, img.height);
			color c = img.get(Math.round( xPos ), (int)yPos);
			palette.add(new Color(c));
			pos.add(new PVector(xPos, yPos));
		}
	}

	void updateColorPosition(int n, float stepX){
		PVector oldPos = pos.get(n);
		float xPos = (oldPos.x + stepX) % img.width;
		float yPos = oldPos.y;
		oldPos.x = xPos;
		oldPos.y = yPos;
	}

	void updateColorPalette(int n, color newColor){
		Color oldColor = palette.get(n);
		oldColor.c = newColor;
	}

	void updatePalette(float stepX){
		for (int i = 0; i < palette.size(); i++) {
			updateColorPosition(i, stepX);
			color c = img.get( (int)pos.get(i).x , (int)pos.get(i).y );
			updateColorPalette(i, c);
		}
	}

	void displayPointer(int n){
		PVector p = pos.get(n);
		float x = map(p.x, 0, img.width, 0, sceneWidth);
		stroke(0);
		line(x, 0, x, img.height);
	}

	void displayImageAt(float x, float y, float w, float h){
		image(img, x, y, w, h);
		displayPointer(0);
	}

	void displayAt(float x, float y, float w, float h){
		for(int i=0; i<palette.size(); i++){
			Color c = palette.get(i);
			float xPos = w/palette.size()*i;
			float yPos = y;
			fill(c.getColor()); noStroke();
			rect(xPos, yPos, w, h);
		}
	}

}