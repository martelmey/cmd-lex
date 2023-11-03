/**
 * Are reference types
 * they hold references to objects/values,
 * not the objects/values themselves.
 * Using a reference to control an object in memory;
 * we can't access the object directly.
**/
import java.util.Scanner;

public class Main {

	private static Scanner scanner = new Scanner(System.in);

	public static void main(String[] args) {
		int[] myIntArray = new int[10]; // blank capacity of 10 ints
		int[] myIntArray2 = {1,2,3,4,5}; // capacity of 5 pre-defined ints
		myIntArray[5] = 50; // 50 saved to #6
		System.out.println(myIntArray[5]); // prints #6
		for(int 1=0; i<10; i++) {
			myIntArray[i] = i*10;
		}
		for(int i=0; i<10; i++) {
			System.out.println("Element " + i + ", is " + myIntArray[i]);
		}
		for(int 1=0; i<myIntArray.length; i++) {
			myIntArray[i] = i*10;
		}

		int[] myInts = getIntegers(5);
		for(int i=0; i<myInts.length; i++) {
			System.out.println("Element " + i + ", typed value was " + myInts[i]);
		}
		System.out.println("Average is " + getAverage(myInts));

		Arrays.toString(myInts); // print the contents of an int array as a string
	}

	public static int[] getIntegers(int number) {
		System.out.println("Enter " + number + " # of values.\r");
		int[] values = new int[number];
		for(int i=0; i<values.length; i++) {
			values[i] = scanner.nextInt();
		}
		return values;
	}

	public static double getAverage(int[] array) {
		int sum = 0;
		for(int i=0; i<array.length; i++) {
			sum += array[i];
		}
		return (double) sum / (double) array.length;
	}
}