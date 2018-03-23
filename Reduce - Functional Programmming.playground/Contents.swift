import UIKit

// Reduce

// Nefunkcionalno
// sabiranje
var numberOne = Int()
for number in Array(1...10) {
    numberOne += number
}
// oduzimanje
var numberTwo = Int()
for number in Array(1...10) {
    numberTwo -= number
}
numberOne // 55
numberTwo // -55

// Funkcionalno - Native Swift
let added = Array(1...10).reduce(0) { $0 + $1 } // 55
let subtracted = Array(1...10).reduce(0) { $0 - $1 } // -55

// Custom
func myReduce(_ pocetnaVrednost: Int, brojevi: [Int], logika: (Int, Int) -> Int) {
    var current = pocetnaVrednost
    for broj in brojevi {
        current = logika(current, broj) //necu da radim current += number  jer bi to onda bilo samo sabiranje, ovako je univerzalnije
    }
}

myReduce(0, brojevi: Array(1...10)) { $0 + $1 }

//max number
let maxNumber = Array(1...10).reduce(0) { (trenutni, broj) in
    max(trenutni, broj)
}
let maxBroj = Array(1...10).reduce(0) { max($0, $1) }


// Najcistiji nacin koriscenja
extension Array {
    func mojReduce(_ pocetak: Element, logika: (Element, Element) -> Element) -> Element {
        var trenutno = pocetak
        for item in self {
            trenutno = logika(trenutno, item)
        }
        return trenutno
    }
}

let imena = ["Vuk","Knez","VK"]
let description = imena.reduce("Imena su:") { "\($0) " + $1 }
print(description) // Imena su: Vuk Knez VK
let opis = imena.mojReduce("Imena su:") { "\($0)" + $1 }
print(opis) // Imena su:VukKnezVK

// https://github.com/typelift/Swiftz/tree/master/Sources/Swiftz
// Funkcionalno prigramiranje kako su napravljeni elementi u Swiftu

// RxSwift
// https://github.com/ReactiveX/RxSwift/tree/master/Documentation









