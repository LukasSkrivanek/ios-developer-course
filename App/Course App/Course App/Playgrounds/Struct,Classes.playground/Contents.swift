import UIKit

var greeting = "Hello, playground"

struct Person{
    let firstName: String
    let lastName: String
}

enum Country: Equatable {
    case czech(currency: String)
    case slovak(curr: String)
}

let czech = Country.czech(currency: "Kc")
let newCzech = Country.czech(currency: "Eur")
print(newCzech == czech)

if case let .czech(currency) = .czech{
    print(currency)
}

switch czech{
case .czech(let currency): // case let .czech(currency)_
    print(currency)
case .slovak()
}

enum AuthPermission{
    case notDetermined
    case authorized
    case denied
}

let auth  = AuthPermission.denied

switch auth {
case .notDetermined:
    
case .authorized:
    print("authorized")
case .denied:
    
}

// @uknown default
// fallthrough case we dont want to do nothing in this case

let optionalName: String?
let optionalName: Optional<String> // underhood
// optional is enum with to cases

enum Optional {
    case none
    case some(value)
}

func helloWorld() {}
func helloWorldVoid() -> Void {} // void return type
typealias EmptyClosure = () -> Void // empty input type
let myEmptyClosure = { _ in
    print("test")
}

func myFunction(inputFunction: EmptyClosure) -> EmptyClosure {
    inputFunction
}

// api request ,
// escaping
//
func myFunction(inputFunction: @escaping EmptyClosure) -> EmptyClosure {
    inputFunction
}

func counting(_  inputFunction: (Int) -> Void) { // _ nameless
    let a = 5
    inputFunction(a)
    print("counting\(a)")
}
// closure is anonymous function
// api call , and in callback you want 
counting({value in}) // less used
counting() {value in
    print("value inside\(value)")
}

// advanced topic
// types , references, value , basic types, tuples , callbacks
// underscore - you don't care about parametr
func testFunction(argumentLabel parameterName: String){
    print(parameterName)
}

func decode(_ decoder: JSONDecoder){
    
}

testFunction(argumentLabel: "")
decode(JSONDecoder())

func decode2(with _ : JSONDecoder){
    
}
@discardableResult
_ = decode2(with: JSONDecoder())

enum Constants {
    static let pi = 3.14
}
// enum or struct for constants
// enum and struct value types
let `struct` =

// computed variables vs functions
// escaping topic
// defer block of code that will be executed at end of the process


// type abstraction
// protocols, generics, existential and opaque type

// extensions
// its a way how to extend behaviour of types , objects, views

private extension String{
    var test: Int{
        5
    }
}
// we wont to access extensions in our file , not globally
// computed variable, you will call it one time , you will not have parameter
// with extension we can have multiple function and when i will mark extension private , all of them will be private with one word , so i dont have to do it for every one seperatly
// extension are good for structure your code


// protocols
// name providing
protocol NameProviding{
    /// try to get setter as well?
    var name: String {get}
    func printFullName()
}

private (set) var name: String

// typealias
// as
// protocols can inherit
// generic
// where
