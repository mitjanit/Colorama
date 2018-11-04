import java.util.Collections;

class Color implements Comparable<Color> {
	
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


	void setBrightness(float b){
		this.b = b;
		this.c = color(h, s, b);
	}


	@Override
	public int compareTo(Color other) {

		int distH = (int)(this.h - other.h);
		int distB = (int)(this.b - other.b);

		if(distH!=0){
			return (int)(this.h - other.h);
		}
		else if(distB!=0){
			return (int)(this.b - other.b);
		}
		else {	
			return (int)(this.s - other.s);
		}

	}
}