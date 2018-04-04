import UIKit

// Protocol Oriented Enum

// Game Protocol
protocol LifeSpan {
    var numberOfHearts: Int { get }
    mutating func increaseHearts() // heart + 1
    mutating func getAttacked() // heart - 1
}

enum Player: LifeSpan {
    case dead
    case alive(currentHearts: Int)
    
    var numberOfHearts: Int {
        switch self {
        case .dead:
            return 0
        case let .alive(numberOfHeart):
            return numberOfHeart
        }
    }
    
    mutating func increaseHearts() {
        switch self {
        case .dead:
            self = .alive(currentHearts: 1)
        case let .alive(hearts):
            self = .alive(currentHearts: hearts + 1)
            
        }
    }
    mutating func getAttacked() {
        switch self {
        case .alive(let hearts):
            if numberOfHearts <= 1 {
                self = .dead
            } else {
                self = .alive(currentHearts: hearts - 1)
            }
        case .dead:
            break
        }
    }
}


var state = Player.dead.numberOfHearts // 0
var otherState = Player.alive(currentHearts: 12).numberOfHearts // 12
var player = Player.dead
player.increaseHearts() // alive(1)
player.increaseHearts() // alive(2)
player.getAttacked() // alive(1)
player.getAttacked() // dead


// Custom Operators
enum GameAction {
    case Start
    case Pause
    case Stop
    case Restart(dealy: Int)
}

// GameAction.Stop == GameAction.Stop
func == (lhs: GameAction, rhs: GameAction) -> Bool {
    switch (lhs, rhs) {
    case (.Start, .Start), (.Pause, .Pause), (.Stop, .Stop):
        return true
    case let (.Restart(lhsDelay), .Restart(rhsDelay)):
        return lhsDelay == rhsDelay
    default:
        return false
    }
}

GameAction.Restart(dealy: 10) == GameAction.Restart(dealy: 10) // true







