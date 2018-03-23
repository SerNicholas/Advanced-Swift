import UIKit

//: Mapiranje

// Treba pretvoriti [1, 2, 3, 4, 5] u [1, 4, 9, 16, 25]

// Ne-funkcionalni pristup
var kvadrati: [Double] = []
var brojevi = [1.0, 2.0, 3.0, 4.0, 5.0]
for broj in brojevi {
    kvadrati.append(broj * broj)
}
kvadrati // [1, 4, 9, 16, 25]

print(brojevi.map { $0 * $0 }) // [1.0, 4.0, 9.0, 16.0, 25.0]


// NeGenericki Map
func myMap(numbers: [Double], operationLogic: (Double) -> Double) -> [Double] {
    var result: [Double] = []
    for number in numbers {
        let transformedValue = operationLogic(number)
        result.append(transformedValue)
    }
    return result
}

myMap(numbers: [1,2,3,4,5], operationLogic: { $0 * $0 })
print(myMap(numbers: [1,2,3,4,5], operationLogic: { $0 * $0 })) // [1.0, 4.0, 9.0, 16.0, 25.0]


// Genericki Map
func myMapGeneric<T>(elements: [T], operationLogic: (T) -> T) -> [T] {
    var result: [T] = []
    for element in elements {
        let transformedValue = operationLogic(element)
        result.append(transformedValue)
    }
    return result
}

// Primeri

// 1 - mala slova
let upperLetters = ["VUK","KNEZ","VK"]
func umanjiSlovaKlozer(rec: String) -> String { // OVO JE KLOZER AKO SE NE STAVE ZAGRADE  umanjiSlovaKlozer(), bez ovih malih zagrada je klozer
    return rec.lowercased()
}
print(myMapGeneric(elements: upperLetters, operationLogic: umanjiSlovaKlozer))


//: ### Ekstremni Generik
func genericMap<T, U>(_ elements: [T], _ logic: (T) -> U) -> [U] {
    var result: [U] = []
    for element in elements {
        result.append(logic(element))
    }
    return result
}

// 2 - Prebaci Int u String
func convertNumberToString(number: Int) -> String {
    return String(number)
}
let myNumbers = [1,2,3,4,5]
print(genericMap(myNumbers, convertNumberToString))


// najbolje koriscenje
extension Array {
    func mojeMapiranje<U>(_ logika: (Element) -> U) -> [U] {
        var result: [U] = []
        for item in self {
            result.append(logika(item))
        }
        return result
    }
}

let finalResult = Array(1...10).mojeMapiranje { $0 * 10 }
print(finalResult) // [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]


















