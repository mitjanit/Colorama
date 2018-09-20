
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

	void createSteppedPalette(int numColors, float startX, float startY, float stepX, float y){
		palette = new ArrayList<Color>();
		pos = new ArrayList<PVector>();
		for (int i = 0; i < numColors; i++) {
			float xPos = (startX + stepX*i) % img.width;
			float yPos = constrain(startY, 0, img.height);
			color c = img.get(Math.round( xPos ), (int)yPos);
			palette.add(new Color(c));
			pos.add(new PVector(xPos, yPos));
		}
	}

	void updateColorPosition(int n, float stepX, float stepY){
		PVector oldPos = pos.get(n);
		float xPos = constrain((oldPos.x + random(-stepX, stepX)), 0, img.width);
		float yPos = constrain((oldPos.y + random(-stepY, stepY)), 0, img.height);
		oldPos.x = constrain(xPos, 0, img.width);
		oldPos.y = constrain(yPos, 0, img.height);
	}

	void updateColorPalette(int n, color newColor){
		Color oldColor = palette.get(n);
		oldColor.c = newColor;
	}

	void updatePalette(float stepX, float stepY){
		for (int i = 0; i < palette.size(); i++) {
			updateColorPosition(i, stepX, stepY);
			color c = img.get( (int)pos.get(i).x , (int)pos.get(i).y );
			updateColorPalette(i, c);
		}
	}

	void displayPointer(int n){
		PVector p = pos.get(n);
		float x = map(p.x, 0, img.width, 0, sceneWidth);
		float y = map(p.y, 0, img.height, 0, sceneHeight);
		stroke(0);
		fill(palette.get(n).getColor());
		ellipseMode(CENTER);
		fill(255);
		ellipse(p.x, p.y, 25, 25);
		noStroke();
		fill(palette.get(n).getColor());
		ellipse(p.x, p.y, 20, 20);
		stroke(0); fill(0);
		text(n + " : " + hex(palette.get(n).getColor()), p.x + 20, p.y);
	}

	void displayImageAt(float x, float y, float w, float h){
		image(img, x, y, w, h);
	}

	void displayPointers(){
		for(int i=0; i<palette.size(); i++){
			displayPointer(i);
		}
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