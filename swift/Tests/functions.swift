// Defining functions
func greet(name: String) -> String {
  return "Hello, \(name)!"
}

// Calling functions
let greeting = greet(name: "Alice")
print(greeting)  // Output: Hello, Alice!

// Functions without parameters
func sayHello() {
  print("Hello, world!")
}
sayHello()  // Output: Hello, world!

// functions without return values
func printMessage(message: String) {
  print(message)
}
printMessage(message: "This is a message.")  // Output: This is a message.

// multiple parameters
func add(a: Int, b: Int) -> Int {
  return a + b
}
let sum = add(a: 3, b: 5)
print(sum)  // Output: 8

// parameter labels and argument labels
func multiply(firstNumber a: Int, secondNumber b: Int) -> Int {
  return a * b
}
let product = multiply(firstNumber: 4, secondNumber: 5)
print(product)  // Output: 20

// default parameter values
func greet(name: String, withGreeting greeting: String = "Hello") -> String {
  return "\(greeting), \(name)!"
}
print(greet(name: "Bob"))             // Output: Hello, Bob!
print(greet(name: "Alice", withGreeting: "Hi"))  // Output: Hi, Alice!

// variadic parameters
func sum(numbers: Int...) -> Int {
  return numbers.reduce(0, +)
}
print(sum(numbers: 1, 2, 3, 4, 5))  // Output: 15

// in out parameters
func swapValues(_ a: inout Int, _ b: inout Int) {
  let temp = a
  a = b
  b = temp
}
var x = 10
var y = 20
swapValues(&x, &y)
print("x: \(x), y: \(y)")  // Output: x: 20, y: 10

// function types
func multiplyByTwo(number: Int) -> Int {
  return number * 2
}
let mathFunction: (Int) -> Int = multiplyByTwo
print(mathFunction(4))  // Output: 8

// nested functions
func outerFunction() -> () -> Int {
  var counter = 0
  func innerFunction() -> Int {
    counter += 1
    return counter
  }
  return innerFunction
}
let increment = outerFunction()
print(increment())  // Output: 1
print(increment())  // Output: 2

// closure
let closure = { (name: String) -> String in
  return "Hello, \(name)!"
}
print(closure("Charlie"))  // Output: Hello, Charlie!