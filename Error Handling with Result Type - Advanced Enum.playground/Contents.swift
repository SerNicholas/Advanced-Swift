import UIKit

// Error Handling With Result Type
// Error handling bez native Error handlera

enum HTTPError {
    case notFound404
    case forbidden403
}

enum ResultType<T> {
    case success(T)
    case failure(HTTPError)
}

let success = ResultType.success("JSON, Image")
let failure: ResultType<Any> = ResultType.failure(.notFound404)

// funkcije
func findSubDomain(subdomain: String) -> ResultType<String> {
    switch subdomain {
    case "business":
        return ResultType.failure(.forbidden403)
    case "blog":
        return ResultType.failure(.notFound404)
    default:
        return ResultType.success("Website found!")
    }
}

// Izvrsi funkciju (kao do try)
let result = findSubDomain(subdomain: "business") // Forbidden
// handle errror
switch result {
case let .success(data):
    print(data)
case let .failure(errorType):
    switch errorType {
    case .notFound404:
        print("Nor found")
    case .forbidden403:
        print("Forbidden")
    }
}
