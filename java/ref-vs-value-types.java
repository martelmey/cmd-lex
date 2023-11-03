public class Main {
	public static void main(String[] args) {
		int myIntValue = 10;
		int anotherIntValue = myIntValue; // is a static copy of myIntValue

		anotherIntValue++; // is now 11, not 10

		int[] myIntArray = new int[5]; // reference type, new object
		int[] anotherArray = myIntArray; // these both hold the same address ^

		System.out.println("myIntArray = " + Arrays.toString(myIntArray));
		System.out.println("anotherArray = " + Arrays.toString(anotherArray));

		anotherArray[0] = 1;

		System.out.println("after change myIntArray = " + Arrays.toString(myIntArray));
		System.out.println("after change anotherArray = " + Arrays.toString(anotherArray));
		/** change will be reflected in both
		 * because arrays are reference types
		**/
	}
}