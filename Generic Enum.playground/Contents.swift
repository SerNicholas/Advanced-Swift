import UIKit

// kompleksniji associated value

enum Information<T, U> {
    case name(T)
    case website(T)
    case age(U)
}

Information<String, Int>.name("Vuk") // name("Vuk")
Information<String, Int>.age(35) // age(35)

// Opcional sa Enumom
let quickOptional: String? = "Vuk"
let explicitOptional = Optional("Vuk")
explicitOptional! // Vuk

// Custom Optioanl
enum MyOptioanl<T> {
    case none
    case some(T)
    
    init(_ anyValue: T) {
        self = .some(anyValue)
    }
}

MyOptioanl("Vuk") // some("Vuk")
