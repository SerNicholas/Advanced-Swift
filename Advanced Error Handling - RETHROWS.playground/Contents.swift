import UIKit

// Advanced Error Handling

// Sta je RETHROW

enum TestingError: Error {
    case randomError
}

func nonThrow() {
    print("Bez throw-a")
}

func withThrow() throws {
    print("Sa throw-om")
    throw TestingError.randomError
}

func rethrowFuncWithErrorHandling(closure: () throws -> ()) rethrows {
    do {
        try closure()
    } catch TestingError.randomError {
        print("Random Error")
    } catch {
        fatalError("Fatal Error")
    }
}

// ovo je moguce samo ako funkcija ima rethrows, ali da li cu da koristim try, zavisi od paramtra koji joj dam
// tj da li je on throwable ili ne
try? rethrowFuncWithErrorHandling(closure: withThrow)
rethrowFuncWithErrorHandling(closure: nonThrow)
// try rethrowFuncWithErrorHandling(closure: withThrow) // ovo swift dozvoljava u playgroundu samo

