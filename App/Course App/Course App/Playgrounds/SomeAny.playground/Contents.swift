import Foundation
import SwiftUI

// Some (Opague return Types)
func getData() -> some Collection{
    return [1, 2, 3, 4]
}

let data = getData()
data.count
let element = data.randomElement() as? Int // if we want to call back Int type

func getOneTypeOfValue() -> some Equatable{
    return 0
}

let firstValue = getOneTypeOfValue()
let secondValue = getOneTypeOfValue()

firstValue == secondValue


func getAnotherTypeOfValue() -> some Equatable{
    return 1
}

let thirdValue = getAnotherTypeOfValue()


//firstValue == thirdValue

// any
protocol Networking{
    func fetchData(at url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}




protocol StorageMechanism {
    associatedtype TypeOfStorage
}

//func implementingStorageFirst(_ mechanism: StorageMechanism) {
    // ❌ Will not compile since StorageMechanism
    //    has associatedtype defined inside it
//}

func implementingStorageSecond<T: StorageMechanism>(_ mechanism: T) {
    // ✅ Will Compile since we are now using generics
}

func implementingStorageThird(_ mechanism: some StorageMechanism) {
    // ✅ Will Compile since we are now using some keyword
}


// 1. ❌ Will not compile
//var var1: View = Text("Sample Text")

// 2. ✅ Will compile
var var2: some View = Text("Sample Text")

// 3. ✅ Will Compile
var var3: any View = Text("Sample Text")



// 1. ✅ Will compile
var var4: [some View] = [ Text("Sample Text"), Text("Sample Text") ]

// 2. ❌ Will not compile
//var var5: [some View] = [ Text("Sample Text"), Label("Sample Text", systemImage: "bolt.fill") ]

// 3. ✅ Will Compile
var var6: [any View] = [ Text("Sample Text"), Label("Sample Text", systemImage: "bolt.fill") ]
//1st syntax
// has worse performance than the second syntax
// only thing the compiler knows is that the argument networking will
// confirm the protocol networking, and that's it the compiler doesn't have
// any clue as to why the actual type of the argument networking will be
// compiler will need to generate some extra code so that at one time the code
// of the method fetch data will be dispatched to correct type
// and this extra code will hinder performances, because first it will make
// the size of our app a little bit bigger , and it will also decrease performances at one time
// because the extra code will have to be executed

// any
// whenever you want to use a protocol as type for either an argument or a property
// or a local variable, you're supposed to add the keyword any in front of the name of the protocol
// purpose of this keyword is simply to alert the developer to the fact
// that using the protocol in such a way is going to have an impact on performances
func load(_ networking: any Networking){
    let url = URL(string: "https://myapi.com/myEndpoint")!
    
    networking.fetchData(at: url){result in
        // use result
    }
}

// 2st syntax
// at compile time , the compiler will know what is the actual type
// that is used as generic argument
// the compiler will be able to optimize our code, because the compiler will know exactly
// what type is the instance of networking
func load<N: Networking>(_ networking: N){
    let url = URL(string: "https://myapi.com/myEdnPoint")!
    
    networking.fetchData(at: url) { result in
        // use the "result"
    }
}


let number: Float = 4
