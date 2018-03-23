import UIKit

//Convenience init, najbolje za neke open-source projekte

class Human {
    var name: String
    init(name: String){
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Vuk iOS Developer")
    }
}

let vuk = Human(name: "Vuk")
let knezevic = Human() //od convenience init-a
knezevic.name //Vuk iOS Developer

let randomColor = UIColor(displayP3Red: 255/80, green: 80/255, blue: 85/255, alpha: 1)

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

let myFavouriteColor = UIColor(r: 80, g: 85, b: 255)


// Computed properties

class NumberClass {
    var readableNumber: Double {
        get {
            return 1
        }
    }
    // isto sto i
    var readableNum: Double {
        return 1
    }
}
// NumberClass().readableNumber = 2 ovo ne moze jer se read-only property
// Ovo moze sa settable property-jem

var radius: Double = 10
var diameter: Double {
    get {
        return radius * 2
    }
    set {
        radius = newValue / 2 //ovde obrni vrednosti
    }
}

diameter        // 20
diameter = 30
diameter        // 20 opet zato sto je computed i cita radius koliki je iz getter-a

var stranaKvadrata: Double = 10
var povsinaKvadrata: Double {
    get {
        return stranaKvadrata * stranaKvadrata
    }
    set(novaStranaKvadrata) {
        stranaKvadrata = sqrt(novaStranaKvadrata)
    }
}

povsinaKvadrata = 9
stranaKvadrata // 3







