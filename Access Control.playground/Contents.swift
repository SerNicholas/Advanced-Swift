import UIKit

// MODUL je bundle koda.
// Xcode project/framework/bundle se smatra jednim modulom.


// OPEN - najotvoreniji vid access kontrole. Mogu da pravim subklase u mom modulu iako su nadklase u drugom modulu.
// PUBLIC - isto sto i OPEN samo sa nesto ogranicenijim pristupom. Moze se override-ovati samo u subclassama koje su unutar modula u kom je i nadklasa
// INTERNAL - defaultni access kontrol. Ne pise se jer se podrazumeva, a moze se dodati. Klase su dostupne samo unutar svog modula.
// FILEPRIVATE - metode i property-ji su dostupni unutar samo jednog swift file-a.
// PRIVATE - najveca kontrola pristupa. Metode i property-ji se mogu koristiti samo unutar naznacene klase.

