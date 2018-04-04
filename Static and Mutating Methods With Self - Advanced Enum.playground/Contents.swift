import UIKit

// Primer sa Storyboard
enum Storyboard: String {
    case profile
    case setting
    case newsfeed
    
    var identifier: String {
        return self.rawValue
    }
}

let profile = Storyboard.profile // ovo je objekat
profile.identifier // "profile"

//: API Guideline Goal
func descibeStoryboard(storyboard: Storyboard) -> String {
    switch storyboard {
    case .profile:
        return "\(storyboard.identifier): Profile picture, followers"
    case .setting:
        return "\(storyboard.identifier): Logout, invite"
    case .newsfeed:
        return "\(storyboard.identifier): videos, texts"
    }
}

descibeStoryboard(storyboard: Storyboard.profile) // "profile: Profile picture, followers"


//: Mutating Methods
enum MealProcess: String {
    case breakfast, lunch, dinner
    
    var description: String {
        return self.rawValue
    }
    
    mutating func nexMeal() {
        print("Prelazimo na: \(self.description)")
        
        switch self {
        case .breakfast:
            self = .lunch
            print("Rucao sam")
        case .lunch:
            self = .dinner
            print("Vecerao sam")
        case .dinner:
            self = .breakfast
            print("Doruckovao sam")
        }
    }
    
}


var currentMeal = MealProcess.breakfast
currentMeal.nexMeal() // Prelazimo na: breakfast    Rucao sam
currentMeal.nexMeal() // Prelazimo na: lunch    Vecerao sam


//: Static Method
enum AppleDevices: String {
    case iWatch, iPhone, iMac, MacPro
    
    static func getAppleDevice(name: String) -> AppleDevices? {
        switch name {
        case "iWatch":
            return .iWatch
        case "iPhone":
            return .iPhone
        case "iMac":
            return .iMac
        case "MacPro":
            return .MacPro
        default:
            return nil
        }
    }
    
    // mnogo bolja varijanta bez ponavljanja
    static func getProduct(name: String) -> AppleDevices? {
        return AppleDevices(rawValue: name)
    }
    static func getAppleDevices(enterName: String) -> AppleDevices? {
        switch enterName {
        case "iWatch", "iPhone", "iMac", "MacPro":
            return getProduct(name: enterName)
        default:
            return nil
        }
    }
}

let userProduct = AppleDevices.getAppleDevice(name: "S8") // nil
let userProduct2 = AppleDevices.getAppleDevice(name: "MacPro") // MacPro


// Custom inicijalizacija enuma
enum AppleDevice: String {
    case iWatch, iPhone, iMac, MacPro
    
    init?(name: String){
        if name == "iWatch" {
            self = .iWatch
        } else {
            return nil
        }
    }
}
AppleDevice(name: "iWatch") // iWatch

enum IntCategory {
    case small, medium, big, weird
    
    init(number: Int) {
        switch number {
        case 0..<1000:
            self = .small
        case 1000..<1000000:
            self = .medium
        case 100000..<1000000:
            self = .big
        default:
            self = .weird
        }
    }
}

IntCategory(number: 1237273232) // weird

// Practical case
enum HttpError: String {
    case Code400 = "Bad Request"
    case Code401 = "Unauthorized"
    case Code402 = "Payment Required"
    case Code403 = "Forbidden"
    case Code404 = "Page Not Found"
    
    var description: String {
        return self.rawValue
    }
}

HttpError.Code400.description // Bad Request

enum CellType: String {
    case ButtonValueCell
    case UnitEditCell
    case LabelCell
    case ResultLabelCell
    
    var name: String {
        return self.rawValue
    }
}

enum NavigationTheme {
    case Placid
    case Warning
    case Danger
    
    var barTintColor: UIColor {
        switch self {
        case .Placid: return UIColor.clear
        case .Warning: return UIColor.blue
        case .Danger: return UIColor.red
        }
    }
}

let colorSituation = NavigationTheme.Placid
colorSituation.barTintColor // clear color


extension NavigationTheme {
    init(numberOfTask: Int) {
        switch numberOfTask {
        case 0...3:
            self = .Placid
        case 4...9:
            self = .Warning
        default:
            self = .Danger
        }
    }
}

let currentColor = NavigationTheme(numberOfTask: 3).barTintColor
