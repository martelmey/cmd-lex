// user data types

public class Car {
	// fields
	private int doors;
	private int wheels;
	private String model;

	public void setModel(String mmodel) {
		String validModel = model.toLowerCase();
		if(validModel.equals("porsche") || validModel.equals("holden")) {
			this.model = model;
		} else {
			this.model = "Unknown";
		}
	}
	public String getModel() {
		return this.model;
	}
}

public class Main {
	public static void main(String[] args) {
		Car porsche = new Car(); // new Object() calls the constructor
		Car honda = new Car();
		porsche.setModel("Carrera");
	}
}

//=====================================
//=====================================
//=====================================
//=====================================
//=====================================

// constructors

public class Account {
	private String number;
	private double balance;
	private String customerName;

	public Account() {
		this("0000",0.00,"First Last")
		System.out.println("Empty constructor called, defaults set");
	}

	public Account(String number, double balance, String customerName) {
		this.number = number;
		this.balance = balance;
		this.customerName = customerName;
		System.out.println("constructor w/ params called")
	}

	public void deposit(double depositAmount) {
		this.balance += depositAmount;
		System.out.println("Deposited " + depositAmount + ". New balance: " + this.balance);
	}
}

public class Main {
	public static void main(String[] args) {
		Account blankAccount = new Account();
		Account myAccount = new Account("1216", 100.00, "Martel");
	}
}

//=====================================
//=====================================
//=====================================
//=====================================
//=====================================
