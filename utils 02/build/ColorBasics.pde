

class ColorBasics {
	

	color Hex2P5(String hex) {
		if (hex.length() == 6) {
			int[] rgb = Hex2RGB(hex);
			return color(rgb[0], rgb[1], rgb[2]);			
		} else {
			System.out.println("Hex2P5(): hex color parameter should be 6 characters long");
		}
		return -1;
	}


	int[] Hex2RGB(String hex) {
		
		int[] rgb = new int[3];
		hex = hex.toUpperCase().replace("#", "");

		 if (hex.length() == 6) { // FFFFFF
			rgb[0] = Hex2Decimal(hex.substring(0, 2));	// R
			rgb[1] = Hex2Decimal(hex.substring(2, 4));	// G
			rgb[2] = Hex2Decimal(hex.substring(4, 6));	// B
		} else {
			System.out.println("Hex2RGB(): hex color parameter should be 6 characters long");
		}

		return rgb;
	}

	int Hex2Decimal(String hex) {
        hex = hex.toUpperCase().replace("#", "");
        int decimal = 0;
        for (int i = 0; i < hex.length(); i++) {
            char c = hex.charAt(i);
            int d  = hexadecimalChars.indexOf(c);
            decimal = 16 * decimal + d;
        }
        return decimal;
    }



}