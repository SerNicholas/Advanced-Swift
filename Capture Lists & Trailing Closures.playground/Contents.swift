import UIKit

//: CAPTURE LIST - functional swift

var a = 0
var b = 0

//design closure
let newClosure = { print(a,b) } //() -> ()
newClosure // (0,0)

var closureArray: [() -> ()] = []
var i = 0

for _ in 1...5 {
    closureArray.append {
        print(i)
    }
    i += 1
}

closureArray[0]() // () omogucava izvresnje na kraju ovog niza kada se dopise; rezultat je 5
closureArray[1]() // 5
closureArray[2]() // 5
closureArray[3]() // 5
closureArray[4]() // 5

//svuda je rezultat 5 zato sto je [i] na kraju petlje promenjeno u 5, a sam CLOSURE je REFERENTNOG tipa, tako da kao referenca, menjace svoju vrednost prema poslednjoj promeni

var c = 0
var d = 0
let smartClosure: () -> () = {
    () in
    print(c, d)
}
smartClosure() //ovo je izvrsilo stampanje i dobili smo 0, 0
c = 9
d = 9
smartClosure() // dobili smo 9,9 jer smartClosure ima referencu na promenljive c i d

// CAPTURE LIST
let smarterClosure: () -> () = { [c, d] in //ovo je dodatak kojim closure postaje VALUE tip
    print(c, d)
}

smarterClosure() // 9,9

c = 10
d = 10

smarterClosure() // 9,9  ovaj se ponasa kao value type
smartClosure() // 10,10 ovaj se ponasa kao reference type


// Design closure array
var smartClosureArray: [() -> ()] = []
var j = 0

// capture list array
for _ in 1...5 {
    smartClosureArray.append {
        [num = j] in
        print(num)
    }
    j += 1
}



smartClosureArray[0]() // 0
smartClosureArray[1]() // 1
smartClosureArray[2]() // 2
smartClosureArray[3]() // 3
smartClosureArray[4]() // 4





//: TRAILING CLOSURES

// koristili bi ga jer je closure preveliki da bi se preneo preko f-je

func trailingClosure(number: Int, closure: () -> Void) {
    print("Unet je broj \(number)")
    closure() // zagrade znace izvrsi
}

// napravimo closure blok
func closureFuncBlock() -> Void {
    print("Pozdrav Klozer Funkciji")
}

let closureBlock = {
    print("Pozdrav Klozer Bloku")
}

// prenosenje closer-a indirektno
trailingClosure(number: 100, closure: closureFuncBlock)
trailingClosure(number: 100, closure: closureBlock)

// prenosenje closer-a direktno
trailingClosure(number: 100, closure: { print("Pozdrav") })
trailingClosure(number: 100) {
    print("Pozdrav") // ignorise parametar a u sustini je identican ovm iznad
}

// novi primer
func noviPrenosKlozera(broj: Int, klozer: (Int) -> Int) {
    let num = klozer(broj)
    print(num)
}

noviPrenosKlozera(broj: 10, klozer: {br in br * br }) //rezultat je 100, jer klozer obezbedjuje broj, to mu je result type, a sam klozer obavlja funkcionalnost kvadriranja, to se prosledjuje funkciji koja od rezultata klozera pravi promenljivu NUM koju printa

noviPrenosKlozera(broj: 5) { (noviBroj) -> Int in
    noviBroj * noviBroj
} // 25

noviPrenosKlozera(broj: 3) { $0 * $0 } // 9


















