import UIKit

// Enum unutar enuma

// Uvod
enum FutureCourse {
    enum LearnSwift: String {
        case genericProtocol
        case advancedEnum
        
        var chapterDescription: String {
            return self.rawValue
        }
    }
    
    enum UIKitFundamentals: String {
        case realmDatabase
        case noStoryboard
        case cloudComputing
        
        var chapterDescription: String {
            return self.rawValue
        }
    }
}

FutureCourse.LearnSwift.genericProtocol.chapterDescription
FutureCourse.UIKitFundamentals.noStoryboard.chapterDescription

//: Game design
struct Character {
    enum CharcterType {
        case prince
        case warrior
        case priest
    }
    
    enum Skill {
        case airwalk
        case transparency
        case prediction
    }
    
    let type: CharcterType
    let skill: Skill
}


let vuk = Character(type: .warrior, skill: .prediction)

enum Wearable {
    enum Weight: Int {
        case light
        case medium
        case heavy
    }
    
    enum Price: Int {
        case leather
        case iron
        case steel
    }
    
    case armor(weifgt: Weight, price: Price)
    
    func getDescription() -> String {
        switch self {
        case let .armor(weight, price):
            return "Odabrani su \(weight) i \(price)"
        }
    }
    
}

let myCLothes = Wearable.armor(weifgt: .heavy, price: .steel)
myCLothes.getDescription() // "Odabrani su heavy i steel"



