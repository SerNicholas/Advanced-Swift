import UIKit

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
// GCD je biblioteka koja obezbedjuje jednostavan API pomocu kojeg se taskovi obavljaju paraleleno (concurrently),
// dok se niti (threads) hendluju u pozadini
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


// # 22 #
// Setup Live Rendering
// pomocu @IBDesignable omogucava se Interface Builderu da moze obaviti live updatevna odredjenom view-u

// # 23 #
// Sta je B-tree
// To je drvo pretrage sa uredjenim key-value skladistem.

// # 24 #
// Od cega se sastoji NSError objekat
// Od DOMAIN, ERROR CODE i USER INFO DICTIONARY

// # 25 #
// Sta je Enum
// Enum je tip, nacrt, koji sadrzi grupu povezanih vrednosti u istom okviru

// # 26 #
// Sta je Bounding Box
// To je termin iz geometrij i odnosi se na najmanju meru u okviru koje je dat skup tacaka

// # 27 #
// Zasto ne koristimo Strong za Enum
// S' obzirom da Enum nije objekat onda se na njega ne moze primeniti strong ili weak

// # 28 #
// Sta je @synthesize u ObjC
// @synthesize pravi automastski getter i setter metodu nekom property-ju

// # 29 #
// Sta je @dynamic u ObjC
// Obicno se koristi za podklase NSMAnagedObject-a
// Govori kompajleru da su getter i setter implementirani na drugom mestu

// # 30 #
// Zasto koristimo @synthesize
// On obezbedjuje da samo jedan THREAD izvrsava kod u njegovom bloku u bilo kom trenutku

// # 31 #
// Koja je razlika izmedju STRONG, WEAK, READ-ONLY i COPY
// To su atributi property-ja i govore kako ce biti hendlovana memorija tog property-ja
// Strong - reference count ce se povecati, a ta referenca ce postojati tokom zivota objekta
// Weak - pokazuje na objekat, ali ne povecava reference count
// Read-Only - postoji samo getter
// Copy - kopira se vrednost kreiranog objekta i njegova vrednost je nepromenljiva

// # 32 #
// Sta je completion handler
// To je closure koji treba da vrati neke podatke ili obavi neki zadatak po zavrsetku nekog API poziva


// # 33 #
// Koja je razlika izmedju frame i bounds
// Bounds - je pravougaonik nekog view koji je definisan sa kordinatom (x,y) i dimenzijom (sirina, visina) u odnosu na svoj sopstveni koordinatni sistem (0,0)
// Frame - je pravougaonik nekog view koji je definisan sa kordinatom (x,y) i dimenzijom (sirina, visina) u odnosu koordintani sistem svog superview-a

// # 34 #
// Sta je Responder Chain
// To je hijerarhija objekata koji odgovaraju na primljene evente

// # 35 #
// Sta je Regular Expression
// To je String pattern koji opisuje kako da se pretrazuje kroz string

// # 36 #
// Sta je Operator Overloading
// On nam omogucava da promenimo kako nacin kako se postojeci opertori ponasaju

// # 37 #
// Sta je TVMLKit
// To je biblioteka koja povezuje TVML, JavaScript i natvinu tvOS aplikaciju

// # 38 #
// Sta je funkcija
// To je blok koda koji treba da obavi neku funkcionalnost

// # 39 #
// Sta je ABI
// ABI je vazan za aplikacije koje koriste spoljne biblioteke, ako npr update-ovane biblioteke koriste isti ABI, aplikacija ne mora da se menja

// # 40 #
// Zasto su design patterni vazni
// Zato sto su dokazana resenja za programerske probleme. Postoje Creational (npr. Singleton...), Structural (npr. Decorater, Adapter, Facade...), Behavioral (Observer, Memento...)

// # 41 #
// Sta je Facade Design Pattern
// On obezbedjuje jedinstveni interfejs kompleksnom subsistemu. Umesto da korisnik brine o APIjima raznih klasa, dobija jedan jedinstven i pojednostvljen API.

// # 42 #
// Sta je Decorater Design Pattern
// Pomocu njega dinamicki dodajemo ponasanje objektu, bez modifikovanja koda.
// To su category i Delegation kod ObjC i Extension i Delegation kod Swifta.

// # 43 #
// Sta je Adapter Design Pattern
// On omogucuje klasama sa nekompatibilnim interfejsima da rade zajedno. To je wrapper za objekat, tako da pomocu adaptera objekat moze raditi sa standardnim interfejsom

// # 44 #
// Sta je Observer Design Pattern
// To je pattern kod koga jedan objekat obavestava drugi o nekim promenama i ovaj automatski na to reaguje.
// To su NSNotifiaction i KVO

// # 45 #
// Sta je Memento Design Pattern
// On cuva podatke na nekom spoljnem mestu, a kasnije po potrebi oni mogu biti aktivirani bez narusavanja ENKASPULACIJE, npr private data ostaje private data

// # 46 #
// Ogranicenja JSON/pliste
// Svaki put kad nesto treba procitati ili upisati mora da se obavi serijalizacija ili deserijalizacija; Sporost; Nije thread-safe

// # 47 #
// Prednosti Swifta u odnosu na Objective C
// Brzi; Opcionali umanjuju mogucnost pucanja aplikacije, Postojanje Closure-a, Ugradjeni Error Handling, Type safe languge, Podrzava pattern uklapanje

// # 48 #
// Sta su generici u Swiftu
// Oni prave takav kod, kojem nije definisan tip prijemnih podataka niti tip podataka koji se vraca

// # 49 #
// Tipovi varijabli
// Refernce i Value tipovi. Referentni tipovi pokazuju na originalni podatak u memoriji, a Value tipovi prave kopiju originalnog podataka

// # 50 #
// Sta je Concurrency
// To je podela izvrsnih puteva programa, kako bi oni mogli da se izvrsavaju istovremeno

// # 51 #
// Sta je Race Condition
// Dva ili vise Thread-ova pristupaju istom objektu istovremeno i hoce da ga izmene

// # 52 #
// Sta je Dead Lock
// Kada dva ili vise taskova cekau jedni na druge da bi se zavrsili, a do toga nikad ne dolazi

// # 53 #
// Sta je Readers-Writers Problem
// Vise threadova cita istovremeno, dok samo jedan upisuje podatke

// # 54 #
// Sta je Readers-Writers Lock
// On dozvoljava concurrent read only pritup zajednickom resursu, dok operacijama "upisivanja" treba posebna dozvola za pristup

// # 55 #
// Sta je Dispatch Barrier Block
// On pravi serijsko usko grlo kad se radi sa concurrent queues

// # 56 #
// Sta je NSOperation
// To je siri sprektar mogucnosti multithreadinga u odnosu na GCD

// # 57 #
// Sta je KVC
// Key-Value-Coding - property-jima objekta se moze pristupiti koriscenjem stringa u toku runtime-a, za razliku od standardnog pristupa u development time-u kada se pristupa preko statickog naziva property-ja

// # 58 #
// Sta je KVO
// Key-Value-Observing - omogucava nekom kontroleru ili klasi da prati promene nekog property-ja i da na njih reaguje  
