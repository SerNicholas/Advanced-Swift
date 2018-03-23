import UIKit

//: COMPLETION HANDLERS

// koriste se kad treba uraditi neku radnju posle neke odredjene radnje
// npr obavestiti korisnika o zavrsetku download-a

let firstVC = UIViewController()
let nextVC = UIViewController()

firstVC.present(nextVC, animated: true, completion: nil)
firstVC.present(nextVC, animated: true) {
    print("Gotovo") // odigrava se tek posto se predje na drugi VC
}

// Napravi Handler Block

let myHandlerBlock: (Bool) -> Void = {
    isSucces in
    if isSucces {
        print("Download je gotov")
    }
}
myHandlerBlock(true) //opet je dato izvrsenje sa trazenom vrednosti ovaj put


let handlerBlock: (Bool) -> Void = {
    if $0 {
        print("Download je opet gotov")
    }
}
handlerBlock(true)

// naparviti pomocu funkcije
func downloadImage(completionHandler: (Bool) -> Void) {
    for _ in 1...10 {
        print("Downloading...")
    }
    completionHandler(true)
}

// prenet closer indirektno
downloadImage(completionHandler: handlerBlock)

// prenet closer direktno
downloadImage { (success) in
    if success {
        print("Done")
    }
}

// jos jedan primer
let handler: ([String]) -> Void = { (array) in
    print("Done working \(array)")
}

handler(["Blog", "Course", "Editing"]) // Done working ["Blog", "Course", "Editing"]


func completeBlockFunction(withBlock:([String]) -> Void) {
    for _ in 1...10 {
        print("Downloading.........")
    }
    withBlock(["image1","image2","image3","image4"])
}

// unos klozera indirektno
completeBlockFunction(withBlock: handler) // Downloading....... nekoliko puta pa onda, Done working ["image1", "image2", "image3", "image4"]

// unos klozera direktno
completeBlockFunction(withBlock: { (images: [String]) in
    print("Zavrseno \(images)")
}) // Downloading....... nekoliko puta pa onda, Zavrseno ["image1", "image2", "image3", "image4"]







