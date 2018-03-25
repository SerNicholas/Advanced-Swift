import UIKit

protocol FamilyProtocol {
    associatedtype familyType = Int
    var familyMember: [familyType] {get set}
}

struct NumberFamily: FamilyProtocol {
    var familyMember: [Int] = [1 ,2, 3]
}

let numberFam = NumberFamily() // ovde je associatedtype tipa Int

// sad overrideovanje
struct NormalFamily: FamilyProtocol {
    typealias familytype = String // ovde je associatedtype tipa String
    var familyMember = ["Vuk", "Knez"]
}

// Primena generickog protokola na genericku strukturu
struct MyFamily<T>: FamilyProtocol {
    var familyMember: [T] = []
}
let family = MyFamily(familyMember: ["Vuk","Knez","Ja"])
// 1. T postaje String
// 2. associatedtype postaje String zbog T
