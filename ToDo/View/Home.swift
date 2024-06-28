//
//  Home.swift
//  ToDo
//
//  Created by Bhavesh Patel on 26/06/24.
//

import Foundation
import UIKit

enum LayoutStyle {
    case compositional
    case flow
}

class Home: UIViewController {
    @IBOutlet weak var bottomView : UIView!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var btnMenu : UIButton!
    
    var viewModel : ToDoViewModel = ToDoViewModel()
    var selectedLayout : LayoutStyle = .compositional
    
    override func viewDidLoad() {
        bottomView.layer.cornerRadius = 30
        self.changeCollectionLayout(selectedLayout: selectedLayout)
        self.setupMenuButton()
    }
    
    private func setupMenuButton () -> Void {
        
        let allMenuItem = UIAction.init(title: "All", image: UIImage(named: "icon_all"), handler: { action in
            self.btnMenu.setImage(UIImage(named: "icon_all_small"), for: .normal)
            self.selectedLayout = .compositional
            self.changeCollectionLayout(selectedLayout: self.selectedLayout)
        })
        
        let toDoMenuItem = UIAction.init(title: "To Do", image: UIImage(named: "icon_todo"), handler: { action in
            self.btnMenu.setImage(UIImage(named: "icon_todo_small"), for: .normal)
            self.selectedLayout = .flow
            self.changeCollectionLayout(selectedLayout: self.selectedLayout)
        })
        
        let inProgressMenuItem = UIAction.init(title: "In Progress", image: UIImage(named: "icon_inprogress"), handler: { action in
            self.btnMenu.setImage(UIImage(named: "icon_inprogress_small"), for: .normal)
            
        })
        
        let doneMenuItem = UIAction.init(title: "Done", image: UIImage(named: "icon_done"), handler: { action in
            
            self.btnMenu.setImage(UIImage(named: "icon_done_small"), for: .normal)
        })
        
        let menu = UIMenu(title: "Status",options: .singleSelection,  children: [allMenuItem, toDoMenuItem, inProgressMenuItem, doneMenuItem])
        btnMenu.menu = menu
    }
    
    @IBAction func btnAddTask () -> Void {
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
    
}

extension Home : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return selectedLayout == .compositional ? 3 : 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedLayout == .compositional ? (section == 0 ? 1 : 5) : 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegularCollectionCell", for: indexPath) as? RegularCollectionViewCell
        
        if (selectedLayout == .compositional) {
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompleteCollectionCell", for: indexPath) as? CompleteCollectionCell
                
                guard let cell = cell else { return UICollectionViewCell.init() }
                
                return cell
            }
            else if indexPath.section == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToDoCollectionCell", for: indexPath) as? ToDoCollectionViewCell
                
                guard let cell = cell else { return UICollectionViewCell.init() }
                
                return cell
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegularCollectionCell", for: indexPath) as? RegularCollectionViewCell
                
                guard let cell = cell else { return UICollectionViewCell.init() }
                
                return cell
            }
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RegularCollectionCell", for: indexPath) as? RegularCollectionViewCell
            
            guard let cell = cell else { return UICollectionViewCell.init() }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CustomHeaderView", for: indexPath) as! CustomHeaderView
        
        if (indexPath.section == 1) {
            header.lblStatus.text = "To Do"
        }
        
        return header
    }
}
