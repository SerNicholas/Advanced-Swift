import UIKit

// Unary operators (ovo su u stavri f-je)
true
false

// Binary operators
1 + 2
4 == 4
1 / 4
5 % 2

// Ternary operators
let iCanDrink = false
iCanDrink ? print("Da") : print("Ne")


// Unwraping Optionals
var age: Int? = nil
var defalutAge: Int = 20

var finalUserAge = Int() // istop sto i 0

if age != nil {
    finalUserAge = age!
} else {
    finalUserAge = defalutAge
}
// ili drugacije napisano   // non nil coalescing
finalUserAge = age ?? defalutAge


//Operatori mogu da se naprave i da budu custom, tj da npr 2 ** 3 bude 8 ili 2 ** 4 bude 16


//: TYPEALIAS

//typealias za String
typealias Naziv = String

func insertName(name: Naziv) {
    print(name)
}

//typealias za klasu
class Zaposlen {}
typealias MojiZaposleni = [Zaposlen]
func listOfEmployees(enterEmployees: MojiZaposleni){}
listOfEmployees(enterEmployees: [Zaposlen(),Zaposlen()])


//typealias za tuple
typealias GridPoint = (Int, Int)
func enterPoint(grid: GridPoint) {
    print(grid.0)
    print(grid.1)
}
enterPoint(grid: (1, 2))


//type definicije
let arrayOne: Array<String> = Array()
arrayOne.isEmpty

let dictOne: [String:Int] = ["Vuk":1, "Knezevic":2]
let dictTwo: Dictionary<String,Int> = ["Vuk":1, "Knezevic":2]

var optionalOne: String?
var optionalTwo: Optional<String>








