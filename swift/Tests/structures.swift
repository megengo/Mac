// Defining a struct
struct Person {
    // Properties
    var firstName: String
    var lastName: String
    var age: Int

    // Computed property
    var fullName: String {
        return "\(firstName) \(lastName)"
    }

    // Method
    func greet() {
        print("Hello, my name is \(fullName) and I am \(age) years old.")
    }
}

// Creating an instance of the struct
var person = Person(firstName: "John", lastName: "Doe", age: 30)

// Accessing properties
print(person.firstName)  // Output: John
print(person.fullName)   // Output: John Doe

// Calling a method
person.greet()  // Output: Hello, my name is John Doe and I am 30 years old.

// Modifying properties
person.age = 31
print(person.age)  // Output: 31

// Using a constant struct instance
let anotherPerson = Person(firstName: "Jane", lastName: "Doe", age: 25)
// anotherPerson.age = 26 // This will cause a compile-time error because anotherPerson is a constant