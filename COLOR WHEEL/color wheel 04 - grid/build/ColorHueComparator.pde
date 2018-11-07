
public class ColorHueComparator implements Comparator<Color> {
    @Override
    public int compare(Color c1, Color c2) {
       int distH = (int)(c1.h - c2.h);
       int distB = (int)(c1.b - c2.b);

       if(distH!=0){
       	return (int)(c1.h - c2.h);
       }
       else if(distB!=0){
       	return (int)(c1.b - c2.b);
       }
       else {	
       	return (int)(c1.s - c2.s);
       }
    }
}