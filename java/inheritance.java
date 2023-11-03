// choose composition over inheritance where possible

// Animal is super class
public class Animal {
	private String name;
	private int brain;
	private int body;
	private int size;
	private int weight;

	public Animal(String name, int brain, int body, int size, int weight) {
		this.name = name;
		this.brain = brain;
		this.body = body;
		this.size = size;
		this.weight = weight;
	}

	public void eat() {

	}

	public void move() {

	}
}

public class Dog extends Animal {
// Dog constructor calls Animal constructor w/ super
// super() = extends Animal
	private int eyes;
	private int legs;
	private int tail;
	private int teeth;
	private String coat;

	public Dog(String name, int size, int weight int eyes, int legs, int tail, int teeth, String coat) {
		// set super class params first
		super(name,1,1,size,weight);
		// now set dog class params
		this.eyes = eyes;
		this.legs = legs;
		this.tail = tail;
		this.teeth = teeth;
		this.coat = coat;
	}

	private void chew() {
		System.out.println("Dog.chew() called");
	}

	@Override
	public void eat() {
		System.out.println("Dog.eat() called");
		chew();
		super.eat();
	}
}

public class Main {
	public static void main(String[] args) {
		Animal animal = new Animal("Animal", 1,1,5,5);
		Dog dog = new Dog("Chewy",8,15,2,4,1,20,"long silky");
		dog.eat();
	}
}