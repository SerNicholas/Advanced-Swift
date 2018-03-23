import UIKit

class Venchile {
    
    var description: String {
        return "30 km/h"
    }
    
    func warning() {
        print("Too fast")
    }
}


class ToyCar: Venchile {
    override var description: String {
        return "\(super.description) is too fast for toy car"
    }
}

ToyCar().description
ToyCar().warning()


// override init method
class Human {
    var origin: String
    init(enterOrigin: String){
        origin = enterOrigin
    }
}

Human(enterOrigin: "Serb")

class Serb: Human {
    var city: String
    init(enterCity: String){
        self.city = enterCity
        super.init(enterOrigin: "Serb") //bez ovoga se bunio jer nismo inicijalizovali property ORIGIN
    }
    init(enterCity: String, origin: String){
        self.city = enterCity
        super.init(enterOrigin: origin)
    }
}

let vuk = Serb(enterCity: "Belgrade")
let knezevic = Serb(enterCity: "Belgarde", origin: "Serb")

class Tesla {
    var numberOFWheels: Int
    init(enterWhelNumber: Int){
        numberOFWheels = enterWhelNumber
    }
}

class ModelS: Tesla {
    override init(enterWhelNumber: Int) {
        super.init(enterWhelNumber: enterWhelNumber)
        print("Super masina")
    }
}

let modelsS = ModelS(enterWhelNumber: 50)



//Two phase init
// Kako da init jedne metode inicijalizuje drugu metodu
struct NuclearRocket {
    var meters: Double
    var liters: Double
    init(meters: Double, liters: Double){
        self.meters = meters
        self.liters = liters
    }
    init(ft:Double, gallon: Double) {
        let convertedMeters = ft / 3.28
        let convertedLiters = gallon * 3.78
        self.init(meters: convertedMeters, liters: convertedLiters)
    }
}

var rocket = NuclearRocket(meters: 20, liters: 20)
var rocket2 = NuclearRocket(ft: 35, gallon: 35)
