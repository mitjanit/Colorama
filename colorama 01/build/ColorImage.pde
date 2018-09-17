

class ColorImage {
	
	PImage img;
	Color c;
	int mode;


	ColorImage(String fileName){
		img = loadImage(pathDATA + fileName);
	}

	ColorImage(PImage img){
		this.img = img;
	}
}