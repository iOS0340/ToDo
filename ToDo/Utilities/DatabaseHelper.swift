//
//  DatabaseHelper.swift
//  ToDo
//
//  Created by Bhavesh Patel on 25/06/24.
//

import Foundation
import CoreData

class DatabaseHelper {
    
    static var shared : DatabaseHelper {
        return DatabaseHelper()
    }
    
/**
     Method to add task to the database
     - Parameters:
     - todo: ToDoModel: Tasks details to add to the database.
 */

    
    func addToDoToDatabase (todo : ToDoModel) throws -> Void {
        
        let manageContext = AppDelegate.sharedObject.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "ToDo", in: manageContext)!
        
        let todoManageObj = NSManagedObject(entity: userEntity, insertInto: manageContext)
        todoManageObj.setValue(todo.id, forKey: "id")
        todoManageObj.setValue(todo.title, forKey: "title")
        todoManageObj.setValue(todo.description, forKey: "details")
        todoManageObj.setValue(getStatusText(status: todo.status), forKey: "status")
        todoManageObj.setValue(todo.date, forKey: "date")
        
        do {
            try AppDelegate.sharedObject.saveContext()
        }
        catch {
            throw error
        }
    }

/**
     Method to fetch tasks according to the status or status is nil the it will return all the records stored in database.
     - Parameters:
     - status: Status: Status value according to the selected filter. (e.g: All, To Do, In Progress, Done)
     - Returns:
        - [ToDoModel] - Return collection of all the relevant tasks.
 */

    
    func fetchToDoFromDatabase(status : Status? = nil) -> [ToDoModel] {
        var resultList : [ToDoModel] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        if (status != nil) {
            fetchRequest.predicate = NSPredicate(format: "status = %@", getStatusText(status: status!))
        }
        
        do {
            let result  = try? AppDelegate.sharedObject.persistentContainer.viewContext.fetch(fetchRequest)
            
            if (result != nil && !result!.isEmpty) {
                for item in result as! [NSManagedObject] {
                    let todo = convertObjectModelToModel(todo: item)
                    resultList.append(todo)
                }
            }
        }
        
        return resultList
    }
    
/**
     Method to update task to the database
     - Parameters:
     - todo: ToDoModel: Tasks details to update to the database.
 */
    
    func updateToDoToDatabase (todo : ToDoModel) throws -> Void {
        
        let manageContext = AppDelegate.sharedObject.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        fetchRequest.predicate = NSPredicate(format: "%K == %@", "id", todo.id as NSUUID)
        
        do {
            let result = try? manageContext.fetch(fetchRequest)
            
            if (result != nil && !result!.isEmpty) {
                let updateTodo = result![0] as! NSManagedObject
                
                updateTodo.setValue(todo.id, forKey: "id")
                updateTodo.setValue(todo.title, forKey: "title")
                updateTodo.setValue(todo.description, forKey: "details")
                updateTodo.setValue(getStatusText(status: todo.status), forKey: "status")
                updateTodo.setValue(todo.date, forKey: "date")
                
                do {
                    try AppDelegate.sharedObject.saveContext()
                }
                catch {
                    throw error
                }
            }
        }
        
    }
    
/**
     Method to convert NSManagedObject to ToDoModel
     - Parameters:
     - todo: NSManagedObject: Managed Object Model of ToDo to convert to ToDoModel
     - Returns:
        - ToDoModel: Converted ToDoModel
 */
    
    func convertObjectModelToModel ( todo : NSManagedObject) -> ToDoModel {
        return ToDoModel(id: todo.value(forKey: "id") as! UUID, title: todo.value(forKey: "title") as! String, description: todo.value(forKey: "details") as! String, status: getStatusFromText(status: todo.value(forKey: "status") as! String), date: todo.value(forKey: "date") as! String)
    }
    
/**
     Method to apply filter on Collection of ToDoModel and Return Filtered Value
     - Parameters:
     - status: Status: Status value on which we apply filter on Collection of ToDoModel
     - Returns:
        - [ToDoModel]: Collection of Filtered ToDoModels
 */
    
    func applyFilterOnToDos (status : Status) -> [ToDoModel] {
        var filteredToDoList : [ToDoModel] = []
        let manageContext = AppDelegate.sharedObject.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        fetchRequest.predicate = NSPredicate(format: "%K == %@", "status", getStatusText(status: status))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            let result = try? manageContext.fetch(fetchRequest)
            
            if (result != nil && !result!.isEmpty) {
                for item in result as! [NSManagedObject] {
                    let todo = convertObjectModelToModel(todo: item)
                    filteredToDoList.append(todo)
                }
            }
        }
        return filteredToDoList
    }
    
/**
     Method to remove task to the database
     - Parameters:
     - todo: ToDoModel: Tasks details to remove from the database.
 */
    
    func deleteToDoFromDatabase (todo : ToDoModel) throws -> Void{
        
        let manageContext = AppDelegate.sharedObject.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        fetchRequest.predicate = NSPredicate(format: "%K == %@", "id", todo.id as NSUUID)
        
        do {
            let result = try? manageContext.fetch(fetchRequest)
            
            if (result != nil && !result!.isEmpty) {
                let updateTodo = result![0] as! NSManagedObject
                manageContext.delete(updateTodo)
                
                do {
                    try AppDelegate.sharedObject.saveContext()
                }
                catch {
                    throw error
                }
            }
            
        }
        
    }
}
