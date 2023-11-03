// parse to number
String numberAsString = "2018";
System.out.println("numberAsString= " + numberAsString);
int number = Integer.parseInt(numberAsString);

// scanner
Scanner scanner = new Scanner(System.in);
System.out.println("Enter your year of birth:");
boolean hasNextInt = scanner.hasNextInt(); // check if scanner value is an int
if(hasNextInt) {
	int yearOfBirth = scanner.nextInt();
	scanner.nextLine(); // handle next line char enter key
	System.out.println("Enter your name: ");
	String name = scanner.nextLine();
	int age = 2021 - yearOfBirth;
	if(age >= 0 && age <= 100) {
		System.out.println("Your name is " + name + " and your age is " + age)
	} else {
		System.out.println("Invalid year of birth")
	}
} else {
	System.out.println("Type an int for birth year")
}
scanner.close();

// newline
System.out.println("Check" + "\n" + "this out");