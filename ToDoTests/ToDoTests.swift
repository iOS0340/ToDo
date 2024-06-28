//
//  ToDoTests.swift
//  ToDoTests
//
//  Created by Bhavesh Patel on 24/06/24.
//

import XCTest
@testable import ToDo

final class ToDoTests: XCTestCase {
    
    var todoViewModel : ToDoViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        todoViewModel = ToDoViewModel()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        todoViewModel = nil
    }
    
    func checkViewModel () -> Bool {
        guard self.todoViewModel != nil else {
            return false
        }
        return true
    }
    
    func testValidate_A_ForEmptyTitle() -> Void {
        
        guard checkViewModel() else {
            XCTFail("View Model should not be nil")
            return
        }
        
        let result = self.todoViewModel!.validateInputs(title: "", description: "Details")
        
        XCTAssertEqual(result, .fail(kTitleValidationMessage), "Title is Empty")
    }
        
    func testValidate_B_ForEmptyDescription() -> Void {
        
        guard checkViewModel() else {
            XCTFail("View Model should not be nil")
            return
        }
        
        let result = todoViewModel!.validateInputs(title: "Hello World", description: "")
        
        XCTAssertEqual(result, .fail(kDescriptionValidationMessage), "Description is Empty")
    }

    func testValidate_C_ForTitleAndDescriptionNotEmpty() -> Void {
        
        guard checkViewModel() else {
            XCTFail("View Model should not be nil")
            return
        }
        
        let result = todoViewModel!.validateInputs(title: "Hello World", description: "Details")
        
        XCTAssertEqual(result, .success, "Valid inputs are given")
    }
    
    func testValidate_D_ForRecordInsertRightInput () -> Void {
        let result = self.todoViewModel?.addToDo(todo: ToDoModel(title: "Hello World", description: "Success", status: .todo, date: convertDateToString(date: Date())))
       XCTAssertTrue(result!, "Record inserted successfully")
    }
    
    func testValidate_E_ForRecordUpdateRightInput () -> Void {
        
        guard checkViewModel() else {
            XCTFail("View Model should not be nil")
            return
        }
        self.todoViewModel!.fetchAllTodoFromDatabase()
        
        try? XCTSkipIf((self.todoViewModel?.todoList.isEmpty)!, "Record Not Found")
        
        let todo = self.todoViewModel?.todoList[0]
        let result = self.todoViewModel?.updateTodo(todo: ToDoModel(id: todo!.id, title: "Updated Record", description: "Description also updated", status: .inprogress, date: convertDateToString(date: Date())))
        
        XCTAssertTrue(result!, "Record updated successfully")
    }
    
    func testValidate_F_ForRecordDeleteRightInput () -> Void {
        
        guard checkViewModel() else {
            XCTFail("View Model should not be nil")
            return
        }
        self.todoViewModel!.fetchAllTodoFromDatabase()
        
        try? XCTSkipIf((self.todoViewModel?.todoList.isEmpty)!, "Record Not Found")
        
        let todo = self.todoViewModel?.todoList[0]
        let result = self.todoViewModel?.removeToDo(todo: ToDoModel(id: todo!.id, title: "Record Deleted", description: "Description also updated", status: .inprogress, date: convertDateToString(date: Date())))
        
        if result != nil {
            XCTAssertTrue(result!, "Record deleted successfully")
        }
        else {
            XCTAssertNil(result, "Record Not Found")
        }
    }
    
    func testValidate_G_RecordInsertEmptyDescriptionFailure() -> Void {
        let result = self.todoViewModel?.addToDo(todo: ToDoModel(title: "Hey", description: "", status: .todo, date: convertDateToString(date: Date())))
        
        XCTAssertFalse(result!)
    }
    
    func testValidate_H_RecordInsertWithEmptyTitleFailure() -> Void {
         let result = self.todoViewModel?.addToDo(todo: ToDoModel(title: "", description: "Success", status: .todo, date: convertDateToString(date: Date())))
        
        XCTAssertFalse(result!)
    }
    
    func testValidate_I_ForRecordUpdateWrongInput () -> Void {
        
        guard checkViewModel() else {
            XCTFail("View Model should not be nil")
            return
        }
        self.todoViewModel?.fetchAllTodoFromDatabase()
        
        let result = self.todoViewModel?.updateTodo(todo: ToDoModel(id: UUID(), title: "Updated Record", description: "Description also updated", status: .done, date: convertDateToString(date: Date())))
        
        XCTAssertFalse(result!, "Record updation failed")
    }
    
    func testValidate_J_ForRecordDeleteWrongInput () -> Void {
        
        guard checkViewModel() else {
            XCTFail("View Model should not be nil")
            return
        }
        
        self.todoViewModel!.fetchAllTodoFromDatabase()
        
        let result = self.todoViewModel?.removeToDo(todo: ToDoModel(id: UUID(), title: "Updated Record", description: "Description also updated", status: .inprogress, date: convertDateToString(date: Date())))
        
        XCTAssertTrue(result!, "Record deletion Failed")
    }
    
    
    
}
