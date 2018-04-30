import UIKit

// ADVANCED OPERATORS

// Napraviti custom operator


// INOUT keyword - paramateri funkcije su konstantni po default-u
func enterSomething(_ a: Int) {
    // a += 1 ovo ne moze jer su po defaultu konstante, kao sto je vec receno
    print(a)
}
func enterSmthelse(_ a: inout Int) {
    a += 1
    print(a)
}
 var number = 10
enterSmthelse(&number)
print(number) // 11

// Postoje tri vrste operatora: Prefix, Postfix i Infix

!true // Prefix operator
let name: String? = "Vuk"
name! // Postfix operator


prefix operator ∑
prefix func ∑(number: Double) -> Double {
    return sqrt(number)
}
∑900 // 30
∑81 // 9

prefix operator ©
prefix func ©(enterword: String) -> String {
    return "\(enterword)®"
}
let tradeMarks = ©("Vuk")
print(tradeMarks) // Vuk®


postfix operator ¬
postfix func ¬(value: String?) -> String {
    guard let unwrrapedValue = value else {
        return ""
    }
    return unwrrapedValue
}
let myNickname: String? = "Vukovi"
myNickname¬ // ""

postfix operator %%
postfix func %%(enterNumber: Int) -> String {
    return enterNumber % 2 == 0 ? "Even" : "Odd"
}
100%% //"Even"


// Infix
3 * 3 // 9 i to je infix operator

//stari nacin
//infix operator **{
////associativity left  ovo je odakle kupi podatak s leva ili s desna -> 3 * 3 * 3 uzima sa leve str,
////precedence 130  ovo je vaznost operacije, 140 ili 150 operacije se odvijaju pre ove
////
//}
//func **(left: Double, right: Double) -> Double {
//    return pow(left, right)
//}
//2 ** 3 // 8
//2 ** 10 // 1024

// novi nacin
precedencegroup MojOperator {
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
    associativity: left
}
infix operator ????: MojOperator
func ????(left: UInt32, right: UInt32) -> Double {
    let lower: UInt32 = left
    let upper: UInt32 = right
    let randomNumber = arc4random_uniform(upper - lower) + lower
    return Double(randomNumber)
}
 1 ???? 10

// Overloading -- dodavenje funkcionalnosti nekoj metodi
// "a" * 10 //ovaj operater to ne moze da uradi jer nije predvidjen da radi sa stringovima
// "aaaaaaaaaa"

func *(left:String, right: Int) -> String {
    guard right >= 0 else {
        return ""
    }
    var result = String()
    for _ in 1..<right {
        result += left
    }
    return result
}
"a" * 10 // "aaaaaaaaaa"

