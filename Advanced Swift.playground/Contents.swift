import UIKit

// # 1 # // Objasni retain cycle
// Retain cycle je stanje kada dva objekta imau reference jedan prema drugome, koje zadrzavaju, tako da zadrzavaju jedan drugog i nije moguce izvrsiti deinicijalizaciju objekata.

// # 2 # // Sta je keyword defer
// DEFER omogucuje da se kod koji se nalazi u njegovom bloku, izvrsi poslednji u okviru bloka u kom se poziva DFFER

// # 3 # // Sta je computed property
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

// # 4 # // Sta su type property-ji
// Type propertiji su oni koji se pozivaju preko klase ili strukture, ne mora da se pravi instanca objekta, a i ne mogu da se zovu preko instance objekta. Definisu se sluzbenim recima STATIC i CLASS. STATIC se ne moze overrideovati, a CLASS se ne moze primanjivati kod struktura

// # 5 # // Sta je singleton
// Singleton pattern je objekat koji je samo jednom instanciran u aplikaciji
    class Singleton {
        static let shared = Singleton()
        private init() {}
    }

// # 6 # // Sta je Casting
// Upcasting se dogadja kada se ide sa nizeg na visi nivo i koristi se sluzbena rec (as), npr
    let label = UILabel() as UIView
// Downcasting se dogadja kada se ide sa viseg na nizi nivo i koriste se slubene reci (as! , as?)
    let anyArray: [Any] = ["name", 1]
    let explicitDowncasting = anyArray[0] as! String
    let implicitDowncasting = anyArray[1] as? Int

// # 7 # // Subscripts
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

// # 8 # // Sta je Array
// Array je genericka struktura. String je genericka struktura
    var niz: Array<Double> = Array()

// # 9 # // Sta je ternary operator
// Ternary operator, operator koji ima tri dela
    var dvojka = (0 == 0) ? 2 : 10000 // 2

// # 10 # // Kad koristimo setove
// Setove koristimo za pronalazenje nekih jedinstvenih vrednosti.

// # 11 # // Ekstenzije
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

// # 12 # // Kad koristimo error handling
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

// # 13 # // Objasniti accesss control
// OPEN - najotvoreniji vid access kontrole. Mogu da pravim subklase u mom modulu iako su nadklase u drugom modulu.
// PUBLIC - isto sto i OPEN samo sa nesto ogranicenijim pristupom. Moze se override-ovati samo u subclassama koje su unutar modula u kom je i nadklasa
// INTERNAL - defaultni access kontrol. Ne pise se jer se podrazumeva, a moze se dodati. Klase su dostupne samo unutar svog modula.
// FILEPRIVATE - metode i property-ji su dostupni unutar samo jednog swift file-a.
// PRIVATE - najveca kontrola pristupa. Metode i property-ji se mogu koristiti samo unutar naznacene klase.
// PUBLIC PRIVATE(SET) - property je javno dostupan, tj getter mu je javno dostupan, a setter mu je private

// # 14 # // Sta je convenience init
// Convenience init - init koji ima potpis onako kako nam odgovara, ali se mora pozvati originalni init unutar convenience bloka koda
            //convenience init(customParametar: Any) {
            //    self.init()
            //}


// # 15 # // Sta je two phase init
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

// # 16 # // Property Observer
    var ocena: Int = 10 {
        willSet {
            print(newValue) // zove se pre nego sto se promeni u newValue
        }
        didSet {
            print(oldValue) // zove se posto se promeni vrednost ocene
        }
    }

// # 17 # // Failable init
    class Blog {
        let name: String
        init?(name: String){ //zbog ovog opcionala postaje failable initializator
            if name.isEmpty {
                return nil
            }
            self.name = name
        }
    }

// # 18 # // Grand Central Dispatch
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

// # 19 # // sta je lazy var
// lazy var je non-escaping po defaultu i kod njega nema retain cycle

// # 20 # // Sta je CAPTURE LIST
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


// # 21 # // Escaping & autoclosure
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


// # 22 # // Setup Live Rendering
// pomocu @IBDesignable omogucava se Interface Builderu da moze obaviti live updatevna odredjenom view-u

// # 23 # // Sta je B-tree
// To je drvo pretrage sa uredjenim key-value skladistem.

// # 24 # // Od cega se sastoji NSError objekat
// Od DOMAIN, ERROR CODE i USER INFO DICTIONARY

// # 25 # // Sta je Enum
// Enum je tip, nacrt, koji sadrzi grupu povezanih vrednosti u istom okviru

// # 26 # // Sta je Bounding Box
// To je termin iz geometrij i odnosi se na najmanju meru u okviru koje je dat skup tacaka

// # 27 # // Zasto ne koristimo Strong za Enum
// S' obzirom da Enum nije objekat onda se na njega ne moze primeniti strong ili weak

// # 28 # // Sta je @synthesize u ObjC
// @synthesize pravi automastski getter i setter metodu nekom property-ju

// # 29 # // Sta je @dynamic u ObjC
// Obicno se koristi za podklase NSMAnagedObject-a
// Govori kompajleru da su getter i setter implementirani na drugom mestu

// # 30 # // Zasto koristimo @synthesize
// On obezbedjuje da samo jedan THREAD izvrsava kod u njegovom bloku u bilo kom trenutku

// # 31 # // Koja je razlika izmedju STRONG, WEAK, READ-ONLY i COPY
// To su atributi property-ja i govore kako ce biti hendlovana memorija tog property-ja
// Strong - reference count ce se povecati, a ta referenca ce postojati tokom zivota objekta
// Weak - pokazuje na objekat, ali ne povecava reference count
// Read-Only - postoji samo getter
// Copy - kopira se vrednost kreiranog objekta i njegova vrednost je nepromenljiva

// # 32 # // Sta je completion handler
// To je closure koji treba da vrati neke podatke ili obavi neki zadatak po zavrsetku nekog API poziva


// # 33 # // Koja je razlika izmedju frame i bounds
// Bounds - je pravougaonik nekog view koji je definisan sa kordinatom (x,y) i dimenzijom (sirina, visina) u odnosu na svoj sopstveni koordinatni sistem (0,0)
// Frame - je pravougaonik nekog view koji je definisan sa kordinatom (x,y) i dimenzijom (sirina, visina) u odnosu koordintani sistem svog superview-a

// # 34 # // Sta je Responder Chain
// To je hijerarhija objekata koji odgovaraju na primljene evente

// # 35 # // Sta je Regular Expression
// To je String pattern koji opisuje kako da se pretrazuje kroz string

// # 36 # // Sta je Operator Overloading
// On nam omogucava da promenimo kako nacin kako se postojeci opertori ponasaju

// # 37 # // Sta je TVMLKit
// To je biblioteka koja povezuje TVML, JavaScript i natvinu tvOS aplikaciju

// # 38 # // Sta je funkcija
// To je blok koda koji treba da obavi neku funkcionalnost

// # 39 # // Sta je ABI
// ABI je vazan za aplikacije koje koriste spoljne biblioteke, ako npr update-ovane biblioteke koriste isti ABI, aplikacija ne mora da se menja

// # 40 # // Zasto su design patterni vazni
// Zato sto su dokazana resenja za programerske probleme. Postoje Creational (npr. Singleton...), Structural (npr. Decorater, Adapter, Facade...), Behavioral (Observer, Memento...)

// # 41 # // Sta je Facade Design Pattern
// On obezbedjuje jedinstveni interfejs kompleksnom subsistemu. Umesto da korisnik brine o APIjima raznih klasa, dobija jedan jedinstven i pojednostvljen API.

// # 42 # // Sta je Decorater Design Pattern
// Pomocu njega dinamicki dodajemo ponasanje objektu, bez modifikovanja koda.
// To su category i Delegation kod ObjC i Extension i Delegation kod Swifta.

// # 43 # // Sta je Adapter Design Pattern
// On omogucuje klasama sa nekompatibilnim interfejsima da rade zajedno. To je wrapper za objekat, tako da pomocu adaptera objekat moze raditi sa standardnim interfejsom

// # 44 # // Sta je Observer Design Pattern
// To je pattern kod koga jedan objekat obavestava drugi o nekim promenama i ovaj automatski na to reaguje.
// To su NSNotifiaction i KVO

// # 45 # // Sta je Memento Design Pattern
// On cuva podatke na nekom spoljnem mestu, a kasnije po potrebi oni mogu biti aktivirani bez narusavanja ENKASPULACIJE, npr private data ostaje private data

// # 46 # // Ogranicenja JSON/pliste
// Svaki put kad nesto treba procitati ili upisati mora da se obavi serijalizacija ili deserijalizacija; Sporost; Nije thread-safe

// # 47 # // Prednosti Swifta u odnosu na Objective C
// Brzi; Opcionali umanjuju mogucnost pucanja aplikacije, Postojanje Closure-a, Ugradjeni Error Handling, Type safe languge, Podrzava pattern uklapanje

// # 48 # // Sta su generici u Swiftu
// Oni prave takav kod, kojem nije definisan tip prijemnih podataka niti tip podataka koji se vraca

// # 49 # // Tipovi varijabli
// Refernce i Value tipovi. Referentni tipovi pokazuju na originalni podatak u memoriji, a Value tipovi prave kopiju originalnog podataka

// # 50 # // Sta je Concurrency
// To je podela izvrsnih puteva programa, kako bi oni mogli da se izvrsavaju istovremeno

// # 51 # // Sta je Race Condition
// Dva ili vise Thread-ova pristupaju istom objektu istovremeno i hoce da ga izmene

// # 52 # // Sta je Dead Lock
// Kada dva ili vise taskova cekau jedni na druge da bi se zavrsili, a do toga nikad ne dolazi

// # 53 # // Sta je Readers-Writers Problem
// Vise threadova cita istovremeno, dok samo jedan upisuje podatke

// # 54 # // Sta je Readers-Writers Lock
// On dozvoljava concurrent read only pritup zajednickom resursu, dok operacijama "upisivanja" treba posebna dozvola za pristup

// # 55 # // Sta je Dispatch Barrier Block
// On pravi serijsko usko grlo kad se radi sa concurrent queues

// # 56 # // Sta je NSOperation
// To je siri sprektar mogucnosti multithreadinga u odnosu na GCD

// # 57 # // Sta je KVC
// Key-Value-Coding - property-jima objekta se moze pristupiti koriscenjem stringa u toku runtime-a, za razliku od standardnog pristupa u development time-u kada se pristupa preko statickog naziva property-ja

// # 58 # // Sta je KVO
// Key-Value-Observing - omogucava nekom kontroleru ili klasi da prati promene nekog property-ja i da na njih reaguje

// # 59 # // Sta je swizzling metod
// Pomocu swizzlinga implamentacija metode tokom runtime moze biti razlicita, promenom mapiranja preko #selecto(naziv_metode)
// Da bi ga koristila klasa kojoj se mapiraju metode, ona mora naslediti NSObject, a metode koje se swizzluju moraju imati atribut dynamic

// # 60 # // Sta je ARC
// ARC je mogucnost koja tokom kompajliranja obavlja automatski menadzment memorije. Automatic Reference Counting.
// Ona ce osloboditi memoriju zauzetu objektom kada ne bude vise bilo referenci na taj objekat.

// # 61 # // Objasniti #keyPath()
// To je staticka provera izvresna pomocu key-path-a. To je litral stringa koji se koristi kao StaticString ili StringLiteralConvertible,
// a proverom se utvrdjuje da li objekat zaista postoji i da li je pravilno predstavljen jeziku, objectiveC-u.

// # 62 # // iOS 11 opcije i mogucnosti za developera
// Novi MapKit markeri, Headeri koji se mogu konfigurisati, azuriranja UITableView-a zasnovana na blokovima, KVO zasnovan na klozerima, podrska za vector UIImage

// # 63 # // Zasto je ReactNative vazan za iOS
// Pomocu ReactNative je logika aplikacije pisana u JavaScriptu, a UI aplikacije je pisan potpuno nativno, tako da ne moraju da postoje kompromisi
// koji bi se desili sa HTML5 UI-jem. Drugo je to sto je UI aplikacije razvijen pomocu Functional Programming-a

// # 64 # // Sta je NSFetchRequest
// To je klasa odgovorna za dobavljanje podataka iz CoreData-e. Fetch request-ovi su fleksibilni, a moze se dobaviti skup objekata koji ispunjavaju trazene kriterujume pretrage, mogu se dobaviti pojedinacne vrednosti itd.

// # 65 # // Objasniti NSPersistneceContainer
// On kreira i vraca kontejner koji ima skladiste u kojem treba sacuvati aplikaciju. Ovaj property je opcional jer postoje error-i koji bi mogli da dovedu do
// pucanja tog skladista

// # 66 # // Objasniti NSFetchedResultsController
// To je kontroler koji nije view controller jer nema UI. On sinhroniazuje UITableView sa bazom koja je u CoreData-i.

// # 67 # // Tri glavna poboljsanja debugging-a u XCode 8
// View Debugger - mogu da se vide oblici view-eva tokom runtime-a
// Thread Sanitizer - upozorava na moguce probleme sa thread-ovima, najcesce na Race Condition

// # 68 # // Koja su tri glavna pravila Test Driven Developmenta
// Ne sme se pisati produkcioni kod, osim kada failing unit treba da prodje test
// Ne sme se pisati vise nego sto je potrebno test koda, da bi se dovelo do pada testa
// Ne sme se pisati vise nego sto je potrebno produkcionog koda, da bi se prosao test

// # 69 # // Sta znaci termin Yan Shaving
// Programerski termin koji se odnosi na niz operacija koje treba uraditi da bi projekat dosao u sledecu fazu

// # 70 # // Razlika izmdju BDD i TDD
// BDD testove mogu citati i ne-inzenjeri

// # 71 # // Objasni AAA (Arrange-Act-Assert)
// AAA je patern za organizovanje i formatiranje koda u Unit Testovima. Ako pisemo XCtest-ove, svaki nas test bi grupisao ove tri celine odvojene blanko linijama
// Arrange - obezbediti sve neophodne input-e
// Act - operacije nad objektom ili metodom koji se testiraju
// Assert - ispisati ocekivane rezultate

// # 72 # // Objasniti Swift Standard Library Protocol
// Stdlib ima nekoliko protokola: Equatable, Comparable, Sequence, Codable

// # 73 # // Razlika izmedju SVN i Git
// Git se zasniva na distributivnom sistem upravljanja verzijama. Ima lokalni repozitorijum, a mreza mu treba samo za sinhronizaciju
// SVN se zasniva na centralizovanom sistemu upravljanja verzijama, a mreza mu je stalno neophodna zbog pristupa.

// # 74 # // Glavna svrha frameworka
// Enkapsuliranje, modularnost i ponovno koriscenje koda

// # 75 # // Sta je Swift Package Manager
// Pomocu SPM moze se deploy-ovati na platforme koje nemaju XCode, kao sto je to Linux. SPM moze resavati probleme dependency-ja koji nastaju koriscenjem raznih nezavisnih biblioteka. SPM podrzava iskljucivo koriscenje master branch-a, a jezici koje podrzava su Swift, Objective C, C, C++

// # 76 # // Razlika izmedju delegata i nsnotifikacija
// Pomocu njih se postizu gotovo iste funkcionalnosti, ali su delgati za prenos 1-1, a nsnotifikacija za prenos 1-n.

// # 77 # // Koja su ogranicanja SitiKit
// Ne moze korisiti sve tipove aplikacije, nije zamena za celokupnu pravu aplikaciju, zahteva stalni internet, mora da komunicira sa apple serverima

// # 78 # // Razlika izmedju INOUT paramtera i REGULAR paramtera
// Inout se prenosi preko reference a regular preko vrednosti.

// # 79 # // Objasni View Controller life cycle
// loadView - kreira view kojim ce kontroler upravljati, a poziva se samo kada se kontroler kreira iz koda
// viewDidLoad - poziva se kada se kontrolerov view smesta u memoriju i poziva se samo kada je taj view kreiran
// viewWillAppear - poziva se kad god se view pojavljuje na ekranu, mada view ima svoje okvire nema orijentaciju
// viewWillLayoutSubviews - poziva se da obavesti kontroler da ce view iscrtati subview-eve i poziva se svaki put kada se frame promeni
// viewDidLayoutSubviews - poziva se da obavesti kontroler da je njegov view iscrtao subview-eve
// viewDidAppear - poziv se kada je kontrolerov view dodat u hijerarhiju svih view-a
// viewWillDisappear - poziva se neposredno pre nego sto se kontrolerov view ukloni sa ekrana zbog prikazivanja sledeceg kontrolera
// viewDidDisappear - poziva se kada je kontroler sklonjen sa ekrana, a obicno se koristi kada treba zaustaviti taskove koji su za njega bili vezani

// # 80 # // Razlika izmedju LLVM i CLANG
// CLANG je CLanguage i to je frontend LLVM-a, a svaki kompajler ima 3 dela
// Frontend - leksicka analiza, parsiranje
// Optimizer - Optimiziranje apstraktnog sintaksnog drveta
// Backend - Genersianje masinskog koda

// # 81 # // Sta je klasa
// Klasa treba da definise objekat i njegovo ponasanje. To je nacrt objekta.

// # 82 # // Sta je interface
// @interface objective C-a nije isto sto i interfejs u Javi, on samo definise public interface klase, public API

// # 83 # // Stanja iOS aplikacje
// Non-working, Inactive(radi ali je neaktivana npr zbog sms-a ili poziva), Active, Background, Suspended

// # 84 # // Najvaznije delegirajuce metode aplikacije
// WillFinishLaunchingWithOptions - poziva se kada je pokretanje aplikacije pocelo, ovde se prvi kodovi aplikacije izvrsavaju
// DidFinishLaunchingWithOptions - poziva se neposredno pre zavrsetka pokretnaja palikacije, tako da je ovde zadnja sansa za globalno setovanje aplikacije iz koda
// ApplicationDidBecomeActive - poziva se kad god se stanje aplikacije vrati u aktivno, npr posle SMS-a ili poziva
// ApplicationWillResignActive - poziva se kad god se stanje aplikacije menja u background, npr kod dolazeceg SMS-a ili poziva
// ApplicationDidEnterBackground - poziva se kada je aplikacija otisla u background, tj nije vise na ekranu
// ApplicationWillEnterForeground
// ApplicationWillTerminate

// # 85 # // Razlika izmedju property-ja i instance variable
// Instance variable-a je samo slot skladista, kao slot u strukturi. Inace, drugi objekti im ne mogu pristupiti direktno.
// Property ce vratiti ili setovati instance variable-u, a moze koristiti podatke od njih nekoliko ili od jedne.

// # 86 # // Kako mozemo dodati UIKit Swift Package Managere-u
// Swift Package Manager ne podrzava UIKit. Moze se napraviti File Manager ili Framework za drugi projekat.

// # 87 # // Razlika izmedju SDK i Framework-a
// SDK je skup alata za razvoj software-a. Ovaj skup se koristi za kreiranje apliakcije.
// Framework je platforma koja se koristi za kreiranje aplikacije.

// # 88 # // Objasniti subscript
// To su precice za pristup nizovima, recnicima, sekvencama.

// # 89 # // Sta je DispatchGroup
// DispatchGroup omogucava  agregatnu sinhronizaciju posla. Korisitmo ih da grupisemo razlicite delove koda i na razlicitim threadovima,
// da bi pratili kada se svi ti delovi koda zavrsavaju.
// Ako nam je potrebno da sacekamo na nekoliko asinhronih i sinhronih operacija da bi nastavili dalje, koristimo DispatchGroup.

// # 90 # // Sta je RGR (Red-Green-Refactor)
// To su faze TDD-a. Red - koristi najvise 7 linija test koda i ovde test ne prozlazi
// Green - najvise do 7 linija produkcionog koda i ovde test prolazi
// Refactor - posto testovi prolaze, refaktoristi slobodno mozemo

// # 91 # // Gde se koristi Dependency Injection
// Kada se koristi storyboard ili xib, pravimo IBOutlet-e, a oni su property-ji view-a. Oni se ubacuju u viewController kada se on instancira i ovo je oblik dependency injection-a
// Postoje razlicite forme DI: Constructor Injection, Property Injection i Method Injection.

// # 92 # // Vrste notifikacija
// Remote i local

// # 93 # // Koje vrste ORDER funkcija mozemo koristiti na kolekcijama
// Map, Filter, Reduce, Sort

// # 94 # // Sta omogucuje kombinovanje komita
// git squash

// # 95 # // Razlika izmedju Any i AnyObject
// Any predstavlja instancu bilo kog tipa ukljucujuci i funckije i opcionale
// AnyObject predstavlja instancu bilo koje klasa.

// # 96 # // Koja je git komanda za pronalazenje losih komita
// git bisect

// # 97 # // Sta je CoreData
// To je menadzer koji podatke cuva na disku. CoreData nije threadSafe, tako da se sve obavlja na main thread-u ili na back thread-u ali sa prosledjivanjem ID-ja managed objekta.
// Ovde multithreading gubi smisao, i zbog toga je najbolje da managed object konvertujemo u Plain Old Swift Object (POSO)

// # 98 # // Objasniti AssociatedType
// Korisiti se kada od protokola pravimo genericki protokol

// # 99 # // Koja komanda cuva kod bez komitovnaja
// git stash

// # 100 # // Objasniti Priority Inversion i Priority Inheritance
// Ako thread visokog prioriteta ceka na thread niskog prioriteta, to je Priority Inversion.
// Ako thread niskog prioriteta, privremeno nasledi prioritet thrread-a visokog prioriteta, to je Priority Inheritance

// # 101 # // Sta je Hashable
// Protokol koji omogucava da koristimo objekte kao key-eve recnika.

// # 102 # // Kad se koristi Optional Chaining a kad if let ili guard
// Optional Chaining koristim kada mi nije vazno da li ce operacija proci, u suprotnom koristim IF LET ili GUARD

// # 103 # // Nacicni za prenosenje podataka u Swiftu
// Dlegate, KVO, Segue, NSNotification, Target-Action, Callbacks

// # 104 # // Kako postizes clean code u projektu
// Pratim uputstva, vodice i konvencije na GitHub-u i SwiftLint-u

// # 105 # // Razlika izmedju Optional.None i nil
// Nema razlike jer je nil samo skracenica Optional.None

// # 106 # // Sta je GrphQL
// Pomocu njega kreiramo upitni interfejs za klijente na aplikacijskom nivou

// # 107 # // Sta je Continious Integration
// Continious Integration nam omogucuje da imamo rani feedback, ukoliko nesto ne krene kako treba tokom developmenta
// Postoje mnogi Continious Integration alati
// Self hosted serveri: XCode server, Jenkins, TeamCity
// Cloud solutions: TravisCL, Bitrise, Buddybuild

// # 108 # // Razlika izmedju delegata i callback-a
// Razlika je u tome sto se delegatima govori da je doslo do promene, a callback-ovi posmatraju promene

// # 109 # // Objasni Linked Liste
// Linked List-e se uglavnom sastoje od struktura koje se zovu nodovi. Ovi nodovi imaju dve stvari.
// Prva je ono sto zelimo da cuvamo, a druga je adresa informacije drugog noda.
// Mana je velika prostor koji zauzimaju.

// # 110 # // Backend
// Najbolje za iOS je raditi node.js + express.js sa MongoDB ili Swift Server Side sa Vaporom ili Kiturom

// # 111 # // Objasni AutoLayout
// On obezbedjuje fleksibilan layout sistem koji opisuje kako ce se view-evi i UI kontrole ponasati, tj dobiti dimenzije i lokacije u hijerarhiji

// # 112 # // Sta je pointer
// Pointer je direktna referenca memorijske adresa

// # 113 # // Objaniti blokove
// Blokovi su nacin definisanja jednog taska ili jedinice ponasanja, bez neophodnosti pisanja cele klase.
// To su anonimne funkcije.

// # 114 # // Sta je keychain
// To je APi za bezbedno cuvanje podataka u aplikaciji, Locksmith je jedna dobra Keychain biblioteka

// # 115 # // Razlika izmedju atomic i nonatomic
// Atomic je thread-safe, to znaci da samo jedan thread moze pristupiti ovakvom property-ju, i trebalo bi da je default-ni atribut iako se retko koristi.
// Nonatomic nije thread-safe, ali se zato mnogo cesce (95%) koristi i neuporedivo je brzi

// # 116 # // Sta je enkapsulacija
// To je objektno orijentisan dizajn princip koji skriva unutrasnje stanje i funkcionalnost objekta. To znaci da objekat cuva svoje informacije privatnim.

// # 117 # // Tri okidaca lokalnih notifikacija
// Lokacija, Kalendar, Vremenski interval

// # 118 # // Objaniti selektore
// To si interne predstave naziva metode

// # 119 # // Razlika izmedju ARC i autorelease
// Autorelease je ARC koji se i dalje koristi. ARC se korsiti unutar okvira, a autorelease izvan okvira funkcije

// # 120 # // Razlika izmedju CoreFoundation i Foundation
// CoreFoundation je c-ovska alternativa Foundation

// # 121 # // Objasniti Place Holder Constraint
// On govori Interface Builder-u da izbrise contraint-e kada bilduje i pokrece kod.
// Omogucava layout engine-u da shvati osnovni layout, a zbog toga layout mozemo modifikovati u runTime-u.

// # 122 # // Charles Proxy
// Ukoliko je potreban proxy server koji objedinjuje kompletne request-ove i response-ove, kao i HTTP headere,
// koristi se Charles Proxy, a on podrzava binarne protokole, rewritting i trafic throttling

// # 123 # // Unwind segue
// On se pokrece unazad kroz jedan ili vise segue-ja da bi vratio korisnika na situaciju (ekran) koji kontrolise postojeci viewController

// # 124 # // Odnos iVar i @property
// iVar je instance variable, ne moze joj se pristupiti osim ako ne kreiramo accessor
// taj accessor se generise pomocu @property-ja. iVar i @property mogu biti razlicitih naziva
// iVar-u se moze pristupiti uvek preko KVC-a

// # 125 # // Komanda xcscontrol
// Pomocu ove komande uticemo na aktivnosti XCode servera (start, stop, restart, reset...)
// npr.  $sudo xcrun xcscontrol --reset

// # 126 # // Sta je NSManagedObjectContext
// Njegov primarni zadatak je da organizuje (to manage) skup managed object-ata

// # 127 # // Sta je Instruments
// to je alat pomocu kog se analiziraju performanse, memorijski footprint, animacije, koriscenje energije, leak-ovi, file/network aktivnsot

// # 128 # // Sta je Deep Linking
// To je nacin prenosenja podataka u aplikaciju sa bilo koje platforme, npr sa web sajta

// # 129 # // Kad se koristi SUPER
// Super se kosristi kada se pristupa inicijalizatoru nadklase

// # 130 # // Sta je CocoaTouch
// To je apstraktni layer u iOS-u, biblioteka koja se koristi za bildovanje executable aplikacija

// # 131 # // Sequence
// To je protokol pomocu kojeg se definise agregacija elemenata koji se distribuiraju sekvencijalno u nekom redu.
// Svi kolekcioni tipovi, array, dictionary, set nasledjuju Sequence

// # 132 # // Koristi XCode servera
// Automatski proverava projekat, bilduje aplikaciju, izvodi testove i arhivira aplikaciju za distribuiranje

// # 133 # // Sta je Strategy Pattern
// On omogucava promenu ponasanja algoritma u runTime-u

// # 134 # // Sta je BundleID a sta AppID
// BundleID je jedinstveni naziv jedne aplikacije
// AppID je jedinstveni naziv tima developera i za AppId je potreba AppleDeveloper account

// # 135 # // Factory Method Pattern
// Ovaj pattern cini codebase fleksibilnijim za dodavanje ili uklanjanjenovih tipova.
// Da bismo dodali novi tip treba samo napraviti novu klasu za taj tip.

// # 136 # // Sta su layer objekti
// To su objekti podataka koji reprezentuju vizuelni sadrzaj, a koriste ih view-i da bi renderovali taj sadrzaj

// # 137 # // Sta je Iterator Protocol
// On je u tesnoj vezi sa Sequence protokolom. Sequence protokol obezbedjuje pristup svojim elementima kreiranjem iteratora.
// Taj iterator se podvrgava Iterator protokolu.

// # 138 # // Sta je OAuth
// Open Authorization - je protokol autorizacije koji ne uzima u obzir identifikaciju korisnika, vec identifikuje druge aplikacije koje pristupaju podacima korisnika bez odavanja korinikovih kredencijala

// # 139 # // Sta je Circular Dependency
// Odnos izmedju dva ili vise modula koji direktno ili indirektno zavise jedan od drugog da bi pravilno funkcionisali

// # 140 # // Sta je UIBezierPath
// Ova klasa omogucava iscrtavanje putanja s ciljem dobijenja bilo kakvog oblika na ekranu

// # 141 # // Sta je LLDB
// To je debugger LLVM-a

// # 142 # // Sta je @synchronized(self)
// Korsiti se kada se neki podatak azurira ili mu se postavlja neka nova vrednost, jer bi u suprotnom
// u istom trenutku jedan therad upisiviao podatke, a drugi therad citao podatke, jer bi pristupali istoj memomrijskoj
// lokaciji odredjenog property-ja, tako da se ne bi dobio validan podatak

// # 143 # // Sta je to API aplikacije
// Application Programming Interface - to je deo servera koji prima request-ove i salje response-ove

// # 144 # // Razlika izmedju 3 Layer arihtekture i 3 Tier Arhitekture
// Layeri se nalaze na jednoj masini, a tier-i se mogu nalaziti na vise masina.
// Layeri medjusobno komuniciraju preko referneci ili vlaue tipova, a tier-i samo pomocu value tipova i to kao serijalizovanim objektima
// Layeri imaju l ogicku separaciju koda, a Tier-i fizicku separaciju koda.
// N-Tier arhitektura je fizicko strukturiranje, a N-Layer arhitektura je logicko strukturiranje.
// 3 Layer arhitketura: Database Access Layer (DAL), Buisness Logic Layer (BLL), User Interface Layer (UIL) -> su tri razlicita projekta
// a output ovih fajlova - dll fajl mora biti na istom serveru ili na istoj masini
// 3 Tier arhitektura: ova tri layera su tri razlicita projekta i svaki moze biti deploy-ovan na razlicitom serveru ili na razlicitim masinama
// 3LA ce poboljsati readability i reusability, a 3TA ce poboljsati scalability aplikacije

// # 145 # // Razlika izmedju Array-a i List-e
// Niz je skup elemenata iste vrste podataka. Lista je sveden skup elemenata koji su povezani pointerima.
// Kod niza, elementima se moze pristupiti pomocu indeksa, tako da nizovi omogucuju brzi i random access.
// Kod liste, elementima se ne moze pristupiti random, vec sekvencijalno, a za pristup trazenom elementu treba (1)*n vremena
// Kod niza se elementi cuvaju u uzastopnim mestima u memoriji, a kod liste mogu biti sacuvani u bilo kom slobodnom mestu u memoriji
// Ubacivanje i brisanje elemenata u niz traje duze jer je potrebno odvojiti memoriju za ceo niz, za razliku od liste kojoj je
// potrebna samo vrednost, adresa, pointera
// Kod niza memorija se alocira tokom kompajliranja - Static Memory Allocation
// Kod liste memorija se alocira tokom runTime-a i to je Dynamic Memory Allocation
// Niz moze biti jednodimenzionalan, dvodimenzionalan i multidimenzionalan.
// Lista moze biti pojedinacna, dupla, cirkularna.
// U nizu svaki element je nezavisan i nema povezanosti sa prethodnim elementom ili njegovom lokacijom.
// Kod liste, lokacije ili adrese elemenata sus sacuvane u prethodnom elementu.
// Kod niza, s obzirom da se pointeri ne koriste nema potrebe za dodatnom memorijom
/*
                        NIZ              LISTA[*]**>**
                         |                           ↓
                         |           ********<********
                         |           ↓
                      [66][0]        ****>[66][*]**>**
                         |                           ↓
                         |           ********<********
                         |           ↓
                      [72][1]        ****>[72][*]**>**
                         |                           ↓
                         |           ********<********
                         |           ↓
                      [74][2]        *  *>[96][X]
                         |           ↓  ↑
                         |           *  *******<******
                         |           ↓               ↑
                      [85][3]        *  *>[85][*]**>**
                         |           ↓  ↑
                         |           *  *******<******
                         |           ↓               ↑
                      [96][4]        ****>[74][*]**>**
 */

// # 146 # // Razlika izmedju Objekto-Orijentisanih i Obejktno-Zasnovanih jezika
// OZJ ne podrzavaju sve mogucnosti OOJ, OZJ ne podrzavaju nasledjivanje.
// Visual Basic je OZJ, zato sto se moze napraviti klasa i objekat, ali se ne moze obaviti nasledjivanje, dok bi se
// JAVA mogla nazvati OOJ jer podrzava enkapsulaciju, polimorfizam, nasledjivanje, abstrakciju podataka, dynamic binding
// 1 - INTERPRETED PROGRAMMING LANGUAGES - svoje implementacije izvrsavaju direktno bez prethodnog kompajliranja u instrukcije masinksog jezika
// Pascal, Phyton, Ruby
// 2 - FUNCTIONAL PROGRAMMING LANGUAGES - svaku aktivnost definisu kao matematicku evaluaciju, a zasnivaju se na upotrebi funkcija
// Charity, Clean, Curry, F#
// 3 - COMPILED PROGRAMMING LANGUAGES - njihova implementacija je tipicno kompjalerska, prevodjenje u masinski kod iz source koda
// C, C++, C# (C-Sharp), Java, Objective-C, Swift
// 4 - PROCEDURAL PROGRAMMING LANGUAGES - zasnivaju se na korak po korak izvrsavanju koda
// Matlab, Rapira
// 5 - SCRIPTING PROGRAMMING LANGUAGES - kontrolisu aplikaciju i uglavnom su embedovani u aplikaciju koju kontrolisu, i koriste se automatizaciju cesto izvravanih zadataka, mao sto je komunikacija sa eksternim porgramima
// AppleScript, PHP, JavaScript
// 6 - MARKUP PROGRAMMING LANGUAGES - koriste tekstualne anotacije koje definisu kako ce se tekst prikazivati
// Curl, HTML, SGML, XML
// 7 - LOGIC PROGRAMMING LANGUAGES - zasnovani su na formalnoj logici
// 8 - CONCURRENT PROGRAMMING LANGUAGES - obezbedjuju paralelno izvrsenje operacija na jednom kompjuterskom sistemu ili na nekoliko kompjuterskih sistema
// Salsa, SR, Limbo, AFNIX
// 9 - OBJECT ORIENTED PROGRAMMING LANGUAGES: Cecil (slican Objective C-u), Moto, Oxygene, Scala

// # 147 # // Razlika izmedju Overloading-a i Overriding-a
// Method Overloading - metode u istoj klasi imaju isti naziv, ali svaka metoda ima razlicit broj parametara ili paramteri imaju drugacije tipove i raspored
// Overriding - dogadja su u subklasi na metodi koja ima isti potpis kao metoda u nadklasi, ali izvrsenje moze biti isto ili razlicito u odnosu na nadklasu
// Overloading ima smisao u dodavanju funkcionalnosti ili prosirivanju postojece metode, a overriding u mogucoj promeni polazne metode
// Overloading se sluzi Compile Time Polimorfizmom, a overriding Run Time Polimorfizmom.

// # 148 # // Razlika izmedju label i literal
// Po default-u label ima tekst, a literal nema.
// Label kontrola se renderuje kao span tag, a literal ne dodaje nikakve HTML elemente.
// Label se moze stilizovati, a kontrola mu dozvoljava razno formatiranje, kod literala to ne moze.
// Vise memorije zauzima label nego literal, label nema mode property dok literal ima.
// Label se ne moze koristiti izmedju tagove dok literal moze, label ispsiuje staticeki tekst dok literal ispisuje dinamicki tekst
// OBJECT>CONTROL>WEBcontrol>LABEL  vs. OBEJCT>CONTROL>LITERAL

// # 149 # // Razlika izmedju apstraktne klase i interfejsa
// AK se koristi kao bazicna klasa i ne moze se instancirati, a interfejs je template koji ima samo spisak metoda i property-ja
// AK sadrzi apstrakte metode i neapstraktne metode, dok interface sadrzi samo apstraktne
// AK moze da se primeni default-na implementacija svake metode, dok kod interfejsa to ne moze
// Klase mogu naslediti samo jednu AK, dok interfejsi mogu biti implementirani u vecem broju u nekoj klasi
// Objekti se ne prave ni od AK ni od interface-a
// AK moze imati konstruktor dok interface ne moze
// AK moze imati access kontrolu, a interface nema
// AK obezbedjuje brzi pristup od interface-a

// # 150 # // Razlika izmedju REST i SOAP
// REST je Represntational State Transfer, SOAP je Simple Object Access Protocol
// REST je arhitektonski stil i nije protokol kao SOAP koji se bazira na XML-u
// REST nije specificiran standardom kao SOAP koji je ujedno i strongly type
// REST se lako implementira za razliku od SOAP-a, i REST je dosta brzi
// REST kosristi samo HTTP, tako da je zavisan od transporta, za razliku od SOAP-a koji je nezavisan i korsiti i HTTP i SMTP i FTP i UTP i druge
// REST je malih dimenzija jer nema dodatni XML kao SOAP
// REST nema state i lagan je za implementaciju i razumenvanje
// Poruke poslate REST-om su samostalne, a protokoli koji se koriste za komunikaciju sa porukama su XML, JSON, PlainText, itd, a SOAP korsiti samo XML
// REST je Resource Oriented, SOAP je objektno orijentsan
// REST nema WSDL za servisni opsi kao SOAP (Web Services Description Language)
// REST ne zahteva dodatne framework-e kao SOAP.

// # 151 # // Razlika izmedju GET i POST
// Get metoda sadrzi podatke koji su vidljivi u URL-u u adres baru, za razliku od POST metode
// Catching i bookmark mogu da se izvedu kod GET, za razliku od POST
// GET je manje siguran od POST
// Paramteri koji se proslede GET-om ostaju u istorji browsera, za razliku od POST-a
// GET ima ogranicenja u duzini, tj velicini, za razliku od posta
// GET podrzava koriscenje samo ASCII karaktera, za razliku od POST-a koji nema ogranicanja
// GET je brzi od POST-a
// GET koristi STACK za prnosenje variabli, a POST HEAP
// GET je default-ni metod HTML-a, a POST mora da se naglasi koristeci metod atribut.
// GET: "https://www.mesto.com/metoda.asp?frame=abc&lname=xyz"
// POST: "https://www.mesto.com/metoda.asp"

// # 152 # // Razlika izmedju JSON i XML
// JSON - JavaScript Object Notation, XML je eksttendovan od SGML - Standrad Generalized Markup Language
// JSON je samo human readable, XML je human & machine readable
// JSON sintaksa je mnogo jednostavnija od XML-ove
// JSON podrzava tipove podataka kao sto su Integer, String, Array, Dictionary
// XML ne podrzava tipove podataka i kod njega se oni moraju parsirati
// JSON ne podrzava komentare ni nameSpace-ove, a XML da
// JSON je orijentisan prema podatku i lakse se mapira u odnosu na XML koji je orijentisan prema dokumnetu
// JSON je bolji za WEB servise, a XML za WEB konfiguracije
// JSON ne dozvoljava pristup nekom delu delu/elementu svoje strukture direktno, dok XML pomocu XPath to podrzava

// # 153 # // Razlika izmedju BRAKE i CONTINUE
// Brakeom se prekida izvrsenje petlje, a Continue-om se preskace iteracija u petlji
// Brake-om se napusta petlja, a Continue-om ne
// Brake se koristi i kod petlji i kod switch-eva, COntinue samo kod petlji

// # 154 # // Razlika izmedju kontruktora i dekontruktora
// Oba su specijalne metode svake klase
// Konstruktorom se inicijalizuje instance klase, a dekonstruktorom se brise objekat kada vise nije potreban
// Konstruktom se alocira memorija, a dekonstruktor otpusta memoriju
// Konstruktor moze imati argumente, za razliku od dekonstruktora
// Overloading konstruktora je moguc, za razliku od dekonstruktora
// Dekonstruktor ima tiled (~)

// # 155 # // Razlika izmedju server side scriptinga i client side scriptinga
// SSS -> web serve, CSS -> web browser
// SSS povezuje bazu koja je na web serveru sa programom, CSS to ne moze
// SSS korisnik ne moze da blokira, za razliku od CSS-a
// Response SSS je sporiji od CSS-a
// SSS: PHP, JSP, ASP, ASP.NET, RUBY
// CSS: JavaScript, VB Script

// # 156 # // Razlika izmedju run time polimorfizma i compile time polimorfizma
// Kod CTP poziv je resolovan kompajlerom, a kod RTP nije
// CTP je poznat i kao Static Binding, Early Binding i kao Overloading
// RTP je poznat i kao Dynamic Binding, Late Binding i kao Overriding
// CTP se ostvaruje overloadovanjem funkcija i operatora, a RTP virtuelnim funkcijama i pointerima
// CTP ima brze izvrsenje jer je ranije poznat, tokom kompajliranja, za razliku od RTP cije se izvresnje obalja u runTime-u
// CTP je manje fleksibilan od RTP jer se izvrsava u toku kompajliranja

// # 157 # // Razlika izmedju alloc i malloc
// ALLOC inicijalizuje alociranu memoriju na null ili na nula
// MALLOC inicijalizuje alocirani memorijski prostor sa nekom GARBAGE (bezveznom) vrednoscu
// ALLOC alocira blok memorije, MALLOC alocira bajt memorije
// ALLOC uzima broj promenljivih za koje odvaja memoriju i velicinu (kolicinu) bajtova pojedinacne promenljive
// MALLOC uzima samom jedan argument, a to je velicina memorije
// ALLOC izvodi inicijalizaciju memorija, dok MALLOC ne
// ALLOC je sporiji od MALLOC-a jer inicijalizuje memoriju na NULL ili na nula
// ALLOC ima pointer na memoriju sa alociranim skladistem svakog bajta
// MALLOC ima pointer na prvi bajt alociranog prostora
// Bolje je koristito ALLOC nego MALLOC jer je MALLOC-ov memorijski sadrzaj nepredvidiv

// # 158 # // Razlika izmedju vizuelnog i nevizuelnog programiranja
// VP zahteva IDE (Integrated Development Environment), za razliku od NVP
// VP koriscenjem IDE-a obezbedjuje brzo programiranje iako se ne zna potpuna jezicka sintaksa
// NVP s^obzirom da ne korsiti IDE, od progrmera trazi da bude ekspert jezicke sintakse, kao i brzog kucnaja
// VP tokom kucanja obezbedjuje mogucnosti koje mogu da se odaberu, oznacava greske, predlaze funkcije itd,
// NVP nema ove mogucnoti
// VP moze napraviti program koristeci graficke elemente, npr koriscenjem GUI-ja
// NVP mora da se program napravi tekstualno, jer nema GUI nego Text Based Interface

// # 159 # // Razlika izmedju strukturalnog i objektno orijentisanog programiranja
// SP se prvenstveno zasniva na procesima i logickim strukturama, a tek onda na podacima potrebnim za te procese
// OP se prvenstveno zasniva na podacima
// SP prati izvrsenje odozgo na dole, OP prati izvrenje odozdo na gore
// SP se drugacije naziva modularno programiranje i kod njega se koriste proceduralni programski jezici
// OP podrazumeva nasledjivanje, enkapsulaciju, apstrakciju, polimorfizam itd
// SP progrmae deli na male i kontinuirane funkcije
// OP progrmae deli na male entitete - objekte
// SP je manje bezbedan jer ne postoji nacin skrivanja podataka kao kod OP
// SP moze resiti moderatorno kompleksne programe, OP moze resiti bilo koji komplekni program
// SP ima manju mogucnost za ponovnim oskoriscenjem koda i vecu funkcionalnu zavisnost
// OP ima veliku mogucnost za ponovnim iskoriscenjem koda i manju funkcionalnu zavisnost
// SP ima manju apstrakciju i fleksibilnost za razliku od OP






