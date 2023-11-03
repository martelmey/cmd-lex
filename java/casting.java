/**
 * Math.random() produces double by default
 * this casts it to an int
**/

public static int randomInt() {
	int randomNumber = (int) (Math.random() * 5) +1;
	switch(randomNumber) {
		case 1:
			return randomNumber;
		default:
			return -1;
	}
}