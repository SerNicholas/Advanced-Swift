import UIKit

let highSchoolGrades = [2.8, 3.2, 3.5, 3.8, 3.5]
let favourutePeople = ["Steve Jobs", "Michael Jordan", "Vladimir Putin"]
let favouriteNumbers = [3, 20]

// na pocetku programerske karijere ovako bi se pisao kod

// 1) najgori nacin
highSchoolGrades[0]
highSchoolGrades[1]
highSchoolGrades[2]

// 2) nesto bolji, i dalje pocetnicki, nacin
func printDoubleElement(array: [Double]) {
    for GPA in array {
        print(GPA)
    }
}

func printStringElement(array: [String]) {
    for person in array {
        print("I love \(person)")
    }
}

func printNumberElement(array: [Int]) {
    for number in array {
        print("I like \(number)")
    }
}

// 3) Generic nacin
func genericFunction<anything>(value: anything) {
    print(value)
}
genericFunction(value: "Vuk")
genericFunction(value: 123)

func genericMethod<T>(value: T) {
    print(value)
}

// 3) Generic nacin
func printElement<T>(array: [T]) {
    for element in array {
        print(element)
    }
}
printElement(array: highSchoolGrades)
printElement(array: favourutePeople)


// primena na klase, strukture i protokole

struct Family {
    var members: [String] = []
    // mutating se dodaje funckijama u strukturama i enumeratorima, ako se one bave promenom vrednosti property-ja sturkture ili enumeratora
    mutating func push(member: String) {
        members.append(member)
    }
}

var myFam = Family()
myFam.push(member: "Vuk")
myFam.members

//ovo je dupliranje prethodne klase tako da bi trebalo napraviti genericku strukturu
struct FamilyNumber {
    var members: [Int] = []
    mutating func push(member: Int) {
        members.append(member)
    }
}

//genericka struktura
struct GenericFamily<T> {
    var members: [T] = []
    mutating func push(member: T) {
        members.append(member)
    }
}

//inicijalizacija genericke strukture
let myHappyFamily = GenericFamily(members: [1,2,3,4,5]) //implicitno definisana
var genericFmaily = GenericFamily<Int>() //eksplicitno definisana
genericFmaily.push(member: 10)

//genericki extension
extension GenericFamily {
    var firstElement: T? {
        if members.isEmpty {
            return nil
        } else {
            return members.first
        }
    }
}

genericFmaily.firstElement

// TYPE CONSTRAINT
class LOL {}
class BabyLol: LOL {}

let example = LOL()
let baby = BabyLol()

func addLOLClassOnly<T: LOL>(array: [T]){}
addLOLClassOnly(array: [example, example])
addLOLClassOnly(array: [baby, baby])


