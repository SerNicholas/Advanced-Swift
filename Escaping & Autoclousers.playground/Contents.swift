import UIKit

//: Escaping and Autoclousers -> @escape & @autoclosures

// Memory managemnet in functions

var closureBlocks: [() -> Void] = []

func funcWithClosure(closure: @escaping () -> Void) {
    closureBlocks.append(closure)
    print("Function done")
}

// ako closure moze biti izvrsen nakon funkcijinog returna, odnosno nakon njenog zavrsetka, onda je neophodan @escaping


func funcWithNetworkingClosure(closure: @escaping () -> Void) {
    DispatchQueue.global().async {
        closure()
    }
    print("Function done")
}


// Normal function

class Normal {
    let name = "Vuk"
    
    func normalFuncWitClosure(closure: (String) -> Void){
        closure(self.name)
    }
}

Normal().normalFuncWitClosure { (ime) in
    print(ime)
}
// ovde nema retain cycle-a jer ce se closure dealocirati do trenutka dok se funkcija zavrsi, ne zivi posle returna funckcije


//: @autoclosure
func checkIDCard(hasCard: () -> Bool){
    if hasCard() {
        print("You have ID Card")
    }
}

checkIDCard { true }
checkIDCard(hasCard: { return true })
checkIDCard(hasCard: { true })

func checkIDCard(hasCard: @autoclosure () -> Bool){
    if hasCard() {
        print("You have ID Card")
    }
}

checkIDCard(hasCard: true)


///: LAZY INIT CAPTURE

class Greet {
    var name = "Vuk iOS Developer"
    
    lazy var greeting: String = {
        return "Hello, \(self.name)" //lazy var je non-escaping po default -u tako da ne postoji retain cycle
    }()
    
    deinit {
        print("Deallocated")
    }
}


var greet: Greet? = Greet()
greet?.greeting
greet = nil //deinicijalizovano

