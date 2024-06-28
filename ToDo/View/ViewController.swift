//
//  ViewController.swift
//  ToDo
//
//  Created by Bhavesh Patel on 24/06/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView : UITableView!
    @IBOutlet weak var segamentControl : UISegmentedControl!
    @IBOutlet weak var emptyView : UIView!
    
    var viewModel : ToDoViewModel = ToDoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.viewModel.fetchAllTodoFromDatabase()
        
        if (!self.viewModel.todoList.isEmpty) {
            self.emptyView.isHidden = true
        }
        
        self.tblView.register(UINib(nibName: "ToDoCell", bundle: nil), forCellReuseIdentifier: "ToDoCell")
        
        self.configureEvents()
        self.tblView.reloadData()
    }

    @IBAction func addToDo (sender : UIBarButtonItem) -> Void {
        let addVC = self.storyboard!.instantiateViewController(identifier: "AddToDoVCSID") as AddToDoViewController
        addVC.viewModel = self.viewModel        
        presentSheetViewController(addVC: addVC)
    }
    
    func presentSheetViewController (addVC : AddToDoViewController, todo : ToDoModel? = nil) {
        if let sheet = addVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 20
            sheet.prefersGrabberVisible = true
        }
        addVC.todo = todo
        present(addVC, animated: true)
    }
    
    func editToDo (todo : ToDoModel) -> Void {
        let addVC = self.storyboard!.instantiateViewController(identifier: "AddToDoVCSID") as AddToDoViewController
        addVC.viewModel = self.viewModel
        presentSheetViewController(addVC: addVC, todo: todo)
    }
    
    func configureEvents() -> Void {
        
        self.viewModel.event = { event in
            
            self.emptyView.isHidden = self.viewModel.todoList.count == 0 ? false : true
            
            switch event {
            case .add:
                self.tblView.reloadData()
                break
            case .edit:
                self.tblView.reloadData()
                break
            case .delete:
                break
            case .sort:
                self.tblView.reloadData()
                break
            }
        }
    }

    @IBAction func segmentControlOnChangeAction (segmentControl : UISegmentedControl) -> Void {
        self.viewModel.sortToDoOnStatus(selectedIndex: segmentControl.selectedSegmentIndex)
    }
    
}

extension ViewController : UITableViewDataSource {
    
//    func arryToUse () -> [ToDoModel] {
//        return self.segamentControl.selectedSegmentIndex == 0 ? self.viewModel.todoList : self.viewModel.sortedList
//    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.todoList.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoCell
        
        guard let cell = cell else {
            return UITableViewCell.init()
        }
        
        cell.todo = self.viewModel.todoList[indexPath.row]
        cell.viewModel = self.viewModel
        
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.sectionHeaderHeight))
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let delete = UIContextualAction.init(style: .destructive, title: "Delete") { (delete, view, handler) in
                
                let _ = self.viewModel.removeToDo(todo: self.viewModel.todoList[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .left)
            }
            
            let edit = UIContextualAction.init(style: .normal, title: "Edit") { (edit, view, handler) in
                self.editToDo(todo: self.viewModel.todoList[indexPath.row])
                self.tblView.reloadData()
            }
            
            let swipeAction = UISwipeActionsConfiguration.init(actions: [delete, edit]);
            swipeAction.performsFirstActionWithFullSwipe = true
            
            return swipeAction
        }
}
