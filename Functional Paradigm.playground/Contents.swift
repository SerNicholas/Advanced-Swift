import UIKit

//: Functional Programming


// pocecemo sa ne-funkcionalnim programiranjem
// ovo postoji u jednom VC
let numbers = [1, 2, 3]
var sum = 0
for number in numbers {
    sum += number
}
print(sum)


// ovo postoji u nekom drugom VC
let newNumbers = [1, 2, 3]
var newSum = 0
for number in numbers {
    newSum += number
}
print(newSum)


//!!!! NIKAD OVAKO NE PROGRAMIRATI !!!!!//
func primitiveFunctionalProgramming(elements: [Int]) -> Int {
    var sum = 0
    for number in elements {
        sum += number
    }
    return sum
}
primitiveFunctionalProgramming(elements: numbers)
primitiveFunctionalProgramming(elements: newNumbers)

// Funkocionalno programiranje je programiranje koriscenjem funkcija radi dobijanja rezultata.

