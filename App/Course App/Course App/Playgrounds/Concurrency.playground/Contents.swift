import UIKit

var greeting = "Hello, playground"

let task = Task {
    print("I'm task")
}
print(task.isCancelled)
task.cancel()
print(task.isCancelled)

let voidTask: Task<Void, Error
