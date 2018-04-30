import UIKit

// Equatable and Comparable Protocol

5 == 5 // 5 je objekat Int-a // true
"Vuk" == "Vuk" // true

struct Random {}
//Random() == Random() ne moze jer nije podvrgnuto Equatable

struct Blog {
    let author: String
    let title: String
}

extension Blog: Equatable {
    static func == (lhs: Blog, rhs: Blog) -> Bool {
        return true
    }
}

// swiftdoc.org -> procitaj
Blog(author: "Vuk", title: "Vukovi") == Blog(author: "V", title: "V") //ovo vraca true jer sam mu u static func rekao da sve vrati kao true



// Custom Tuple
struct GridPoint {
    var grid: (Int, Int)
    init(_ numberOne: Int, _ numberTwo: Int) {
        grid = (numberOne, numberTwo)
    }
}

// GridPoint(1, 2) == GridPoint(1, 2)   Ne moze jer nije Equatable primenjen

extension GridPoint: Equatable {
    static func == (lhs: GridPoint, rhs: GridPoint) -> Bool {
        return lhs.grid.0 == rhs.grid.0 && lhs.grid.1 == rhs.grid.1
    }
}
GridPoint(1, 2) == GridPoint(1, 2) // true

enum OS {
    case iOS
    case android
}

// ne moze jer nije primenjen protokol Comparable
//OS.iOS > OS.android
//OS.iOS < OS.android

/* // Comparable
 static func < (lhs: Self, rhs: Self) -> Bool
 static func <= (lhs: Self, rhs: Self) -> Bool
 static func >= (lhs: Self, rhs: Self) -> Bool
 static func > (lhs: Self, rhs: Self) -> Bool
*/

extension OS: Comparable {
    static func < (lhs: OS, rhs: OS) -> Bool{
        return lhs < rhs
    }
    static func <= (lhs: OS, rhs: OS) -> Bool{
        return lhs <= rhs
    }
    static func >= (lhs: OS, rhs: OS) -> Bool{
        return lhs >= rhs
    }
    static func > (lhs: OS, rhs: OS) -> Bool{
        return lhs > rhs
    }
}

OS.iOS > OS.android
OS.iOS < OS.android

