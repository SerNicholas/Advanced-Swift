import UIKit

// Guard statement, ima svoj blok koda koji se izvrsava kada se uslov pokaze da nije tacan ili kad je postavljen uslov nil u optional binding-u.

func checkDrinkingAge() {
    let canDrink = true
    if canDrink {
        print("You can drink.")
// u komentaru je los princip kodiranja zbog grananja if/else petlji
//        if isHuman {
//            if isAlreadyDrunk {
//
//            } else {
//
//            }
//        } else {
//
//        }
    } else {
        print("Go home kid!")
    }
}

// primena gurad-a umesto gornjeg kodiranja

let iCanDrink = false
func checkDrinkingAges() {
    guard iCanDrink else {
        // ako je iCanDrink = true ignorisi ovaj guard blok koda
        // druga stvar je sto ne mora da se detaljno analizira metoda da ni se UHVATIO error
        print("You can not drink!")
        return
    }
    print("Go home kid!")
}

var ime: String? = "Vuk"
var slika: String? = "Vukova slika url"
var godine: Int? = nil

//NIKAD NE PISI KOD NA OVAJ NACIN
func unwrapOneByOne() {
    if let name = ime {
        if let image = slika {
            if let age = godine {
                print("\(name), \(image), \(age)")
            } else {
                print("nedostaju godine")
            }
        } else {
            print("nedostaje fotografija")
        }
    } else {
        print("nedostaje ime")
    }
}

//nesto bolje sa guard statement-om
func unwrapOneByOneWithGurad() {
    guard let name = ime else {
        // ako je IME nije nil, ignorisi blok
        // ako je IME nil, udji u guard-ov blok koda
        print("Nedostaje ime")
        return
    }
    
    guard let photo = slika else {
        print("Nedostaje fotografija")
        return
    }
    
    guard let age = godine else {
        print("Nedostaju godine")
        return
    }
    
    print(name)
    print(photo)
    print(age)
}

// Unwrap-ovanje visetrukih opcionala pomocu if/else
func unwrap() {
    if let name = ime, let photo = slika, let age = godine {
        print("Zoves se: \(name), slika: \(photo) i imas \(age) godina.")
    } else {
        print("Nesto nedostaje")
    }
}
unwrap()
// Ukoliko bilo sta od unwrpaovanih vrednoasti ne postoji, tj nil je, ovo ce odmah izvrsiti else granu, sto nam nekad neodgovora i zbog toga ovakava tehnika ima ogranicenje u primeni.

// Unwrap-ovanje visetrukih opcionala pomocu guard-a
func unwrapWithGuard() {
    guard let name = ime, let photo = slika, let age = godine else {
        print("Nesto nedostaje")
        return
    }
    print("Zoves se: \(name), slika: \(photo) i imas \(age) godina.")
}
unwrapWithGuard()

// Defer - pomocu ovoga se postize sledece ponasanje, a to je da se zbog primene ove sluzbene reci kod unutar defer bloka izvrsava posle svega naznacenog

func simpleDefer() {
    defer {
        print("Ovo je drugo!")
    }
    print("Ovo je prvo")
}
simpleDefer()

for i in 1...3 {
    defer {
        print("Deferovano \(i)")
    }
    print("Ovo pre deferovanog \(i)")
}
