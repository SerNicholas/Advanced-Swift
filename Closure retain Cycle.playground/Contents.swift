import UIKit

//: CLOSURE RETAIN CYCLE

// Kako koristiti CAPTURE LISTS da bi se sprecio retain cycle u klozerima
// Kada koristiti UNOWNED

class VukClass {
    var vukClosure: (() -> ())?
    var name: String = "Vuk"
    
    init() {
        vukClosure = { [unowned self] in // ovim  [weak self] se eliminise retain cycle, tj [unowned self] eliminise retain cycle samo sto ne pravi opcional kao weak sto radi, ponasa se kao da unwrapovanje u pitanju, tako da moramo biti 100% sigurni da sama klasa nece biti deinicijalizovana, [weak self] je sigurniji pristup
            print("\(self.name) iOS Developer") // ovim self.name je i iz objekta klozera postavljena referenca na objekat VukClass i zbog toga ce se desiti retain cycle
        }
    }
    
    deinit {
        print("VukClass deinited")
    }
}

var vukClass: VukClass? = VukClass()
vukClass?.vukClosure!() // () zagrade su izvrsenje clousera
// Clouser ima referencu na blok clouser-a, a to je u ovom slucaju print("Vuk iOS Developer"), a to ne pripada klasi vec ima drugu memorijsku lokaciju

vukClass = nil

//: Otkrivanje retain cycle u clouser block-u pomocu app Instrument !!!


// primer za weak i unwoned
class Owner {
    var creditCard: CreditCard?
    deinit {
        print("Owner gone!")
    }
}

class CreditCard {
    unowned let owner: Owner
    init(enterOnwer: Owner) {
        owner = enterOnwer
    }
    deinit {
        print("Card gone")
    }
}

var vuk: Owner? = Owner()
var vukCard: CreditCard? = CreditCard(enterOnwer: vuk!)
vuk?.creditCard = vukCard

vuk = nil // deinit onwera se desio
// vukCard?.owner // ovde se desava closure retain cycle
vukCard = nil // deinit card se desio


