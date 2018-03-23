import UIKit

var arrayOne: [Double] = []
var arrayTwo = [Double]()
// Array je struktura i to genericka, sto se vidi iz sledeceg
var arrayThree: Array<Double> = Array()
var arrayFour: Array<Double> = []

var name = "Vuk"
var vuk = String("Vuk") //i string je struktura
var newName = vuk //zato sto je struktura ovde se radi o copy/paset-u tako da ne uticu na vrednosti jedna drugoj

var repeatingArray = Array(1...50) // [1,2,3,4,5,6,7,8,9,......,50]
var repaetingElementArray = Array(repeatElement("Vuk", count: 5)) // [Vuk, Vuk, Vuk, Vuk, Vuk]

// Set-ovi
var setOne: Set = [1,2,3,4,1,2,2,3,2,3,6] // setovi imaju neki random raspored, nije kao kod nizova
var setTwo: Set<String> = ["Vuk","vuk","wolf"]
var setThree = Set<String>()
var setFour = Set(["Vuk","vuk","wolf"])


var oddNumber: [Int] = []
var evenNumber: [Int] = []

//for number in 1...50 {
//    if number % 2 == 0 {
//        evenNumber.append(number)
//    } else {
//        oddNumber.append(number)
//    }
//}

//: Tertiary Operator umesto ovog gore izraza
for number in 1...50 {
    //tertiary operator
    (number % 2 == 0) ? evenNumber.append(number) : oddNumber.append(number)
}


// pretvaranje array-a u set
var oddNumberSet = Set(oddNumber)
var evenNumberSet = Set(evenNumber)

//: Union
print(oddNumberSet.union(evenNumberSet)) //[17, 41, 14, 20, 49, 30, 38, 3, 42, 32, 47, 28, 39, 34, 6, 46, 50, 12, 23, 25, 5, 7, 45, 43, 11, 37, 16, 2, 31, 26, 8, 40, 27, 24, 13, 19, 21, 9, 44, 35, 1, 10, 15, 29, 48, 33, 22, 18, 4, 36]
// Postoje jos Presek dva skupa, SymetricDifference je obrnuto od preseka, Subtracting ASkup.subtracting(BSkup) ostaje samo ono sto je jedinstveno za ASkup

// pretvaranje set-a u array
// 1) Native method sort()
let sortedArray = evenNumberSet.sorted()
// 2) Functional Programming
let sortedArrayFromHighToLow = evenNumberSet.sorted { $0 > $1 }
print(sortedArrayFromHighToLow) //[50, 48, 46, 44, 42, 40, 38, 36, 34, 32, 30, 28, 26, 24, 22, 20, 18, 16, 14, 12, 10, 8, 6, 4, 2]

// Setove koristimo za pronalazenje jedinstvenih slova, jedinstvenih posetilaca sajta, ...

/////TUPLES

let firstScore = (name: "Vuk", score: 9)
firstScore.0 //Vuk
firstScore.1 // 9
firstScore.name //Vuk
firstScore.score // 9


//Bonus tips
var dog = "dog", car = "cat"
print(dog) //dog
var (x,y,z) = (1,2,3)
print(x)
print(y)

var shoppingList = ["Eggs","Milk","Rice"]
shoppingList.enumerated()
for (index, value) in shoppingList.enumerated() {
    print(index,value) //0 Eggs 1 Milk 2 Rice
}

// Array
var total: Double = 0
func findTheMean(numbers: Double...) -> Double {
    
    for number in numbers { total += number }
    
    return total / Double(numbers.count)
    
}

findTheMean(numbers: 1, 3, 5, 7, 11) // 5.4
findTheMean(numbers: 1, 4, 8, 16, 25) // 16.2
findTheMean(numbers: 111, 222, 333) // 249


