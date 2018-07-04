import UIKit

// FlatMap


// 1. PRIMER

var arrayOfArrays = [[1, 1], [2, 2], [3, 3]]

// hocu da dobijem od ovog matrice koja je data prost niz koji treba da izgleda ovako
// [2, 2, 4, 4, 6, 6]

// prvo koristicu MAP da bih dobio ovo [[2, 2], [4, 4], [6, 6]]
arrayOfArrays = arrayOfArrays.map { newArray in
    return newArray.map({ integer in
        return integer * 2
    })
}

// drugo iskoristicu joined() na azuriranoj matrici arrayOfArrays
var flattened = Array(arrayOfArrays.joined()) // [2, 2, 4, 4, 6, 6]

// flatMap
// obavlja aktivnost metode joined()
var matrix = [[1, 1], [2, 2], [3, 3]]
var flatMap = matrix.flatMap {
    $0.map({      // ovde je napravio niz od matrice, kao joined()
        $0 * 2    // ovde je MAP iskoriscen da bi se premapirale vrednosti novog niza
    })
}
print(flatMap) //  [2, 2, 4, 4, 6, 6]


// 2. PRIMER

let numbers = [1, 2, 3]
let numbersMap = numbers.map { return $0 }
print(numbersMap)      // 1, 2, 3
let numberFlatMap = numbers.compactMap { return $0 }
print(numberFlatMap)   // 1, 2, 3

// dakle, u ovom slucaju se i jedan i drugi ponasaju isto
// ali sada ce se videti razlika
// flatMap
// obavlja aktivnost unwrapovanja
// u Swiftu 4 umesto njega koristi se compactMap

let brojevi: [Int?] = [1, nil, 3]
let brojeviMap = brojevi.map { return $0 }
print(brojeviMap)     // Optional(1), nil, Optional(3)
let brojeviFlatMAp = brojevi.compactMap { return $0 }
print(brojeviFlatMAp) // 1, 3


// 3. PRIMER

struct User {
    let id: Int
    let name: String
    let userName: String
    
    init?(dictionary: Dictionary<String,Any>) {
        guard
            let id = dictionary["id"] as? Int,
            let name = dictionary["name"] as? String,
            let userName = dictionary["userName"] as? String
        else {
            return nil
        }
        self.id = id
        self.name = name
        self.userName = userName
    }
}


func getJSON(from urlDictionaries: [Dictionary<String, Any>]?) {
    if let dictionaries = urlDictionaries {
        var users = [User]()
        
        // klasicni nacin
        for dict in dictionaries {
            let user = User(dictionary: dict)
            if let newUser = user {
                users.append(newUser)
            }
        }
        
        // sa flatMap-om
        let closure: (Dictionary<String, Any>) -> User?
        closure = { dict in
            return User(dictionary: dict)
        }
        users = dictionaries.flatMap(closure)
        
        // ili najkrace
        users = dictionaries.flatMap(User.init)
    }
}






