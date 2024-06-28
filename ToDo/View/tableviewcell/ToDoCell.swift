//
//  ToDoCell.swift
//  ToDo
//
//  Created by Bhavesh Patel on 24/06/24.
//

import Foundation
import UIKit

class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    @IBOutlet weak var lblStatus : UILabel!
    @IBOutlet weak var btnStatus : UIButton!
    @IBOutlet weak var lblDate : UILabel!
    
//    var menuActions : [UIAction]?
    
    var todo : ToDoModel? {
        didSet {
//            self.prepareMenuElement()
            self.configureCell()
        }
    }
    
    var viewModel : ToDoViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupMenuButton()
    }
    
    /*private func prepareMenuElement () -> Void {
        let toDoStatus = UIAction.init(title: "To Do") { action in
            self.status.setTitle("To Do", for: .normal)
        }
        
        let inProgressStatus = UIAction.init(title: "In Progress") { action in
            self.status.setTitle("In Progress", for: .normal)
        }
        
        let doneStatus = UIAction.init(title: "Done") { action in
            self.status.setTitle("Done", for: .normal)
        }
        
        menuActions = [toDoStatus, inProgressStatus, doneStatus]
    }
    */
    
    func configureCell() {
        guard let todoModel = self.todo else {
            return
        }
        self.lblTitle.text = todoModel.title
        self.lblDescription.text = todoModel.description
        self.lblStatus.text = getStatusText(status: todoModel.status)
        self.btnStatus.titleLabel?.adjustsFontSizeToFitWidth = false
        self.btnStatus.titleLabel?.adjustsFontForContentSizeCategory = false
        self.btnStatus.setTitle(getStatusText(status: todoModel.status), for: .normal)
        self.lblDate.text = todoModel.date
    }
    
    func setupMenuButton () -> Void {
        
        let toDoMenuItem = UIAction.init(title: "To Do", handler: { action in
            self.btnStatus.setTitle("To Do", for: .normal)
            if let viewModel = self.viewModel {
                self.todo?.status = .todo
                let  _ = viewModel.updateTodo(todo: self.todo!)
            }
        })
        
        let inProgressMenuItem = UIAction.init(title: "In Progress", handler: { action in
            self.btnStatus.setTitle("In Progress", for: .normal)
            if let viewModel = self.viewModel {
                self.todo?.status = .inprogress
                let  _ = viewModel.updateTodo(todo: self.todo!)
            }
        })
        
        let doneMenuItem = UIAction.init(title: "Done", handler: { action in
            self.btnStatus.setTitle("Done", for: .normal)
            if let viewModel = self.viewModel {
                self.todo?.status = .done
                let  _ = viewModel.updateTodo(todo: self.todo!)
            }
        })
        
        let menu = UIMenu(title: "Status",options: .singleSelection,  children: [toDoMenuItem, inProgressMenuItem, doneMenuItem])
        btnStatus.menu = menu
    }
}
