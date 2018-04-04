import UIKit

let geek = """
{
    "staackOverflowId": "Vukovi",
    "name": "Vuk",
    "platform": "iOS"
}
""".data(using: .utf8)!

struct Geek: Codable {
    let username: String
    let name: String
    let platform: String
    
    enum CodingKeys: String, CodingKey {
        case username = "stackOverflowId"
        case name
        case platform
    }
}

let geekObject = Geek(username: "Vuk", name: "Vukovi", platform: "iOS")
let encoder = JSONEncoder()

do {
    let data = try encoder.encode(geekObject)
    print(String(data: data, encoding: .utf8)!) // {"staackOverflowId":"Vuk","name":"Vukovi","platform":"iOS"}
} catch let error {
    print(error)
}




// Potpuno cutomizovanje podvrgavanjem protokolu Encodable

struct Blog {
    let author: String
    let id: Int
    let url: URL
    
    enum BlogCodingKeys: String, CodingKey {
        case author
        case id
        case url
    }
}

extension Blog: Encodable {
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: BlogCodingKeys.self) // slicno JSONu
        
//        try container.encode(author, forKey: .author)
        try container.encode(id, forKey: .id)
        try container.encode(url, forKey: .url)
        
    }
}


let post = Blog(author: "Bob", id: 1, url: URL(string: "https://google.com")!)

do {
    let myBlog = try JSONEncoder().encode(post)
    let string = String(data: myBlog, encoding: .utf8)
    print(string!)
// Optional("{\"id\":1,\"author\":\"Bob\",\"url\":\"https:\\/\\/google.com\"}")
//    Optional("{\"id\":1,\"url\":\"https:\\/\\/google.com\"}")
    // ovaj donji se stampa ovzko zbog zakomentarisanog reda u ekstenziji Blog
    // a inace property POST automatski poziva svoj encode kada se postavi u JSONEncoder().encode(post), zbog protokola Encodable
} catch let error {
    print(error)
}



// Potpuno cutomizovanje podvrgavanjem protokolu Decodable

struct User {
    let name: String
    let citizenship: String
    let id: Int
    
    init(name: String, citizenship: String, id: Int) {
        self.name = name
        self.citizenship = citizenship
        self.id = id
    }
}

extension User: Decodable {
    enum UserCodingKeys: String, CodingKey {
        case name // = "fullname"
        case id
        case citizenship
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        
        let name: String = try container.decode(String.self, forKey: .name)
        let citizenship: String = try container.decode(String.self, forKey: .citizenship)
        let id: Int = try container.decode(Int.self, forKey: .id)
        
        self.init(name: name, citizenship: citizenship, id: id)
        // ovde bi imao potupnu kontrolu nad parsiranjem, ako bih npr promenio citizenship: "Srbija", promenio bih ono sto se dobija iz API-ja
        
    }
    
}
