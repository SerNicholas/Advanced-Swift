import UIKit

// Postoje tri vrste Enuma: Osnovni, Raw Valuse, Associated Values

// 1) Osnovni
enum Compas {
    case north
    case south
    case east
    case west
}

enum Planet {
    case merkur, venera, zemlja, mars, jupiter, saturn, uran, neptun, pluton
}

let earth = Planet.zemlja // ovako se pravi objekat kod enuma, dakle ovo je init
switch earth {
case .zemlja:
    print("Moja planeta")
default:
    print("Nije moja planeta")
}

// 2) Raw Value, Swift podrzava sledece tipove kao vrednosti enuma: Int, Float, String, Bool
enum Food: String {
    case pizza
    case banana
    case chicken
    case bigMac
}
let stringValueFromPizza = Food.pizza.rawValue // "pizza"

enum Days: Int {
    case pon, uto, sre, cet, pet = 10 , sub, ned
}
// pon = 0, uto = 1, sred = 2, cet = 3, pet = 10, sub = 11, ned = 12
let ponedeljak = Days.pon.rawValue // 0

// inicijalizacija objekta
let possibleDay = Days(rawValue: 10)
print(possibleDay) // Optional(__lldb_expr_122.Days.pet)
print(possibleDay!) // pet

if let someDay = Days(rawValue: 11) {
    switch someDay {
    case .sub, .ned:
        print("Vikend")
    default:
        print("Radni dani")
    }
} else {
    print("Nepostoji taj dan")
}


// 3) Associated Value

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
 // pravljenje objekta
var myQRCode = Barcode.qrCode("XYZ")
var upcCode = Barcode.upc(4, 2, 5, 5)

// VALIDACIJA primer upotrebe
if case let Barcode.qrCode(value) = myQRCode {
    print("Ovo je QR kod")
    print(value) // "XYZ"
}

if case let Barcode.upc(brojSistema, proizvodjac, proizvod, provera) = upcCode {
    print("Broj sistema je :\(brojSistema)") // Broj sistema je :4
    print("Proizvodjac je :\(proizvodjac)") // Proizvodjac je :2
    print("Proizvod je :\(proizvod)") // Proizvod je :5
    print("Provera je :\(provera)") // Provera je :5
}

// u pravoj situaciji bi se radilo ovako
let code = myQRCode
switch code {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case .qrCode(let productCode):
    print("QR code: \(productCode)") // QR code: XYZ
}

// ILI

switch code {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR code: \(productCode)") // QR code: XYZ
}


