import UIKit

// Enum sadrzi svoj enum tip

func recursiveFunction() {
    print("Cao")
    recursiveFunction()
}

// Indirektni nacin jer koristimo svoj enum tip u additon i mlutiplication
indirect enum ArithmeticExpressions {
    case number(Int)
    case addition(ArithmeticExpressions, ArithmeticExpressions)
    case multiplication (ArithmeticExpressions, ArithmeticExpressions)
}

ArithmeticExpressions.number(4)
let additionEnum = ArithmeticExpressions.addition(.number(5), .number(10))
print(additionEnum) // addition(__lldb_expr_75.ArithmeticExpressions.number(5), __lldb_expr_75.ArithmeticExpressions.number(10))
let multiplicationEnum = ArithmeticExpressions.multiplication(.number(3), .number(2))

let five = ArithmeticExpressions.number(5)
let four = ArithmeticExpressions.number(4)

func evaluate(_ expression: ArithmeticExpressions) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

evaluate(.number(4)) // 4
evaluate(additionEnum) // 15
evaluate(multiplicationEnum) // 6


// Alternativni normalni enum
enum Operation {
    case addition(Int, Int)
    case mulitplication(Int, Int)
    
    var result: Int {
        switch self {
        case let .addition(num1, num2):
            return num1 + num2
        case let .mulitplication(num1, num2):
            return num1 * num2
        }
    }
}

Operation.addition(4, 4).result // 8

// Jos jedna alternativa
struct StructOperation {
    func addTwoNumbers(_ number1: Int, _ number2: Int) -> Int {
        return number1 + number2
    }
    func multiplyNumbers(_ number1: Int, _ number2: Int) -> Int {
        return number2 * number1
    }
}

StructOperation().addTwoNumbers(3, 4) // 7 ali smo morali da napravimo objeat da bi ovo radilo

// Bolje
struct MathOperation {
    static let addition: (Int, Int) -> Int = { $0 + $1 }
    static let multiplication: (Int, Int) -> Int = { $0 * $1 }
}

MathOperation.addition(3, 5) // 8


