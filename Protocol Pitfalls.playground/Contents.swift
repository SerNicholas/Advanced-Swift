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
print(FolderCell().getFileType()) // FolderCell with Folder type


class CollectionCell: Listable {
    typealias FileType = Cell
    func getFileType() -> String {
        return "CollectionCell with \(FileType.self) type"
    }
}
print(CollectionCell().getFileType()) // CollectionCell with Cell type


class ListCell: Listable {
    typealias FileType = Cell
    func getFileType() -> String {
        return "ListCell with \(FileType.self) type"
    }
}
print(ListCell().getFileType()) // ListCell with Cell type


// Sad problem prtocol pitfall-a
// let cell: Listable = CollectionCell() ovo nije moguce zato sto postoji associated type, tj associated tip nije definisan jos uvek i zato ne moze












