import UIKit

struct Pozdrav {
    func reciNesto() -> String {
        return "Nesto"
    }
}

Pozdrav().reciNesto()

// Uvodjenje Subscripta

struct Dani {
    var dani = ["Ponedeljak", "Utorak", "Sreda", "Cetvrtak", "Petak"]
    
    subscript(index: Int) -> String {
        return dani[index]
    }
}

let dan = Dani()
dan.dani[0]
dan[0] //umesto dan.dani[0]

struct Covek {
    var info = ["Visina": 183, "Masti": 12.5, "Masa": 87]
    
    subscript(key: String) -> Double {
        if let newInfo = info[key] {
            return newInfo
        } else {
            return 0
        }
    }
}

let covek = Covek()
let visina = covek["Visina"]
let visinaBezSubscripta = covek.info["Visina"]
let stopalo = covek["Stopalo"]
