import UIKit

// Sequence & Iterator

// Kako radi for petlja

let iOSSkills = ["Swift", "UIKit", "RxSwift", "TDD"] //TDD = TestDrivenDevelopment
for skill in iOSSkills {
    print(skill)
}

// Sta se dogadja u pozadini

var skillIterator = iOSSkills.makeIterator()
while let skill = skillIterator.next() { // ovako ga unwrapujem dok ne bude nil
    print(skill)
}

let numbers = [2,3,5,7]
var numberIterator = numbers.makeIterator()
numberIterator.next() // 2
numberIterator.next() // 3
numberIterator.next() // 5
numberIterator.next() // 7
numberIterator.next() // nil
numberIterator.next() // nil itd


struct MyCountdown: Sequence {
    let start: Int
    //ovde se mora primeniti tip koji je tipa Iterator
    func makeIterator() -> CountdownIterator {
        return CountdownIterator(self)
    }
}

struct CountdownIterator: IteratorProtocol {
    // typealias i func NEXT moraju biti isti tip
    typealias Element = Int
    mutating func next() -> Element? {
        let nextNumber = countdown.start - times
        guard nextNumber > 0 else { return nil }
        times += 1
        return nextNumber
    }

    let countdown: MyCountdown
    var times = 0
    init(_ countdown: MyCountdown) {
        self.countdown = countdown
    }
}


var threeTwoOne = MyCountdown(start: 3)
var iterator = threeTwoOne.makeIterator()
iterator.next() // 3
iterator.next() // 2
iterator.next() // 1
iterator.next() // nil

for count in threeTwoOne {
    print("\(count)") // 3  2  1
}






















