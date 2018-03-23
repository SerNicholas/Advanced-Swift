import UIKit

//: Automatic Reference Counting

// Problem je dealocirati i alocirati objekte pomocu ARC
// Memory management se obicno odnosi na RAM

class Passport {
    weak var human: Human?
    let citizenship: String
    
    init(citizenship: String) {
        self.citizenship = citizenship
        print("\(citizenship) passport generated")
    }
    
    deinit {
        print("Passport \(citizenship) dealociran")
    }
}

class Human {
    var passport: Passport?
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) generated")
    }
    
    deinit {
        print("Human \(name) dealociran")
    }
}

// on je inicijalizovan i odmah deinicijalizovan jer nema svojih instanci, tj nema referenci
// Passport(citizenship: "Srbija")

// ovaj je samo inicijalizovan jer je ovo referneca objekta, tj njegova instanca
// let passport = Passport(citizenship: "Serbia")

var vuk: Human? = Human(name: "Vuk") // Vuk generated
var passport: Passport? = Passport(citizenship: "Serbia") // Serbia passport generated
vuk = nil // Human Vuk dealociran
passport = nil // Passport Serbia dealociran

// sa ovim postavljanjem nil, ne gubi se objekat nego referenca na taj objekat

// Ako je broj instanci objekta (broj referenci) jednak nuli ili nema veza ni sa jednim drugim objektom, taj objekat se gubi iz memorije



var bob: Human? = Human(name: "Bob") // Bob generated
var bobPassport: Passport? = Passport(citizenship: "Island") // Island passport generated

bob?.passport = bobPassport
bobPassport?.human = bob

// ako nema WEAK na objektnoj refernci na drugi objekat nema ni dealociranja referenci jer i dalje postoje dve reference koje idu iz samih objekata jedan ka drugom, zato se i ne poziva print deinita, i ove dve reference ostaju zauvek i ovo se zove MEMORY LEAK ili RETENTION CYCLE i resava se dodavanjem WEAK na logicno mesto
bob = nil // zbog toga sto je weak u PASSPORT objektu zbog ovoga bob = nil se dogadja deinicijalizacija
bobPassport = nil // ovim se deiniscijalizacije ne bi desila



