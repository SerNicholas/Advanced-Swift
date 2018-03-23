import UIKit


// Non-functional
// Parni brojevi
var parni = [Int]()
for i in 1...10 {
    if i % 2 == 0 {
        parni.append(i)
    }
}

// Functional
// Parni brojevi
Array(1...10).filter { (number) -> Bool in
    number % 2 == 0
}
// ili
Array(1...10).filter { $0 % 2 == 0 }


// Neki podaci
let ocene = ["A", "A", "A", "A", "B", "B", "C"]
// NE-funkcionalni nacin
var aovi: [String] = []
for ocena in ocene {
    if ocena == "A" {
        aovi.append(ocena)
    } else {
        print("Nije A")
    }
}
print(aovi) // A,A,A,A
// Funkcionalni nacin
// naparvimo closure block
var isItA: (String) -> Bool = { (ocena) in
    return ocena == "A"
}
isItA("A") // true
isItA("B") // false
// ILI
var daLiJeA: (String) -> Bool = { $0 == "A" }
daLiJeA("A") // true
daLiJeA("B") // false

// napraavimo funkciju koja uzima klozer
func odaberiA(ocene: [String], logika: (String) -> Bool) {
    var aovi: [String] = []
    for ocena in ocene {
        if logika(ocena) {
            aovi.append(ocena)
        }
    }
}
// ovde je klozer predat indirektno
odaberiA(ocene: ocene, logika: isItA) // A,A,A,A
// sada klozer predajmo direktno
odaberiA(ocene: ocene) { (ocena) -> Bool in
    ocena == "A"
}

//SADA PRAVIM SVOJ FILTER
func odaberiFILTER<T>(niz: [T], logika: (T) -> Bool) -> [T] {
    var result: [T] = []
    for element in niz {
        if logika(element) {
            result.append(element)
        }
    }
    return result
}

// Primeri
// 1 - filtriranje brojeva
let AStudent = odaberiFILTER(niz: Array(1...100), logika: { $0 > 93 && $0 <= 100 })
print(AStudent) // [94, 95, 96, 97, 98, 99, 100]

// 2 - pregledanje glasanja
let answer = [true, false, true, false, false, false]
let trueAnswer = odaberiFILTER(niz: answer, logika: { $0 == true })
print(trueAnswer) // [true, true]
let falseAnswer = odaberiFILTER(niz: answer, logika: { $0 == false })
print(falseAnswer) // [false, false, false, false]

// 3 - Swiftov filter
let nulaDoSto = Array(0...100)
nulaDoSto.filter({ $0 % 2 == 0 }).filter({ $0 <= 50 })

// Najcistiji nacin koriscenja filtera
extension Array { // Element predstavlja Swiftov tip ovog Array-a
    func myFilter(_ logika: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for element in self {
            if logika(element) {
                result.append(element)
            }
        }
        return result
    }
}

let reuslt = Array(1...100).myFilter { $0 % 2 == 0 }






