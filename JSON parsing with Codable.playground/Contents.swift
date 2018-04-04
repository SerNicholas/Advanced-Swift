import UIKit

// Swift 4 JSON parsing with codable

enum SerialziationErrror: Error {
    case missing(String)
    case invalid(String, Any)
}

// """ novost Swifta 4
let blogPost = """
{
    "post1": {
        "title": "The Complete understanding of Delegate",
        "subtitle": "No more guessing",
        "markdown": "# Title",
        "author": "Vuk Knezevic",
        "tags": ["delgate", "object"]
    }
}
""".data(using: .utf8)! // Native JSON format

// Ovo je stari nacin
struct Post {
    let title: String
    let subtitle: String
    let markdown: String
    let author: String
    let tags: [String]
    
    public init(json: [String: Any]) throws {
        guard let title = json["title"] as? String else {
            throw SerialziationErrror.missing("title")
        }
        
        guard let subtitle = json["subtitle"] as? String else {
            throw SerialziationErrror.missing("subtitle")
        }
        
        guard let markdown = json["markdown"] as? String else {
            throw SerialziationErrror.missing("markdown")
        }
        
        guard let author = json["author"] as? String else {
            throw SerialziationErrror.missing("markdown")
        }
        
        guard let tags = json["tags"] as? [String] else {
            throw SerialziationErrror.missing("tags")
        }
        
        self.title = title
        self.subtitle = subtitle
        self.markdown = markdown
        self.author = author
        self.tags = tags
    }
}


// sada cemo pomocu CODABLE

//model
struct User: Codable {
    var name: String
    var loginMethods: [LoginMethods]
    var numberOfFriends: Int
    
    enum LoginMethods: String, Codable {
        case facebook, instagram, linkedin, twitter
    }
}
//napravimo objekat od ovoga
let vuk = User(name: "Vuk", loginMethods: [.facebook, .instagram], numberOfFriends: 5)

// napravi encoder - to znaci napravi objekat od json-a
let jsonEncoder = JSONEncoder()
jsonEncoder.outputFormatting = .prettyPrinted
var data: Data?
do {
    let jsonData = try jsonEncoder.encode(vuk)
    data = jsonData
    if let jsonString = String(data: jsonData, encoding: .utf8) {
        print(jsonString) // {"name":"Vuk","loginMethods":["facebook","instagram"],"numberOfFriends":5}
    }
} catch let error {
    print(error)
}

// napravimo dekoder - to znaci napravi json od objekta
let jsonDecoder = JSONDecoder()

do {
    let vuk = try jsonDecoder.decode(User.self, from: data!)
    print("Name: \(vuk.name)")
    print("Number of friends: \(vuk.numberOfFriends)")
} catch let error {
    print(error)
}

// Sta je User.self, pa ovo self
let userType = User.self // u sebi on cuva svoj type
userType.init(name: "Vuk", loginMethods: [.facebook, .instagram], numberOfFriends: 5) // i moze se inicijalizovati ukoliko je identican prvobitnom objektu


// jos primera
struct Geek: Codable {
    let staackOverflowId: String
    let name: String
    let platform: String
}

let geek = """
{
    "staackOverflowId": "Vukovi",
    "name": "Vuk",
    "platform": "iOS"
}
""".data(using: .utf8)!

do {
    let geekVuk = try JSONDecoder().decode(Geek.self, from: geek)
    print(geekVuk)
} catch let error {
    print(error)
}

let geeks = """
[
    {
    "staackOverflowId": "Vukovi",
    "name": "Vuk",
    "platform": "iOS"
    },
    {
    "staackOverflowId": "Miramida",
    "name": "Mira",
    "platform": "iOS"
    },
    {
    "staackOverflowId": "Tekila",
    "name": "Teodora",
    "platform": "iOS"
    }
]
""".data(using: .utf8)!

// data to Object (Encode)

do {
    let developers = try JSONDecoder().decode([Geek].self, from: geeks)
    developers.forEach { print($0) }
} catch let error {
    print(error)
}

let geeks2 = """
{
    "1": {
    "staackOverflowId": "Vukovi",
    "name": "Vuk",
    "platform": "iOS"
    },
    "2": {
    "staackOverflowId": "Miramida",
    "name": "Mira",
    "platform": "iOS"
    },
    "3": {
    "staackOverflowId": "Tekila",
    "name": "Teodora",
    "platform": "iOS"
    }
}
""".data(using: .utf8)!

// data to Object (Encode)

do {
    let developers = try JSONDecoder().decode([String:Geek].self, from: geeks2)
    developers.forEach { print("\($0.key): \($0.value)") }
} catch let error {
    print(error)
}

