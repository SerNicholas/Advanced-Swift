import UIKit

// GCD - thread pool pattern

// telefon operise sa ove dve niti, a vecinu stvari obavlja main thread
let main = DispatchQueue.main // defaultni glavni
let background = DispatchQueue.global() // defaultni pozdainski

// Serijski redovi (serial queue) obavljaju jedna po jedan zadatak i mogu se koristiti za sinhronizovani pristup nekom resursu
// Paralelni redovi (concurrent queue) obavljaju jedan ili vise zadataka istovremeno u zavisnosti od kompleksnosti zadataka


// Sinhrono izvrsenje zadataka ceka da on bude gotov pre nego sto oslobodi kontrolu, DAKLE CEKA NA IZVRSENJE SVOG BLOKA
// Asinhrono izvrsenje zadatka ne ceka da on bude gotov vec odmah oslobadja kontrolu, SVOJ BLOK PRESKACE I ODMAH CITA SLEDECI RED KOD POSLE SVOG BLOKA

// Sync vs Async
func doSync() {
    background.sync { // background
        for _ in 1...3 {
            print("pozadina")
        }
    }
    
    for _ in 1...3 { // main
        print("front")
    }
}
doSync() // pozadina, pozadina, pozadina, front, front, front

func doAsync() {
    background.async { // background
        for _ in 1...3 {
            print("pozadinski")
        }
    }
    
    for _ in 1...3 { // main
        print("frontalno")
    }
}
doAsync() // ne ceka se print prve tri POZDINSKI, pa onda FRONTALNO, vec je print istovremen i ne znamo kakav ce redosled biti npr pozadinski, pozadinski, frontalno, pozadinski, frontalno, frontalno



// napravicemo custom redove
let serialQueue1 = DispatchQueue(label: "custom_queue_serial_1")
let serialQueue2 = DispatchQueue(label: "custom_queue_serial_2")

func doCustomSerialQueuesAsync() {
    serialQueue1.async {
        for _ in 1...5 {
            print("+")
        }
    }
    serialQueue2.async {
        for _ in 1...5 {
            print("-")
        }
    }
}
doCustomSerialQueuesAsync() // + + + - + + - - - -   ne znamo kojim ce redosledom biti obradjeno


//: Nivoi prioriteta u dispatch redu
// 1 userInteractive (highest Priority)
// 2 userInitiated
// 3 default
// 4 utility
// 5 background
// 6 unspecified (lowest )

let serialQueue3 = DispatchQueue(label: "custom_queue_serial_3", qos: .background) // nizi prioritet
let serialQueue4 = DispatchQueue(label: "custom_queue_serial_4", qos: .userInitiated) // visi prioritet

func serialQueueAsync () {
    serialQueue3.async {
        for _ in 1...5 {
            print("A")
        }
    }
    serialQueue4.async {
        for _ in 1...5 {
            print("B")
        }
    }
}
serialQueueAsync() // vise je B-ova uradio nego A-ova, tj njih je favorizovao zbog prioriteta


// jos jedan serijski queue
let serialQueue = DispatchQueue(label: "jos-jedan-serijski-red")
func serialQueueWork() {
    serialQueue.async {
        for _ in 1...3 {
            print("1")
        }
    }
    serialQueue.async {
        for _ in 1...3 {
            print("2")
        }
    }
    serialQueue.async {
        for _ in 1...3 {
            print("3")
        }
    }
}
serialQueueWork() // 1 1 1 2 2 2 3 3 3

// paralelni red
let concurrentQueue = DispatchQueue(label: "paralelni_red", qos: .utility, attributes: .concurrent)

func parallelQueueWork() {
    concurrentQueue.async {
        for _ in 1...3 {
            print("$")
        }
    }
    concurrentQueue.async {
        for _ in 1...3 {
            print("£")
        }
    }
    concurrentQueue.async {
        for _ in 1...3 {
            print("€")
        }
    }
}
parallelQueueWork() // $ £ € $ $ £ € £ €


//: INACTIVE QUEUE
var inactiveQueue: DispatchQueue!
func workIncativeQueue() {
    let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility, attributes: .initiallyInactive)
    inactiveQueue = anotherQueue
    anotherQueue.async {
        for _ in 1...3 {
            print("∑")
        }
    }
    anotherQueue.async {
        for _ in 1...3 {
            print("π")
        }
    }
    anotherQueue.async {
        for _ in 1...3 {
            print("ß")
        }
    }
}
workIncativeQueue()
if let queue = inactiveQueue {
    queue.activate()
}


//: Delaying execution
let delayQueue = DispatchQueue(label: "com.appcoda.delayqueue", qos: .userInitiated)
print(Date()) // 2018-03-14 12:10:27 +0000
let additionalTime: DispatchTimeInterval = .seconds(2)
func queueWithDelay() {
    delayQueue.asyncAfter(deadline: .now() + additionalTime) {
        print(Date())
    }
}
queueWithDelay() // 2018-03-14 12:10:29 +0000

//: DISPATCH WORK ITEM
var value = 5
let workItem = DispatchWorkItem {
    value += 10
}
value // 5
workItem.perform()
value // 15

let queue = DispatchQueue.global()
queue.async(execute: workItem)
value // 25

func useWorkItem() {
    var value = 10
    let workItem = DispatchWorkItem {
        value += 5
    }
    workItem.perform()
    let queue = DispatchQueue.global(qos: .utility)
    queue.async(execute: workItem)
    workItem.notify(queue: DispatchQueue.main) {
        print("value = ", value)
    }
}
useWorkItem()



//: Performing background tasks and then updating the UI
DispatchQueue.global(qos: .background).async {
    //background work
    DispatchQueue.main.async {
        //update UI
    }
}

//: Beware of deadlocks with serial queue
let customSerialQueue = DispatchQueue(label: "com.yogevsitton.MyApp.myCustomSerialQueue")
customSerialQueue.sync {
    // Synchronous code
//    customSerialQueue.sync {
//        // This code will never be executed and the app is now in deadlock
//    }
}

//: Beware of Synchronously running on the main thread from a synchronous background thread
DispatchQueue.global(qos: .utility).sync {
    // Background Task
//    DispatchQueue.main.sync {
//        // App will crash
//    }
}


