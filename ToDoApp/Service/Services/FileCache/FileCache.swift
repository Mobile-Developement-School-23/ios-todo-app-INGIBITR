
import Foundation

protocol FileCache {
    var todoItems: [UUID: TodoItem] { get }
    func addItem(_ item: TodoItem)
    func deleteItem(with id: UUID)
    func saveItemsToJSON(fileName: String) throws
    func loadItemsFromJSON(fileName: String) throws
    func saveItemsToCSV(fileName: String) throws
    func loadItemsFromCSV(fileName: String) throws
}
