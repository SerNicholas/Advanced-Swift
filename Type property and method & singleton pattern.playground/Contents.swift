import UIKit

// Struct - static only
struct SomeStruct {
    static var storedProperty = "Some value"
    static var computedProperty: Int {
        get {
            return 120
        }
        set{
            print("Setovao si novu vrednost: \(newValue)")
        }
    }
    static func hello(){
        print("hello")
    }
}

SomeStruct.storedProperty
SomeStruct.computedProperty
SomeStruct.hello()

//static bi se pre odnosilo na strukture, dok bi u klasama bilo bolje koristiti class, jer static u klasi ne moze da se override-uje

class GrandPerent {
    static var yearsInMarriage = 30
    static func introduce() {
        print("U braku smo \(yearsInMarriage) godina")
    }
    class func introducing() {
        print("U braku smo \(yearsInMarriage) godina")
    }
    //ovo nije type objekat, vec "normalan", dakle mora da se napravi instanca klase
    final func cantOverride() {
        print("Mene ne mozes da overridujes zbog reci final")
    }
}

class Parent: GrandPerent {
    override class func introducing() {
        print("U braku smo 5 gofdina")
    }
    
    //ovo ne moze da se overriduje
    
//    override class func introduce() {
//        print("U braku smo 5 gofdina")
//    }
    
}

GrandPerent.introducing()



/////////////////////// Primena

struct BluetoothID {
    struct iPhone {
        static let iPhone4 = "3452345"
        static let iPhone5 = "4567567"
        static let iPhone6 = "8758754"
        static let iPhone7 = "1293844"
        static let iPhone8 = "8743446"
    }
    
    struct Andriod {
        static let lg = "678678678"
        static let samsung = "456456456"
        static let motorola = "678455"
        static let alcatel = "3453467"
        static let lenovo = "80878546"
    }
}

BluetoothID.iPhone.iPhone4 //3452345
BluetoothID.Andriod.alcatel

///  SINGLETON PATTERN
// Singleton je objekat koji je samo jednom instanciran u aplikaciji

class AccountManager {
    
    var userInfo = (ID: "knez_vuk", password: "Test123")
    func network() {
        // get something
    }
    
    private init() {
        print("Kreiran singleton")
    } // ovim se postavlja da je instanciranje ove klase moguce jedino unutar nje same, jer private init nije dostupno van ove klase,a pomocu njega se inicijalizuje
    
    static let sharedInstance = AccountManager() // a ovaj staticki property mu daje pristup spolja, asingleton se kreira kad se prvi put pristupi nekom od njegovih propertija ili metoda i on se nikada ne allocira
    
    //Takvi su UIApplication, NSNotification, UserDefault
}

AccountManager.sharedInstance.userInfo
AccountManager.sharedInstance.userInfo.ID // knez_vuk
AccountManager.sharedInstance.userInfo.ID = "vuk_knez"
AccountManager.sharedInstance.userInfo.ID // vuk_knez





















