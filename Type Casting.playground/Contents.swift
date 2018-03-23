import UIKit

// Upcasting se dogadja kada se ide sa nizeg na visi nivo i koristi se sluzbena rec (as), npr
let label = UILabel() as UIView

// Downcasting se dogadja kada se ide sa viseg na nizi nivo i koriste se slubene reci (as! , as?)
var name = "Vuk" as Any // upcasting
var number = 20 as Any // upcasting
var anyArray = [name, number]

let downcastValue = anyArray[1] as! Int // explicit/force downcasting, unsafe version
let downcastValue2 = anyArray[1] as? Int // implicit/safe downcasting

class Human {
    func walk() {
        print("Step, Step, Step,...")
    }
    
    func talk() {
        print("Bla, Bla,....")
    }
}

class French: Human {
    func bonJour() {
        print("Bon Jour!")
    }
}

class English: Human {
    func greeting() {
        print("Good day!")
    }
}

let jon = English()
let zan = French()
let bob = English()
let zack = French()

let humans: [Human] = [jon, zan, bob, zack]

for human in humans {
    if let french = human as? French {
        french.bonJour()
    }
    if let english = human as? English {
        english.greeting()
    }
}
