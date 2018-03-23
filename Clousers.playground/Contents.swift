import UIKit

// FUNCTIONAL PROGRAMMIG
// CLOSERS

// klozer je funskcija bez imena i bez parametara

func addTwoNumbers(number1: Int, number2: Int) -> Int {
    return number1 + number2
}
addTwoNumbers(number1: 20, number2: 30) // 50

// OBJASNJENJE KLOZERA POMOCU FUNKCIJE
// dodeljivanje f-je nekom property-ju, bez pozivanja funksicje
var addFunction = addTwoNumbers
// sad mogu da pozovem f-ju preko property-ja
addFunction(10, 15) //25, i ovde se dogdja klozer

//isto samo napisano kolzerom
var addCloser: (Int, Int) -> Int = { (number1: Int, number2: Int) in
    return number1 + number2
}
addCloser(10, 15)

var addCloserTwo = {
    (number1: Int, number2: Int) in
    return number1 + number2
}
addCloserTwo(10, 15)

var addCloserThree = {
    (number1: Int, number2: Int) in
    number1 + number2
}
addCloserThree(10, 15)

var addCloserFour: (Int, Int) -> Int = { $0 + $1 } // ode se mora eksplicitno navesti tip kad se koristi $
addCloserFour(10, 15)

// primer ()->String
func callString() -> String {
    return "ja sam funkcija"
}

let callStringClosure: () -> String = {
    () in
    return "ja sam klozer"
}

let callStringClosure2: () -> String = { () in
    "ne mora da se koristi return kod klozera"
}

let callStringClosure3: () -> String = { "ne moraju da se koriste ni return ni unutrasnji paramteri kod klozera" }

let callStringClosure4 = { "ne moraju da se koriste ni return ni unutrasnji paramteri ni ekplicitno definisanje tipa kod klozera" }



// funkcija je u stvari globalni klozer, samo objasnjenja radi govori se da je klozer funkcija bez parametara i tipa


//: Return closer indirectly
func returnCloser() -> ((Int, Int) -> Int) {
    return addCloser
}
let returnedCloser = returnCloser()
returnedCloser(10, 10)
returnCloser()(10, 10)

//: Return closer directly
func returnCLoserDirectly() -> ((Int, Int) -> Int) {
    return { (number1: Int, number2: Int) in number1 + number2 }
}
let closer = returnCLoserDirectly()
closer(10, 10)


func returnCLoserDirectlyTwo() -> ((Int, Int) -> Int) {
    return { $0 + $1 }
}
let closureTwo = returnCLoserDirectlyTwo()
closureTwo(10, 10)


//: Prosledjivanje closer-a
func insertClosureBlock(closureBLock: () -> String) {
    print(closureBLock)
}

//: Prosledjivanje closer-a indirektno
insertClosureBlock(closureBLock: callStringClosure)

//: Prosledjivanje closer-a direktno

insertClosureBlock { () -> String in
    "Pozdrav"
}
insertClosureBlock { () in
    "Pozdrav"
}
insertClosureBlock { "Pozdrav"}

let primer = Array(1...100).filter { $0 == 2 }
print(primer) //

let primer2 = Array(1...100).filter { $0 % 2 == 0 }
print(primer2) //












