import UIKit

// Test Driven Development - TDD

// ovo je sporo jer postoje 3 nacina kako swift kompajlira
//for _ in 1...1000 {
//    print("hello")
//}
// -Onone  sporo i sluzi za debugging
// -O brzo i sluzi za release mode
// -Ounchecked super brzo i sluzi za testiranje


let startTime = CACurrentMediaTime()
for _ in 1...1000 {
    print("hello")
}
let totalTimeToRunForLoop = CACurrentMediaTime() - startTime
let sum = "Vreme za rad for pelje je \(totalTimeToRunForLoop) sekundi"
print(sum) // "Vreme za rad for pelje je \(totalTimeToRunForLoop) sekundi"

// touch NAZIV_SWIFT_FAJLA.swift    ---> ovo pravi swift fajl u terminalu
// xcrun swift -O example.swift -o NAZIV_SWIFT_FAJLA ---> ovo pokrece build u terminalu


// postoji nekoliko nacina da se CRVENA upozorenja izbace
// Assert Function:         Debug     Release       Test
// -assert()               -Onone
// -assertionFailure()     -Onone
// -precondition()         -Onone       -O
// -preconditionFailure()  -Onone       -O       -Ounchecked
// -fatalError()           -Onone       -O       -Ounchecked



// -assert()
func  enterName(name: String) {
    if name.isEmpty {
        assert(false, "Moras uneti ime")
    } else if name == "Vuk" {
        assert(false, "Ne mozes uneti Vuk")
    } else {
        assert(true)
    }
}

// enterName(name: "Vuk") // ovo je izbacilo crvenu poruku da "Ne mozes uneti Vuk"


// -assertionFailure()
let randomNumber: Int = Int(arc4random_uniform(3))
switch randomNumber {
case 0, 1, 2:
    print(randomNumber)
default:
    assertionFailure("Neocekivani index \(randomNumber)")
}


// -precondition()
let expectedNumber = (1,3)
let actualNumber = (1,3)

precondition(actualNumber == expectedNumber, "\(actualNumber) nije isto sto i \(expectedNumber)")



// -fatalError()
let number: Int = Int(arc4random_uniform(3))
func enterNumbertahtReturnsString(index: Int) -> String {
    switch index {
    case 0, 1, 2:
        return "\(index)"
    default:
//        assertionFailure("Neocekivani index \(index)")
//        abort()
// umesto ove dve ide sledece metoda
    fatalError("Neocekivani index \(index)")
    }
}




