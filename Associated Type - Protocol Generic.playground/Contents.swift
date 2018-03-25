import UIKit

/*:
# Assosiated type - Generic Prottocol
*/

// Tip mora biti definisan pre kompajliranja


// Genericka struktura
struct GenericStruct<T> {
    var property: T?
}
let eksplicitno = GenericStruct<Bool>() // T postaje Bool
let implicitno = GenericStruct(property: "Vuk") // T postaje String

// Normalni protokol
protocol NormalProtocol {
    var property: String { get set } // ovim smo ogranicili klase koje ce se pozovati na ovaj protokol, da imaju promanljivu - property - tipa string
}

// Genericki protokol
protocol GenericProtocol {
    associatedtype myType
    var anyProperty: myType { get set }
}

struct SomeStruct: GenericProtocol {
    var anyProperty = 100 // sad je myType postao Int
}
struct SomeOtherStruct: GenericProtocol {
    var anyProperty = "Vuk" // sad je myType porsto String
}
struct ExplicitStruct: GenericProtocol {
    typealias myType = Bool
    var anyProperty = true
}
