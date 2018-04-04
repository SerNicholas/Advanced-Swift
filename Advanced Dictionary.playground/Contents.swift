import UIKit

// Funkcioanlno programiranje vezano za recnike

// ranije
var myInfo = ["name":"Vuk", "age":"35"]
var name = myInfo["name"] // Vuk

// defaultne vrednosti recnika
let footSize = myInfo["footsize", default: "No Value"]
let myName = myInfo["name", default: "No Value"] // Vuk

// Prakticna primena default-a
let contacts = ["Julia", "Susan", "John", "Alice", "Alex"]
// kako ovo uraditi
["J":["Julia", "John"], "S":["Susan"], "A":["Alice", "Alex"]]

let gruped = Dictionary(grouping: contacts, by:{ $0.first! })
print(gruped) // ["J": ["Julia", "John"], "S": ["Susan"], "A": ["ALice", "ALex"]]

// Remove duplicates
let duplicates = [("a",1), ("b",7),("a",3),("b",10)]
let myLetter = Dictionary(duplicates, uniquingKeysWith: {(letter, number) in letter})
print(myLetter) // ["b": 7, "a": 1]

// Zip

let words = ["one", "two", "three", "four"]
let numbers = 1...words.count

for (word, number) in zip(words, numbers) {
    print("\(word) : \(number)")
}
// one : 1    two : 2    three : 3   four : 4

// Zip To Dictionary

let friends = ["Vuk","Mira", "Alen"]
let friendsWithValue = Dictionary(uniqueKeysWithValues: zip(1..., friends))
print(friendsWithValue) // [2: "Mira", 3: "Alen", 1: "Vuk"]


let set: Set = [1,2,3,4]
let filteredSet = set.filter { $0 % 2 == 0 } // Return Sets
type(of: filteredSet)


let dictionary = ["name":"Vuk", "age":"35", "hairColor":"black"]
let filttered = dictionary.filter {
    $0.key == "name"
}
print(filttered) // ["name": "Vuk"]

let mapped = dictionary.mapValues { value in
    value.uppercased()
}
print(mapped) // ["name": "VUK", "age": "35", "hairColor": "BLACK"]




