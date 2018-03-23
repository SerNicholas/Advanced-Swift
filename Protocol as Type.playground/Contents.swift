import UIKit

// Protocol

protocol MathGenius {
    func calculate()
}

extension MathGenius {
    func calculate() {
        print("Prepametan za skolu!")
    }
}

struct Vuk: MathGenius {}

Vuk().calculate() //Prepametan za skolu!

class Vukovi: MathGenius {
    func calculate() {
        print("10")
    }
}

Vukovi().calculate()

// polimorfizam
protocol Povrsina {
    func izracunajPovrsinu(sirina: Double, visina: Double) -> String
}
extension Povrsina {
    func izracunajPovrsinu(sirina: Double, visina: Double) -> String {
        let povrsina = String(sirina * visina)
        return "Povrsina je \(povrsina)"
    }
}

struct Kvadrat: Povrsina {}
struct Hexagon: Povrsina {}
Kvadrat().izracunajPovrsinu(sirina: 4, visina: 10) //Povrsina je 40.0
Hexagon.init().izracunajPovrsinu(sirina: 6, visina: 10) //Isto sto i gore sa ovim init() i to je default varijanta


//: PROTOKOL KAO TIP PODATKA

let random: Any = [1,"String",["123"]]

protocol Human {
    var male: Bool { get }
    var origin: String { get }
}

extension Human {
    var male: Bool {
        return true
    }
}

struct Knezevic: Human {
    var origin: String = "Serbian"
}

struct Jordan: Human {
    var origin: String = "American"
}

let humans: [Human] = [Knezevic(), Jordan()]

for human in humans {
    print("Origin: \(human.origin)")
}


//: Protokol kao Generik
protocol Sleekable {
    var price: String { get }
}

struct Diamond: Sleekable {
    var price: String = "Veoma Skupocen"
}
struct Ruby: Sleekable {
    var price: String = "Skupocen"
}
struct Glass: Sleekable {
    var price: String = "Jeftino"
}

func statePrice<T: Sleekable>(enterGem: T){
    print("Cena je \(enterGem.price)")
}

statePrice(enterGem: Glass())
