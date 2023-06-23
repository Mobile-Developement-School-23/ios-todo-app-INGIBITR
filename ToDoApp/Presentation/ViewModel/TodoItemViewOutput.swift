
import Foundation

protocol TodoItemViewOutput {
    var todoItemLoaded: ((TodoItem) -> ())? { get set }
    var successfullySaved: (() -> ())? { get set }
    var errorOccurred: ((String) -> ())? { get set }
    func loadItem()
    func saveItem(text: String, importance: Importance, deadline: Date?, textColor: String)
}
