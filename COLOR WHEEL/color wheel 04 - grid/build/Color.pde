import java.util.Collections;

class Color {
//class Color implements Comparable<Color> {
	
	float h, s, b;
	color c;

	Color(float h, float s, float b){
		this.h = h;
		this.s = s;
		this.b = b;
		this.c = color(h, s, b);
	}

	Color(color c){
		this.h = hue(c);
		this.s = saturation(c);
		this.b = brightness(c);
		this.c = c;
	}

	color getColor(){
		//return this.c;
		return color(h, s, b);
	}

	void setHue(float h){
		this.h = h;
		this.c = color(h, s, b);
	}

	void setSaturation(float s){
		this.s = s;
		this.c = color(h, s, b);
	}

	void setBrightness(float b){
		this.b = b;
		this.c = color(h, s, b);
	}
}