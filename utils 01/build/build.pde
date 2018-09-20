 
import java.util.*;

int    sceneWidth   = 800;
int    sceneHeight  = 600;
color  bgColor    = #ECECEC;
String pathDATA = "../../data/";

 
int numColors = 10;
Map<Integer, Integer> unsortMap, sortedMap;
PImage pic;
color[] palette;
 
void settings() {
  size(sceneWidth,sceneHeight,P2D);
}

void setup(){

  pic = loadImage(pathDATA + "rainbow01.jpg");
  palette = new color[numColors];

  unsortMap = countColorsIntoMap(pic);
  println("Unique colors found:" + unsortMap.size() + "\tfrom:" + pic.width*pic.height);
  int idx=0;
  /*
  for (Map.Entry<Integer, Integer> entry : unsortMap.entrySet()) {
    println("Key : " + hex(entry.getKey()) + " Value : " + entry.getValue());
    if (++idx == 100)  break;
  }
  */

  sortedMap = sortByValue(unsortMap);

  idx=0;
  println("Top "+numColors+" colors:");
  for (Map.Entry<Integer, Integer> entry : sortedMap.entrySet()) {
    println(idx+") Color: " + hex(entry.getKey()) + ", Times: " + entry.getValue());
    palette[idx]=entry.getKey();
    if (++idx == numColors)  break;
  }
  
}
 
void draw() {
  background(0);
  image(pic, 0,0);
  for(int i=0; i<palette.length; i++){
    fill(palette[i]);
    rect(10 + 50*i + 10*i, 10, 50, 50);
  }
}


Map<Integer, Integer> sortByValue(Map<Integer, Integer> unsortMap) {

        // 1. Convert Map to List of Map
        List<Map.Entry<Integer, Integer>> list =
                new LinkedList<Map.Entry<Integer, Integer>>(unsortMap.entrySet());

        // 2. Sort list with Collections.sort(), provide a custom Comparator
        Collections.sort(list, new Comparator<Map.Entry<Integer, Integer>>() {
            public int compare(Map.Entry<Integer, Integer> o1,
                               Map.Entry<Integer, Integer> o2) {
                return (o2.getValue()).compareTo(o1.getValue());
            }
        });

        // 3. Loop the sorted list and put it into a new insertion order Map LinkedHashMap
        Map<Integer, Integer> sortedMap = new LinkedHashMap<Integer, Integer>();
        for (Map.Entry<Integer, Integer> entry : list) {
            sortedMap.put(entry.getKey(), entry.getValue());
        }

        return sortedMap;
}
 
Map<Integer, Integer> countColorsIntoMap(PImage img) {
  Map<Integer, Integer> map = new HashMap<Integer, Integer>();

  img.loadPixels();
  for (color c: img.pixels) {
    //System.out.println(hex(c));
    if(map.containsKey(c)){
      int count = map.get(c);
      map.put(c, count+1);
    }
    else {
      map.put(c,1);
    }
  }
  return map;
}