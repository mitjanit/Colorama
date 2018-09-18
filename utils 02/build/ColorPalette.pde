
class ColorPalette extends ColorBasics {
	

	int[] Monochromatic(String hex) {
		
		currentType = 0;

		String[] paletteHex = new String[8];
		int[] P5Colors      = new int[8];

		int Rtemp, Gtemp, Btemp;

		hex.toUpperCase().replace("#", "");

		baseColorHex = correctColorHex(hex);

		// Color 1 (Corrected base color)
		paletteHex[0] = baseColorHex;
		P5Colors[0]   = Hex2P5(baseColorHex);

		int[] RGB = Hex2RGB(paletteHex[0]);
		int R = RGB[0];
		int G = RGB[1];
		int B = RGB[2];

		// Color2
		Rtemp = MonoColor(R, 2);
		Gtemp = MonoColor(G, 2);
		Btemp = MonoColor(B, 2);
		paletteHex[1] = correctColorHex(RGB2Hex(Rtemp, Gtemp, Btemp));
		P5Colors[1]   = Hex2P5(correctColorHex(RGB2Hex(Rtemp, Gtemp, Btemp)));

		// Color 3
		Rtemp = MonoColor(R, 3);
		Gtemp = MonoColor(G, 3);
		Btemp = MonoColor(B, 3);
		paletteHex[2] = correctColorHex(RGB2Hex(Rtemp, Gtemp, Btemp));
		P5Colors[2]   = Hex2P5(correctColorHex(RGB2Hex(Rtemp, Gtemp, Btemp)));

		// Color 4
		Rtemp = MonoColor(R, 4);
		Gtemp = MonoColor(G, 4);
		Btemp = MonoColor(B, 4);
		paletteHex[3] = correctColorHex(RGB2Hex(Rtemp, Gtemp, Btemp));
		P5Colors[3]   = Hex2P5(correctColorHex(RGB2Hex(Rtemp, Gtemp, Btemp)));

		// Color 5
		P5Colors[4]  = Hex2P5(correctColorHex(SecondColor(paletteHex[0])));
		//Color 6
		P5Colors[5]  = Hex2P5(correctColorHex(SecondColor(paletteHex[1])));
		// Color 7
		P5Colors[6]  = Hex2P5(correctColorHex(SecondColor(paletteHex[2])));
		// Color 8
		P5Colors[7]  = Hex2P5(correctColorHex(SecondColor(paletteHex[3])));

		// Return array with Processing colors
		return P5Colors;
	}
}