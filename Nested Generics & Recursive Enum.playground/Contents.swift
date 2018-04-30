import UIKit

//: Nested generics and Recursive Enum

// Ranije u Swiftu 3
// Genericki Enum

enum Gadget<T> {
    case smartphone
    case laptop
    case fridge
    case others(T)
}

enum Company<T> {
    case Samsung
    case Apple
    case Sony
    case others(T)
}

// sada cemo da dizajniramo proizvod, jednu strukturu koja ce da objedini oba enuma
struct Product<T> {
    let company: Company<T>
    let gadget: Gadget<T>
    let reviews: [T]
    
    init(enterComapny: Company<T>, enterGadget: Gadget<T>, enterReview: [T]) {
        company = enterComapny
        gadget = enterGadget
        reviews = enterReview
    }
}

// S'obzirom da je T kao genericki paramter prosledjen kroz strukturu Product i na dva enuma koji takodje imaju neki svoj genericki paramtera T, svi oni zajedno, diktirani T-om iz struct Product postaju String jer je tako definisano u instanci myProduct upisivanjem "Good, silver, but expensive" !!!!!
let myProduct = Product(enterComapny: .Apple, enterGadget: .fridge, enterReview: ["Good, silver, but expensive"])


// medjutim ovaj nacin je "pogresan" zbog mnogo ponvaljanja, pre svega parametra T
// BOLJE......

struct Team<T> {
    struct TeamMember {
        // ovo su nested generici
        let name: T?
        let age: T?
    }
}

struct NestedProduct<T> {
    indirect enum Gadget { // ovo indirect sam postavio zbog cyclic dependency, mada u swift-u 4 nema potrebe da se dodaje jer je taj bug resen
        case smartphone
        case laptop
        case fridge
        case others(T)
    }
    
    indirect enum Company {
        case Samsung
        case Apple
        case Sony
        case others(T)
    }
    
    let company: Company
    let gadget: Gadget
    let reviews: [T]
    
    init(enterComapny: Company, enterGadget: Gadget, enterReview: [T]) {
        company = enterComapny
        gadget = enterGadget
        reviews = enterReview
    }
}

// https://bugs.swift.org/browse/SR-3779
let appleFridge = NestedProduct(enterComapny: .Apple, enterGadget: .fridge, enterReview: ["Good"])
// Ovde se ranije desavao CYCLIC DEPENDENCY - odnos dva ili vise objekata ili modula koji direktno ili indirektno zavise jedan od drugog da bi funkcionisali kako treba, a to moze dovesti do nemogucnosti ponovnog upotrebljavanja svakog pojedinacnog modula



// RECURSIVE ENUM

// Referentni tip VS. Vrednosni tip u ASSOCIATED VALUE

class VukClass{}
struct VukStruct {}
enum VukEnum{
    case vukCase
}

let vukClass = VukClass()
let vukStruct = VukStruct()
let vukEnum = VukEnum.vukCase

enum VEnum {
    case myClass(VukClass) // ima referencu na klasu VukClass
    case myStruct(VukStruct) // ovde se samo skladisti ova struktura
    case myEnum(VukEnum) // i ovde samo skladisti, ali direktno ovaj enum
}

VEnum.myClass(vukClass)
VEnum.myStruct(vukStruct)
VEnum.myEnum(vukEnum)

// Znacenje INDIRECT ENUM prema BINARY TREE
// normalan enum ima sve vrednosti unutar sebe, a indirect enum ima vrednosti koje referencira, kao na crtezu dole, a da je normalan enum crtez bi izgledao tako da su 3, 5, 1 i 2 svi unutar 4

indirect enum Tree { // koristio indirect jer unutar sebe korisit parametre koji su njegovog tipa
    case Empty
    case Node(value: Int, left: Tree, right: Tree)
}

// rekurzivna funkcija koja sumira vrednosti piramidalno
func evaluateTree(tree: Tree) -> Int {
    switch tree {
    case .Empty:
        return 0
    case .Node(let value, let left, let right):
        return value + evaluateTree(tree: left) + evaluateTree(tree: right)
    }
}

/*
 
     4    cetvorka ima drvo levo i desno
    / \
   3   5  trojka ima drvo levo i desno, petica nema
  / \
 1   2    jedinica nema drvo levo i desno, kao ni dvojka
 
*/



let tree1 = Tree.Node(value: 1, left: Tree.Empty, right: Tree.Empty)
let tree2 = Tree.Node(value: 2, left: Tree.Empty, right: Tree.Empty)
let tree3 = Tree.Node(value: 3, left: tree1, right: tree2)
let tree5 = Tree.Node(value: 5, left: .Empty, right: .Empty)
let tree4 = Tree.Node(value: 4, left: tree3, right: tree5)

evaluateTree(tree: .Empty) // 0
evaluateTree(tree: tree1) // 1
evaluateTree(tree: tree2) // 2
evaluateTree(tree: tree3) // 6
evaluateTree(tree: tree5) // 5
evaluateTree(tree: tree4) // 15
