import UIKit

//: Create UI Components
let box: UIView = {
    let view = UIView()
    return view
}()

let buttonSize = CGRect(x: 0, y: 0, width: 100, height: 100)

//ViewControlerOne bez closera
let btn1 = UIButton(frame: buttonSize)
btn1.backgroundColor = .black
btn1.titleLabel?.text = "Submit"
btn1.titleLabel?.textColor = .white

//ViewControlerTwo bez closera
let btn2 = UIButton(frame: buttonSize)
btn2.backgroundColor = .black
btn2.titleLabel?.text = "Logout"
btn2.titleLabel?.textColor = .white


//: Create button with function bez closera
func creatButton(enterTitle: String) -> UIButton {
    let btn1 = UIButton(frame: buttonSize)
    btn1.backgroundColor = .black
    btn1.titleLabel?.text = "Submit"
    btn1.titleLabel?.textColor = .white
    return btn1
}
creatButton(enterTitle: "Login")

//: Nekonvencijalni nacin sa closure-om
struct Human {
    init(){
        print("ja sam covek")
    }
}

let createHuman = { () -> Human in
    let human = Human()
    return human
}()

// sad analogija sa kreiranjem view-a
let myView = { () -> UIView in
    let view = UIView()
    view.backgroundColor = .black
    return view
}()

//: closure se buni ako nema unutrasnjeg tipa ( let myView = { () -> UIView in ...) ili spoljasnjeg tipa ( let myView: UIView = {...} )

let myView2: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    return view
}()


//: SADA O LAZY INIT-u
class IntenseMathProblem {
    //ovo je opet closure block, samo sto je skraceno za (return 1 * 1)
    var notComplexNumber: Int = { // ovaj postoji odmah prilikom inicijalizacije
        1 * 1
    }()
    lazy var complexNumber: Int = { // ovaj postoji tek kada mu posle inicijalizacije pristupimo, do tada je nil
        1 * 1
    }()
}

let problem = IntenseMathProblem()
problem.complexNumber


class SortFromDataBase {
    // Data
    lazy var sortNumberFromDatabase: [Int] = {
        [1,2,3,4,5,6,7,8,9]
    }()
}
SortFromDataBase().sortNumberFromDatabase // npr zgodno je kod rada sa bazama, da se ima informacija o nekom propertyju tek kada je on potreban

// takodje je zgodno kod kompresije slika zbog trosenja resursa
class CompressionManager {
    lazy var compressedImage: UIImage = {
        let image = UIImage()
        // kompresuj sliku
        // neka logika
        return image
    }()
}

// ne moze da se koristi LAZY sa LET property-jima
// ne moze se koristiti kod computed property-ja zato sto se ono konstantno preracunava
// moze samo da se koriti kod property-ja struktura i klasa
