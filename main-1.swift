//
//  main-1.swift
//  LearningSwift
//
//  Created by Thanich Juthapisuth on 2017-09-23.
//  Copyright © 2017 Best in Bussiness Software Solution. All rights reserved.
//

import Foundation

var range = stride(from: 1, to: 2, by: 0.1)

for value in range {
    print(value)
}

var animal = "🐻"
switch animal {
case "🐻":
    print("bear")
default:
    print("unknown")
}

func getUsername () -> String {
    let name = "Peng"
    return name
}

var person = getUsername()
print(person)

func average (numbers list:[Int]) -> Double {
    var sum = 0.0;
    for value in list {
        sum += Double(value)
    }
    return sum/Double(list.count)
}

print(average(numbers: [1,2,3,4,5,6,7,8,9]))

func getMaxAverage (first:[Int], second:[Int]) -> (maxArray : [Int] , maxAverage: Double){
    let firstAvg = average(numbers: first)
    let secondAvg = average(numbers: second)
    return firstAvg > secondAvg ? (first, firstAvg) : (second, secondAvg)
}

print(getMaxAverage(first: [9,9,9,9,9], second: [6,6,6,6,6]))


class Student {
    var name:String = ""
    var email:String = ""
    
    func toString() -> String {
        return "Student \(name) \(email)"
    }
}

var jame = Student()
jame.name = "Jame"
jame.email = "jame@swift.com"

print(jame.toString())

class Rectangle {
    var topLeft: (x:Int,y:Int)
    var bottomRight: (x:Int,y:Int)
    init() {
        topLeft = (0,0)
        bottomRight = (0,0)
    }
    
    init(topLeft tl: (x:Int,y:Int), bottomRight br: (x:Int,y:Int)) {
        self.topLeft = tl
        self.bottomRight = br
    }
    
    func calArea() -> Double {
        return Double(abs(Double((bottomRight.x - topLeft.x))) * abs(Double((topLeft.y - bottomRight.y))))
    }
    
    func reset() -> Void {
        topLeft = (0,0)
        bottomRight = (0,0)
    }
    
    func toString() -> String {
        return "topLeft: \(topLeft), bottomRight: \(bottomRight)"
    }
    
    class func maxPoint() -> (x:Int, y:Int) {
        return (Int.max, Int.max)
    }
    
}
var recA = Rectangle(topLeft: (0,5), bottomRight: (5,0))
//recA.topLeft = (0,5)
//recA.bottomRight = (5,0)
print( "Rectangle \(recA.toString()) has area of \(recA.calArea())")
print( "Rectangle " + String(recA.toString()) + " has area of " + String(recA.calArea()))
print(Rectangle.maxPoint())
recA.bottomRight = Rectangle.maxPoint()
print( "Rectangle \(recA.toString()) has area of \(recA.calArea())")


class User {
    var name: String
    var id: Int
    
    init(name n:String, id i:Int) {
        self.name = n
        self.id = i
    }
    
}

/*
 convenience init of subclass has 3 rules.
 1.) designated init has to call itself before calling super
 2.) convenience has to make call to its designate
 3.) convenience cannot call super designated init directly
 */
class RegisteredUser : User {
    var email: String
    
    init(email e:String) {
        self.email = e
        super.init(name: "", id: 0)
    }
    
    convenience init() {
        self.init(email: "")
    }
}

/*
 Failable init: add "?" after init
 use guard to check condition otherwise return nil
 */
class Kid {
    var age:Int
    var name:String
    
    init?(age a:Int, name n:String) {
        guard (a < 15) else{
            return nil
        }
        self.age = a
        self.name = n
    }
}


let base64 =
"TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlz" +
"IHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2Yg" +
"dGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGlu" +
"dWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRo" +
"ZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4="

let base64Data = Data(base64Encoded: base64)
if let data = base64Data {
    let word = String(data: data, encoding: String.Encoding.utf8)
    print(word)
}

class Hero {
    deinit {
        print("Hero deinit")
    }
}

class Weapon {
    deinit {
        print("Weapon deinit")
    }
}

class Knight : Hero {
    var weapon:Weapon?
    deinit {
        print("Knight deinit")
    }
}

/*
 output:
 Knight deinit
 Hero deinit
 Weapon deinit
 // Weapon deinit got called last.
 Why? - it will call itself, then super, then whatever left in it.
 */
var knight:Knight? = Knight()
knight?.weapon = Weapon()
knight = nil
print("Done!")


/*Closure
 What is Closure? We need to understand 3 things
 1.) Function is a Type
 2.) Capturing value
 3.) Closure Expression
*/
// 1.) Function is a Type
// higher order function

func multiplyByTen(number: Int) -> Int {
    return number * 10
}

func addByTwo(number: Int) -> Int {
    return number + 2
}
// Function as parameter
//Use Typealias to make the code more readable
typealias funcTakeIntReturnInt = (Int) -> Int
func change(value:Int, withFunction function: funcTakeIntReturnInt) -> Void {
    print("The value is \(function(value))")
}

change(value: 20, withFunction: multiplyByTen)
change(value: 20, withFunction: addByTwo)


// Function as a return type
func makeIncrementByOne() -> (funcTakeIntReturnInt) {
    //nested function
    func increment(number:Int) -> Int {
        return number + 1
    }
    return increment
}
let mathIncrement = makeIncrementByOne()
print(mathIncrement(5))


// 2.) Capturing value
func makeIncrement(step:Int) -> (() -> Int) {
    var total = 0
    func increment() -> Int {
        // Capturing value is right here.
        total += step
        return total
    }
    return increment
}

let stepThree = makeIncrement(step: 3)
print(stepThree())
print(stepThree())
print(stepThree())


// 3.) Closure Expression
/*
 {
 (param) -> return_type in
     statement
 }
 
 Ex.
 {
 () -> String in
     return "Hello"
 }
 */
let multiplyByTenClosure = {(number: Int) -> Int in return number * 10}
func print(value:Int, withModifier: funcTakeIntReturnInt) -> Void {
    print(withModifier(value))
}

print(multiplyByTenClosure(30))
//note that even though it is taking function, it also takes closure.
print(value: 40, withModifier: multiplyByTenClosure)
//we can also pass closure expression as parameter
print(value: 40, withModifier: { (number:Int) -> Int in
    return number * 2
})

func makeIncrementClosure(step:Int) -> (() -> Int) {
    var total = 0
    // return the closure instead of the explicit function
    return {() -> Int in
        // Capturing value is right here.
        total += step
        return total
    }
}

let stepThreeClosure = makeIncrementClosure(step: 3)
print(stepThreeClosure())
print(stepThreeClosure())
print(stepThreeClosure())
/*************************************************************
 Summary
 What is Closure?
 Closures are self-contain block, global and nested functions are special cases of closures
 Closures take one of three forms:
 1.) Global functions are closures that have a name and do not capture any value;
 2.) Nested functions are closures that have a name and can capture values from their enclosing function
 3.) Closure expressions are unamed closures written in a lightweight syntax that can capture values from their surrounding context
 *************************************************************/
/*************************************************************
 Swift Higher-order Functions
 - sort
 - map
 - filter
 - reduce
*************************************************************/
let values = [2,7,4,5,10,3]
// sort
let ascending = { (first:Int, second:Int) -> Bool in
    return first < second
}
print(values.sorted(by: ascending))
// filter
let evenNumber = values.filter({(number:Int) -> Bool in
    return number%2 == 0
})
print(evenNumber)
//reduce
let sum = values.reduce(0, {(result:Int, next:Int) -> Int in
     result + next
})
print(sum)

// map
let mapValueToString = {(value:Int)-> String in
    return String(value)
}
let resultMap = values.map(mapValueToString)
print(resultMap)
// map does not have to change type ex: int to int
let mapDoubleValue = {(value:Int)-> Int in
    return value*2
}
let resultMap2 = values.map(mapDoubleValue)
print(resultMap2)

/*************************************************************
 Making it short
 - trailing closure
 - shorthand parameter
 -
 -
 *************************************************************/
// Trailing Closure
// This is only work when we have closure at the end.
let tcResult = values.sorted(by: { (first:Int, second:Int) -> Bool in
    return first < second
})
//shorter form
let tcResultShort = values.sorted{ (first:Int, second:Int) -> Bool in
    return first < second
}
print(tcResult)
print(tcResultShort)
// sorter reduce form
let sum2 = values.reduce(0) {(result:Int, next:Int) -> Int in
    result + next
}
print(sum2)
// Shorthand parameter
// no parenthesis, no return type, no return, ***$0 $1 ... $n, Operation Method*** used often
//let tcResultShort = values.sorted{ (first:Int, second:Int) -> Bool in
//    return first < second
//}
//let shResultShort = values.sorted{ first, second in first < second}
//let shResultShort = values.sorted{ $0 < $1 }
let shResultShort = values.sorted(by: <)
print(shResultShort)


