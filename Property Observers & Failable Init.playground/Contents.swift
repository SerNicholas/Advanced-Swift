import UIKit

var myGrade: Int = 80
myGrade = 100

// Kako napraviti observer a da ne moraju da se prave funkcije koje ce to da rade

var mojaOcena: Int = 80 {
    willSet {
        print("ovo se zove pre nego sto se 80 promeni u neki drugi broj: \(newValue)")
    }
    didSet {
        print("ovo se zove posto se 80 promeni u neki drugi broj: \(oldValue)")
    }
}

mojaOcena = 100

// Step counter
var totalSteps: Int = 20 {
    willSet(newTotalSteps){
        print("Podesi broj koraka na: \(newTotalSteps)")
    }
    didSet {
        if totalSteps > oldValue {
            print("Dodato \(totalSteps - oldValue) koraka")
        }
    }
}

totalSteps = 50
totalSteps = 45


// primena property observera
var userLoggedIn: Bool = false {
    willSet{
        print("User has tried something")
    }
    didSet {
        if userLoggedIn {
            print("User switched from \(oldValue) to \(userLoggedIn)")
        }
    }
}

userLoggedIn = true //User switched from false to true
userLoggedIn = true //User switched from true to true



//: FAILABLE INIT

enum NameError: Error {
    case noName
}

struct UdemyCourse {
    let courseName: String
    init(name: String) throws {
        if name.isEmpty {
            throw NameError.noName
        }
        self.courseName = name
    }
}

do {
    let myCourse = try UdemyCourse(name: "Vuk")
    myCourse.courseName
} catch NameError.noName {
    print("Molim te unsei svoje ime")
}

//sada cemo dizjanirati failable init method
class Blog {
    let name: String
    init?(name: String){ //zbog ovog opcionala postaje failabel initializator
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

let blogger = Blog(name: "Blogger")
let realBlogger = blogger!











