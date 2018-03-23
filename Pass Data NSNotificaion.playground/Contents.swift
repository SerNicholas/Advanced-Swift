import UIKit

//: NS Notification

// Sluzi za prenosenje podataka izmedju klasa. Pored NSNotification-a u istu svrhu sluze i Key-Value-Observing, Segue, Target-Action, Callbacks

let notificationKey = "JedinstveniKljucPoKomSeDvaKontroleraPrepoznaju"

class SecondVC: UIViewController {
    
    @IBOutlet weak var secondVCLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ovim primam notifikaciju
        NotificationCenter.default.addObserver(self, selector: #selector(doThisWhenNotify), name: NSNotification.Name(rawValue: notificationKey), object: nil)
    }
    
    @IBAction func tabToNotifyBack(_ sender: UIButton) {
        secondVCLabel.text = "Notification Completed!😜"
        
        // ovim saljem notifikaciju
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationKey), object: nil, userInfo: ["name":"Bob"]) // ovaj recnik saljemo
        
    }
    
    @objc func doThisWhenNotify() {
        print("Posla sam notifikaciju na FirstVC")
    }
}

class FirstVC: UIViewController {
    
    @IBOutlet weak var FirstVCLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //: varijanta bez prenosa recnika
//        NotificationCenter.default.addObserver(self, selector: #selector(doSomethingAfterNotified), name: NSNotification.Name(rawValue: notificationKey), object: nil)
        
        //: varijanta sa prenosom recnika
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notificationKey), object: nil, queue: nil, using: catchNotification) // ako queue NIJE nil onda se podaci prenose GCD-om, a ako je nil kao ovde sto je, onda se prenose sinhrono
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self) // kada nestane view sa ekrana sklanja se i event
    }
    
    @objc func doSomethingAfterNotified() {
        print("I've been notified")
        FirstVCLabel.text = "Damn, I feel your spark 😱"
    }
    
    func catchNotification(notification:Notification) -> Void {
        guard let name = notification.userInfo!["name"] else { return }
        
        FirstVCLabel.text = "My name, \(name) has been passed! 😄"
    }
}










