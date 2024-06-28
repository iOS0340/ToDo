//
//  AddToDoViewController.swift
//  ToDo
//
//  Created by Bhavesh Patel on 24/06/24.
//

import Foundation
import UIKit

class AddToDoViewController : UIViewController {
    
    @IBOutlet weak var txtTitle : UITextField!
    @IBOutlet weak var txtViewDescription : UITextView!
    @IBOutlet weak var btnStatus : UIButton!
    @IBOutlet weak var btnAdd : UIButton!
    @IBOutlet weak var dateTimePiker : UIDatePicker!
    
    var viewModel : ToDoViewModel?
    
    var todoStatus : Status = .todo
    var todo : ToDoModel?
    
    override func viewDidLoad() {
        self.btnStatus.showsMenuAsPrimaryAction = true
        self.addMenuItems()
        self.configureViews()
        
        if todo != nil {
            self.fillDetails()
            self.btnAdd.setTitle("Update", for: .normal)
        }
        else{
            dateTimePiker.minimumDate = Date.now
            self.btnAdd.setTitle("Add", for: .normal)
        }
    }
    
    func configureViews () -> Void {
        self.txtTitle.layer.cornerRadius = 10
        self.txtTitle.layer.borderColor = UIColor.black.cgColor
        self.txtTitle.layer.borderWidth = 1
        self.txtTitle.layer.masksToBounds = true
        
        self.txtViewDescription.layer.cornerRadius = 10
        self.txtViewDescription.layer.borderColor = UIColor.black.cgColor
        self.txtViewDescription.layer.borderWidth = 1
        self.txtViewDescription.layer.masksToBounds = true
        self.txtViewDescription.inputAccessoryView = addToolbarAccessoryView(selector: #selector(resignFirstResponderTextView), target: self)
    }
    
    @objc func resignFirstResponderTextView () -> Void {
        self.txtViewDescription.resignFirstResponder()
    }
    
    func fillDetails() -> Void {
        self.txtTitle.text = self.todo?.title
        self.txtViewDescription.text = self.todo?.description
        self.btnStatus.setTitle(getStatusText(status: self.todo!.status), for: .normal)
        todoStatus = self.todo!.status
        
        self.dateTimePiker.timeZone = TimeZone.current
        
        let date = convertStringToDate(date: self.todo!.date)
        self.dateTimePiker.minimumDate = date
        self.dateTimePiker.date = date
    }
    
    func addMenuItems() -> Void {
        let toDoMenuItem = UIAction.init(title: "To Do", handler: { action in
            self.btnStatus.setTitle("To Do", for: .normal)
            self.todoStatus = .todo
        })
        
        let inProgressMenuItem = UIAction.init(title: "In Progress", handler: { action in
            self.btnStatus.setTitle("In Progress", for: .normal)
            self.todoStatus = .inprogress
        })
        
        let doneMenuItem = UIAction.init(title: "Done", handler: { action in
            self.btnStatus.setTitle("Done", for: .normal)
            self.todoStatus = .done
        })
        btnStatus.menu = UIMenu(title: "Status",options: .singleSelection,  children: [toDoMenuItem, inProgressMenuItem, doneMenuItem])
    }
    
    @IBAction func btnCancelAction (sender : UIButton) -> Void {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnAddAction (sender : UIButton) -> Void {
        
        let validationResult = self.viewModel!.validateInputs(title: self.txtTitle.text, description: self.txtViewDescription.text)
        
        guard (validationResult == .success) else {
            if case .fail(let string) = validationResult {
                self.showValidationError(message: string)
            }
            return
        }
        
        self.txtTitle.resignFirstResponder()
        self.txtViewDescription.resignFirstResponder()
        
        if (self.todo == nil){
            let _ = self.viewModel?.addToDo(todo: ToDoModel.init(title: self.txtTitle.text!, description: self.txtViewDescription.text, status: todoStatus, date: convertDateToString(date: self.dateTimePiker.date)))
        }
        else {
            self.todo?.title = self.txtTitle.text!
            self.todo?.description = self.txtViewDescription.text
            self.todo?.status = todoStatus
            self.todo?.date = convertDateToString(date: self.dateTimePiker.date)
            
            let _ = self.viewModel?.updateTodo(todo: todo!)
        }
        self.dismiss(animated: true)
    }
    
    func showValidationError (message : String) -> Void {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: { action in
            
        })
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

extension AddToDoViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
