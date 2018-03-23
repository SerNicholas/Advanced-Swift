import UIKit


// delegate pattern za resavanje async taskova

protocol NetworkServiceDelegate: class { // zbog reference cycle-a pise se ovo CLASS
    func didComplete(result: String)
}

class NetworkService {
    weak var delegate: NetworkServiceDelegate? // zbog reference cycle-a pise se ovo WEAK
    
    func fetchDataFromUrl(url: String) {
//        API.request(.GET, url) { result in
            delegate?.didComplete(result: url)
//        }
    }
}

class MyVC: UIViewController, NetworkServiceDelegate {
    
    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.delegate = self
    }
    
    func didComplete(result: String) {
        print("Rezultati sa servera su : \(result)")
    }
    
    @IBAction func didPressButton(sender: UIButton) {
        networkService.fetchDataFromUrl(url: "http://localhost:4000/user")
    }
    
}


// closure pattern za resavanje async taskova
class NetworkService2 {
    var onComplete: ((_ result: String)->())?
    
    func fetchDataFromUrl(url: String) {
        //        API.request(.GET, url) { result in
        onComplete?(url)
        //        }
    }
}

class MyVC2: UIViewController {
    
    let networkService = NetworkService2()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.onComplete = { result in
            print("I got \(result) from the server!")
        }
    }
    
    @IBAction func didPressButton(sender: UIButton) {
        networkService.fetchDataFromUrl(url: "http://localhost:4000/user")
    }

}

