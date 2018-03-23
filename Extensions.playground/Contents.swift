import UIKit

struct Vuk {
    var name = "Vuk"
    var skill = "Work"
    
    init() {}
}

Vuk().name // Vuk

extension Vuk {
    //var description: String = "iOS" ne moze ovako u extenstion
    var description: String {
        let myWork = self.skill
        return "iOS \(myWork)"
    }
    
    init(enterSkill: String) {
        self.skill = enterSkill
    }
}

Vuk().description // iOS Work

let vuk = Vuk(enterSkill: "Development")
print(vuk.description) //iOS Development


//Extenzije Swift tipovima podataka
extension Int {
    var squared: Int {
        return self * self
    }
}
let num = 10
num.squared // 100

// u ekstenzijama se ne moze imati stored propery, samo moze computed property (instance property i type Property, tj propery nase klase i property swift-ovih tipova podataka)
// mogu se definistati instance (nase) metode i type metode
//mogu se obezbedtiti novi inicijalizatori tj konstruktori inicijalizacije
//mogu se definisati subscripti
//mogu se definisati novi NESTED tipovi pomocu enum/struct
//moze se postojeci tip podvrgnuti nekom protokolu

