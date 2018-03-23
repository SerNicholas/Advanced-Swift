import UIKit

//: DELEGATE PATTERN

// Komunikacija izmedju dva objekta

protocol PassDataDelegate {
    func passData(data: String)
}

// Design Delegator (Sender)
class FirstVC {
    var delegate: PassDataDelegate?
}

FirstVC().delegate?.passData(data: "prenesi ovo") // nil jer delegat nije instanciran i nije u komunikaciji ni sa kim

// Design Delegate (Receiver)
class SecondVC: PassDataDelegate {
    func passData(data: String) {
        print("PRENETO: \(data)")
    }
}

// Create objects
let firstVC = FirstVC()
let secondVC = SecondVC()

// Assign Delegate
firstVC.delegate = secondVC
firstVC.delegate?.passData(data: "prenesi ovo opet")



//: Praktični primer
class TableVC: UIViewController, UITableViewDelegate {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}


//: DATA SOURCE PATTERN
// Isto sto i delegate patern samo sto radi dvosmerno

protocol DataDelegate {
    func passData(data: String) -> String
}

// Design delegator (Sender)
class PrviVC {
    var delegate: DataDelegate?
}

// Design delegate (Receiver)
class DrugiVC: DataDelegate {
    func passData(data: String) -> String {
        print("Podaci su: \(data)")
        return "Dobio podatke"
    }
}

let prviVC = PrviVC()
let drugiVC = DrugiVC()

prviVC.delegate = drugiVC
let message = prviVC.delegate?.passData(data: "za prenos")
print(message!)

// Prakticni primer
class TableViewCtrl: UIViewController, UITableViewDataSource {
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200 //ovo se vraca TableVIew() koji je sender u stvari
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: "cell") // vracamo senderu
    }
}










