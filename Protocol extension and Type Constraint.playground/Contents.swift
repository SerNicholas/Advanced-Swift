import UIKit

// Protocol extension and type extension

// Genericka funkcija
class SClass {}
func generickaFunkvija<T: SClass>(array: [T]) { }
generickaFunkvija(array: [SClass()])

// Genericki protokol
protocol GenericProtocol {
    associatedtype myType
}

class SomeClass: GenericProtocol {
    typealias myType = String
}

struct SomeStruct: GenericProtocol {
    typealias myType = Int
}

extension GenericProtocol where myType == String {
    static func introduce() {
        print("Cao")
    }
}

SomeClass.introduce()
// SomeStruct.introduce() // ovde sad ne moze da se primeni introduce() iz ekstemzije protokola jer ekstenizja ima ogranicenje da je myType samo string

extension GenericProtocol where Self == SomeStruct {
    static func sauSomething() {
        print("Ja sam struktura")
    }
}

// Predefinisan Associated type
protocol FamilProtocol {
    associatedtype familyType = Int // ne treba radito ovo, nepotrebno je
    var familyMembers: [familyType] {get set}
}

struct NumberFamily: FamilProtocol {
    var familyMembers: [Int] = [1, 3, 4]
}
struct StringFamily: FamilProtocol {
    var familyMembers: [String] = ["1", "3", "4"]
}
