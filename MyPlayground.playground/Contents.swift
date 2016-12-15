//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var n = 2

while n < 100 {
    n = n * 2
}
print(n)

var a = 2

repeat {
    a = a * 2
} while a < 100
print(a)

func sumof(numbers: Int ...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}

sumof()
sumof(numbers: 1, 2, 3)


func returnFifteen() -> Int {
    var y = 5
    func addFive() {
        y += 5
    }
    addFive()
    return y
}
var b = returnFifteen()


func makeIncrementer() -> ((Int) -> Int) {
    
    func add(number: Int) -> Int {
        return number + 1
    }
    return add
}

var make = makeIncrementer()
var mak = make(4)

func isEqualFive(number: Int) -> Bool {
    if number == 5 {
        return true
    }
    return false
}

func aIsFive(number: Int, five:((Int) -> Bool)) -> Bool {
    return five(number)
}

var boo = aIsFive(number: 4, five: isEqualFive)

var numbers = [2,3]
numbers.map { number in
     number * 2
}

var newa = numbers.sorted{$0>$1}

print(newa)


class Name {
    var second: String?
    
    var first: String {
        set {
           self.second = newValue + "MIT"
        }
        
        get {
            return "libo"
        }
    }
}

var bName = Name.init()
bName.first = "i love"
print(bName.second!)

/*
var doub: Double = 1.2
var ain = 3
var good = doub + ain
 */

var (number, strin) = (2,"2")
var secondNumber: Int? = 2
var se = secondNumber!
assert((secondNumber != nil))

var arra = ["a", "b"]
let seuqe = arra.enumerated()
for (index, value) in seuqe {
    print("index\(index)== value\(value)")
}

var set = Set<String>()

var dic = [Int : String]()

let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
    
 case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
    
default: break
    
}

let value = "b"

switch value {
case "a":
    print("a")
    
    
case "b":
    print("b")
    fallthrough
default:
    print("c")
}

var i = 0
var j = 0
first: while(i < 10) {
    i += 1
    second:while(j < 10){
        j += 1
        print("i=\(i),j = \(j)")
         break first
    }
    
}

if #available(iOS 10, *) {
    print("ios 10")
}

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

let newNames = names.sorted(by: {$0>$1})
print(newNames)

var completionHandlers: [()->Void] = []

func someFunctionWithEscapingClosure(closure:@escaping ()->Void) {
    completionHandlers.append(closure)
}

class A {
    var name:String?
}

class B {
    var a = A.init()
}

var be = B()
be.a.name = "libo"
print(be.a.name!)


var things = [Any]()
things.append(0)
//things.append(0.0)
//things.append(42)
//things.append(3.14159)
//things.append("hello")
//things.append((3.0, 5.0))
//things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case is Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
            print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

struct Li {
    enum Bo {
        case Plum
    }
}

var hei = Li.Bo.Plum

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}