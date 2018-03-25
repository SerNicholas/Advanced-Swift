import UIKit

struct Folder {}
struct Cell {}

protocol Listable {
    associatedtype FileType
    func getFileType() -> String
}

class FolderCell: Listable {
    typealias FileType = Folder
    func getFileType() -> String {
        return "FolderCell with \(FileType.self) type"
    }
}


class CollectionCell: Listable {
    typealias FileType = Cell
    func getFileType() -> String {
        return "CollectionCell with \(FileType.self) type"
    }
}


class ListCell: Listable {
    typealias FileType = Cell
    func getFileType() -> String {
        return "ListCell with \(FileType.self) type"
    }
}


// Napravimo wrapper
// premoscujemo problem pitfall-a

class AnyCell<T>: Listable {
    typealias FileType = T
    
    private let _getFileType: () -> String
    
    init<U: Listable>(_ enterAnyCell: U) where U.FileType == T {
        _getFileType = enterAnyCell.getFileType
    }
    
    func getFileType() -> String {
        return _getFileType()
    }
}

let collectionCell: AnyCell = AnyCell(CollectionCell()) // premosceno
let listCell: AnyCell = AnyCell(ListCell()) // premosceno

print(collectionCell.getFileType()) // CollectionCell with Cell type
print(listCell.getFileType()) // ListCell with Cell type

let fileTypeWithCells = [collectionCell, listCell]

// Type Eraser je dodeljivanje tipa





