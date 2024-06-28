//
//  ToDoViewModel.swift
//  ToDo
//
//  Created by Bhavesh Patel on 24/06/24.
//

import Foundation

/**
    Enum is for Database events
*/
enum Event {
    case add
    case edit
    case delete
    case sort
}

/**
    Enum is for records Filter.
*/

enum Filter {
    case all
    case todo
    case inprogress
    case done
}


class ToDoViewModel {
    
    var todoList : [ToDoModel] = []
    var sortedList : [ToDoModel] = []
    
    var event : ((_ event : Event) -> Void)?
    var selectedFilter : Filter = .all
        
/**
    Method to Apply filter on the based of Task Status
     - Parameters:
     - selectedIndex: Int: Index of selected filter.
 */

    
    func sortToDoOnStatus (selectedIndex : Int) -> Void {
        if (selectedIndex == 0) {
            selectedFilter = .all
            todoList = DatabaseHelper.shared.fetchToDoFromDatabase()
        }
        else if (selectedIndex == 1) {
            selectedFilter = .todo
            todoList = DatabaseHelper.shared.applyFilterOnToDos(status: .todo)
        }
        else if (selectedIndex == 2) {
            selectedFilter = .inprogress
            todoList = DatabaseHelper.shared.applyFilterOnToDos(status: .inprogress)
        }
        else {
            selectedFilter = .done
            todoList = DatabaseHelper.shared.applyFilterOnToDos(status: .done)
        }
        self.event?(.sort)
    }
    
/**
    Method is to get Satus from the filer when filter apply on the result.
     - Parameters:
     - filter: Filter: Filter enum value selected Filter.
 */
    
    func getToDoStatusForSelectedFilter (filter : Filter) -> Status? {
        switch filter {
        case .all:
            return nil
        case .todo:
            return .todo
        case .inprogress:
            return .inprogress
        case .done:
            return .done
        }
    }

/**
        Method is to get all the Tasks from the Database.
 */
    
    func fetchAllTodoFromDatabase() -> Void {
        let statusForFilter = getToDoStatusForSelectedFilter(filter: selectedFilter)
        todoList = DatabaseHelper.shared.fetchToDoFromDatabase(status: statusForFilter)
    }
    
/**
    Method is to call Database Helper method to add record to databse and the call fetch method to update Array of Records.
     - Parameters:
     - todo: ToDoModel: ToDoModel to add task to the database.
     - Returns:
        - Bool?: Return result of Dabase saving operation.
 */
    
    func addToDo(todo : ToDoModel) -> Bool? {
//        todoList.append(todo)
        do {
            try DatabaseHelper.shared.addToDoToDatabase(todo: todo)
             fetchAllTodoFromDatabase()
             self.event?(.add)
            return true
        }
        catch  {
            print(error.localizedDescription)
            return false
        }
    }

/**
    Method is to call Database Helper method to update record in databse and the call fetch method to update Array of Records.
     - Parameters:
     - todo: ToDoModel: ToDoModel to update task in the database.
     - Returns:
        - Bool?: Return result of Dabase task update operation.
 */


    func updateTodo(todo : ToDoModel) -> Bool? {
        if todoList.firstIndex(where: { item in item.id == todo.id}) != nil {
            do {
                try DatabaseHelper.shared.updateToDoToDatabase(todo: todo)
                 fetchAllTodoFromDatabase()
                 self.event?(.edit)
                return true
            }
            catch {
                print(error.localizedDescription)
                return false
            }
        }
        else {
            return false
        }
        
    }
    
/**
    Method is to call Database Helper method to remove record from databse and the call fetch method to update Array of Records.
     - Parameters:
     - todo: ToDoModel: ToDoModel to remove task from the database.
     - Returns:
        - Bool?: Return result of Dabase task removing operation.
 */

    func removeToDo (todo : ToDoModel) -> Bool? {
        do {
            try DatabaseHelper.shared.deleteToDoFromDatabase(todo: todo)
            fetchAllTodoFromDatabase()
            self.event?(.delete)
            return true
        }
        catch {
            print(error.localizedDescription)
            return false
        }
    }
       
/**
    Method is used to validate input of Title and Description before saving to the database.
     - Parameters:
     - title: String?: to validate whether title is empty or not.
     - description: String?: to validate whether description is empty or not
     - Returns:
        - ValidationType?: Return result ValidationType.success if both the condition will be true else it will return .fail(String) with respective message for the user.
 */
    
    func validateInputs (title: String? , description: String?) -> ValidationType {
        
        let titleResult = ValidationHelper.shared.validateTitle(title: title)
        
        guard (titleResult == .success) else {
            return titleResult
        }
        
        let descriptionResult = ValidationHelper.shared.validationDescription(description: description)
        
        guard descriptionResult == .success else {
            return descriptionResult
        }
        
        return .success
    }
}
