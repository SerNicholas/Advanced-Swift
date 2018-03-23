import UIKit

// Error handling koristi umesto masivnog if/else if/else if/.../else koda
func checkHeight(height: Int) {
    if height > 200 {
        print("Previsoko")
    } else if height < 140 {
        print("Prenisko")
    } else {
        print("Visina je u redu")
    }
}

// Napravi Error 1/3
enum HeightError: Error {
    case maxHeight
    case minHeight
}

// napravi funkciju sa error-om 2/3
func checkHeightError(height: Int) throws {
    if height > 200 {
        throw HeightError.maxHeight
    } else if height < 140 {
        throw HeightError.minHeight
    } else {
        print("Visina je u redu")
    }
}

// hendluj error 3/3
do {
    try checkHeightError(height: 300)
} catch HeightError.maxHeight {
    print("Previsoko")
} catch HeightError.minHeight {
    print("Prenisko")
}



// Error Handling with Object Initialization

//napravi error
enum NameError: Error {
    case noName
}

class Course {
    var name: String
    
    init(name: String) throws {
        if name == "" {
            throw NameError.noName
        } else {
            self.name = name
            print("Napravljan je objekt")
        }
    }
}

do {
    let myCourse = try Course(name: "Vuk")
} catch NameError.noName {
    print("Upisi ime")
}


//izbegavanje do/catch bloka
let newCourse = try? Course(name: "") //ovo je nil
//let newCourse2 = try! Course(name: "") //ovo je unwrapovan nil i zbog toga puca

