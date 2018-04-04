import UIKit

// Da li se i kada nudi ugovor na neodredjeno
// Da li plata ide na belo
// Postoji li mogucnost da plata ide preko agencije
// Da li se prekovremeno radi
// Da li se radi vikendom
// Kako se obracunava prkovremeni rad
// Na kojim se masinama radi
// Postoji li senior koji vodi projekat
// Kako se obracunava godisnji odmor, s obzirom da bih prelazio u trenutku kada se blizi leto, a nece proci zakonski period kad moze da se koristi godisnji
// Da li postoji privatno zdravstveno osiguranje

// # 1 #
// Retain cycle je stanje kada dva objekta imau reference jedan prema drugome, koje zadrzavaju, tako da zadrzavaju jedan drugog i nije moguce izvrsiti deinicijalizaciju objekata.

// # 2 #
// DEFER omogucuje da se kod koji se nalazi u njegovom bloku, izvrsi poslednji u okviru bloka u kom se poziva DFFER

// # 3 #
// Computed property koristi stored property da bi dobio svoju vrednost i eventualno izmenio vrednost stored propertija
    var radius: Double = 2
    var diametar: Double {
        get {
            return radius * 2
        }
        set {
            radius = newValue / 2
        }
    }

// # 4 #
// Type propertiji su oni koji se pozivaju preko klase ili strukture, ne mora da se pravi instanca objekta, a i ne mogu da se zovu preko instance objekta. Definisu se sluzbenim recima STATIC i CLASS. STATIC se ne moze overrideovati, a CLASS se ne moze primanjivati kod struktura

// # 5 #
// Singleton pattern je objekat koji je samo jednom instanciran u aplikaciji
    class Singleton {
        static let shared = Singleton()
        private init() {}
    }

// # 6 #
// Upcasting se dogadja kada se ide sa nizeg na visi nivo i koristi se sluzbena rec (as), npr
    let label = UILabel() as UIView
// Downcasting se dogadja kada se ide sa viseg na nizi nivo i koriste se slubene reci (as! , as?)
    let anyArray: [Any] = ["name", 1]
    let explicitDowncasting = anyArray[0] as! String
    let implicitDowncasting = anyArray[1] as? Int

// # 7 #
// Koriscenje subscripta moze biti precica prilikom koriscenja nekog collectiona iz objekta
    struct Covek {
        var info = ["Visina": 183, "Masti": 12.5, "Masa": 87]
        subscript(key: String) -> Double {
            if let newInfo = info[key] {
                return newInfo
            } else {
                return 0
            }
        }
    }

    let covek = Covek()
    let visina = covek["Visina"] // 183
    let visinaBezSubscripta = covek.info["Visina"] // 183
    let stopalo = covek["Stopalo"] // 0

// # 8 #
// Array je genericka struktura. String je genericka struktura
    var niz: Array<Double> = Array()

// # 9 #
// Ternary operator, operator koji ima tri dela
    var dvojka = (0 == 0) ? 2 : 10000 // 2

// # 10 #
// Setove koristimo za pronalazenje nekih jedinstvenih vrednosti.

// # 11 #
// U ekstenzijama se ne mogu definisati propertiji na klasican nacin, sve drugo moze
    struct NekaStruktura {
        var ime = "Petar Petrovic"
        var posao = "iOS Developer"
        init() {}
    }
    extension NekaStruktura {
        var opis: String {
            return "\(ime) - \(posao)"
        }
        init(dodatniInitZbogNovogPosla: String) {
            self.posao = dodatniInitZbogNovogPosla
        }
    }
    NekaStruktura().opis // Petar Petrovic - iOS Developer

// # 12 #
// Error handling se koristi umesto masivnog else/if koda
    enum GreskaCitanjaLicneKarte: Error {
        case nemaAdrese
        case nepostojiBrojLicneKarte
    }
    struct LicnaKarta {
        var adresa: String
        var brojLicneKArte: Int
        
        init(adresa: String, brojLK: Int?) throws {
            if adresa == "" {
                throw GreskaCitanjaLicneKarte.nemaAdrese
            } else if brojLK == nil {
                throw GreskaCitanjaLicneKarte.nepostojiBrojLicneKarte
            } else {
                self.adresa = adresa
                self.brojLicneKArte = brojLK!
            }
        }
    }
    do {
        _ = try LicnaKarta(adresa: "Njegoseva", brojLK: 2342341)
    } catch GreskaCitanjaLicneKarte.nemaAdrese {
        print("Unesi adresu")
    } catch GreskaCitanjaLicneKarte.nepostojiBrojLicneKarte {
        print("Unesi broj licne karte")
    }

// # 13 #
// OPEN - najotvoreniji vid access kontrole. Mogu da pravim subklase u mom modulu iako su nadklase u drugom modulu.
// PUBLIC - isto sto i OPEN samo sa nesto ogranicenijim pristupom. Moze se override-ovati samo u subclassama koje su unutar modula u kom je i nadklasa
// INTERNAL - defaultni access kontrol. Ne pise se jer se podrazumeva, a moze se dodati. Klase su dostupne samo unutar svog modula.
// FILEPRIVATE - metode i property-ji su dostupni unutar samo jednog swift file-a.
// PRIVATE - najveca kontrola pristupa. Metode i property-ji se mogu koristiti samo unutar naznacene klase.

// # 14 #
// Convenience init - init koji ima potpis onako kako nam odgovara, ali se mora pozvati originalni init unutar convenience bloka koda
            //convenience init(customParametar: Any) {
            //    self.init()
            //}


// # 15 #
// Two phase init - Dvofazni init - jednim initom pozivamo i drugi init
    struct Put {
        var metara: Double
        init(metara: Double) {
            self.metara = metara
        }
        init(stopa: Double) {
            let uMetre = stopa / 3.28
            self.init(metara: uMetre)
        }
    }

// # 16 #
// Property Observer
    var ocena: Int = 10 {
        willSet {
            print(newValue) // zove se pre nego sto se promeni u newValue
        }
        didSet {
            print(oldValue) // zove se posto se promeni vrednost ocene
        }
    }

// # 17 #
// Failable init
    class Blog {
        let name: String
        init?(name: String){ //zbog ovog opcionala postaje failable initializator
            if name.isEmpty {
                return nil
            }
            self.name = name
        }
    }

// # 18 #
// Grand Central Dispatch - thread pool pattern - nacin kako se lakse radi sa multitaskingom
// telefon operise sa ove dve niti, a vecinu stvari obavlja main thread
    let main = DispatchQueue.main // defaultni glavni
    let background = DispatchQueue.global() // defaultni pozdainski
// Serijski redovi (serial queue) obavljaju jedna po jedan zadatak i mogu se koristiti za sinhronizovani pristup nekom resursu
// Paralelni redovi (concurrent queue) obavljaju jedan ili vise zadataka istovremeno u zavisnosti od kompleksnosti zadataka
let serialCustomQueue = DispatchQueue(label: "custom_queue_serial", qos: .userInitiated)
let concurrentCustomQueue = DispatchQueue(label: "paralelni_red", qos: .utility, attributes: .concurrent)

// Sinhrono izvrsenje zadataka ceka da on bude gotov pre nego sto oslobodi kontrolu, DAKLE CEKA NA IZVRSENJE SVOG BLOKA
// Asinhrono izvrsenje zadatka ne ceka da on bude gotov vec odmah oslobadja kontrolu

//: Performing background tasks and then updating the UI
        DispatchQueue.global(qos: .background).async {
            //background work
            DispatchQueue.main.async {
                //update UI
            }
        }
// Oprez
        //: Beware of deadlocks with serial queue
        let customSerialQueue = DispatchQueue(label: "com.yogevsitton.MyApp.myCustomSerialQueue")
        customSerialQueue.sync {
            // Synchronous code
            //    customSerialQueue.sync {
            //        // This code will never be executed and the app is now in deadlock
            //    }
        }

        //: Beware of Synchronously running on the main thread from a synchronous background thread
        DispatchQueue.global(qos: .utility).sync {
            // Background Task
            //    DispatchQueue.main.sync {
            //        // App will crash
            //    }
        }

// # 19 #
// lazy var je non-escaping po defaultu i kod njega nema retain cycle

// # 20 #
// CAPTURE LIST se korsiti da bi se sprecio retain cycle u klozerima
class NekaKlasa {
    var klozer: (() -> Void)?
    var ime = "Neki naziv"
    
    init () {
        klozer = { [unowned self] in // ovim  [weak self] CAPTURE LIST-om, se eliminise retain cycle, tj [unowned self] eliminise retain cycle samo sto ne pravi opcional kao weak sto radi, ponasa se kao da unwrapovanje u pitanju, tako da moramo biti 100% sigurni da sama klasa nece biti deinicijalizovana, [weak self] je sigurniji pristup
            print(self.ime) // ovim self.name je i iz objekta klozera postavljena referenca na objekat klase i zbog toga ce se desiti retain cycle
        }
    }
}
// ILI
    var closureArray: [() -> ()] = []
    var i = 0
    for _ in 1...3 {
        closureArray.append {
            print(i)
        }
        i += 1
    }
    closureArray[0]() // () omogucava izvresnje na kraju ovog niza kada se dopise; rezultat je 3
    closureArray[1]() // 3
    closureArray[2]() // 3
    for _ in 1...3 {
        closureArray.append {
            [num = i] in // SADA KORISTIM CAPTURE LIST
            print(num)
        }
        i += 1
    }
    closureArray[3]() // 3
    closureArray[4]() // 4
    closureArray[5]() // 5


// # 21 #
// Escaping & autoclosure
// ako closure moze biti izvrsen nakon funkcijinog returna, odnosno nakon njenog zavrsetka, onda je neophodan @escaping
    var closureBlocks: [() -> Void] = []
    func funcWithClosure(closure: @escaping () -> Void) {
        closureBlocks.append(closure)
        print("Function done")
    }
    // ili
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
    Normal().normalFuncWitClosure { (ime) in // ovde nema retain cycle-a jer ce se closure dealocirati do trenutka dok se funkcija zavrsi, ne zivi posle returna funckcije
        print(ime)
    }

    
    
//: @autoclosure
    func checkIDCard(hasCard: () -> Bool){
        if hasCard() {
            print("You have ID Card")
        }
    }
    checkIDCard { true }

