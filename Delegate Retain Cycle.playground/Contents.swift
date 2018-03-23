import UIKit

//: DELEGATE RETAIN CYCLE

// Zasto delegat mora da bude weak var?


protocol SendDataDelegate {}

class SendingVC {
    var delegate: SendDataDelegate?
    
    deinit {
        print("Delegator gone")
    }
}

class ReceivingVC: SendDataDelegate {
     lazy var sendingVC: SendingVC = {
         var vc = SendingVC()
        vc.delegate = self // lazy je doslo zbog ovog self jer nemamo init klase pa lazy-jem se ceka na nju. Uopste kod poruke - use of unresolved identifier self - dodavanjem lazy, otklanjamo problem
        return vc
    }()
    
    deinit {
        print("Delegate gone")
    }
}

var receivingVC: ReceivingVC? = ReceivingVC()

// 1. varijanta
// receivingVC = nil // ovde je doslo do deinit-a jer nismo pozvali lazy var sendingVC, koji je zbog toga nil i nema medjusobnog ukrstanja pa je deinicijalizacija obavljena bez problema

//2. varijanta
receivingVC?.sendingVC
receivingVC = nil // delegat se ovde obrisao i zato i dalje postoji referenca na ReceivingVC, a to je zato sto smo ga pozvali u prethodnoj liniji koda

// ovaj problem se prevazilazi koriscenjem weak var delegate

// retain cycle se dogadja samo prilikom rada sa klasama i klozerima


// 1) weak referenca omogucava referenciranom objektu da postane nil (dogadja se automatski)
// 2) referencirani objekt/variabla mora biti opcional, tj weak var mora biti opcional




