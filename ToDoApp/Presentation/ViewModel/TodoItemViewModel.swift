
import Foundation

final class TodoItemViewModel: TodoItemViewOutput {
    
    var todoItemLoaded: ((TodoItem) -> ())?
    var successfullySaved: (() -> ())?
    var errorOccurred: ((String) -> ())?
    
    private let fileCache: FileCache
    private let cacheFileName = "cache"
    private var todoItem: TodoItem?
    
    init(fileCache: FileCache) {
        self.fileCache = fileCache
    }
    
    // MARK: - Public Methods
    
    func loadItem() {
        do {
            try fileCache.loadItemsFromJSON(fileName: cacheFileName)
        } catch {
            if let errorOccurred = errorOccurred {
                errorOccurred(error.localizedDescription)
            }
        }
        
        if let newItem = fileCache.todoItems.values.first,
           let todoItemLoaded = todoItemLoaded {
            todoItem = newItem
            todoItemLoaded(newItem)
        }
    }
    
    func saveItem(text: String, importance: Importance, deadline: Date?, textColor: String) {
        updateTodoItem(text: text, importance: importance, deadline: deadline, textColor: textColor)
        
        guard let todoItem = todoItem else { return }
        fileCache.addItem(todoItem)
        do {
            try fileCache.saveItemsToJSON(fileName: cacheFileName)
        } catch {
            if let errorOccurred = errorOccurred {
                errorOccurred(error.localizedDescription)
            }
        }
        
        if let successfullySaved = successfullySaved {
            successfullySaved()
        }
    }
    
    // MARK: - Private Methods
    
    private func updateTodoItem(text: String, importance: Importance, deadline: Date?, textColor: String) {
        if let currentTodoItem = todoItem {
            let newItem = TodoItem(
                id: currentTodoItem.id,
                text: text,
                importance: importance,
                deadline: deadline,
                isDone: currentTodoItem.isDone,
                creationDate: currentTodoItem.creationDate,
                modificationDate: currentTodoItem.modificationDate,
                textColor: textColor
            )
            self.todoItem = newItem
        } else {
            self.todoItem = TodoItem(text: text, importance: importance, deadline: deadline, textColor: textColor)
        }
    }
    
}
