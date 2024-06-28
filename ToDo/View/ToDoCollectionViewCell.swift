//
//  ToDoCollectionViewCell.swift
//  ToDo
//
//  Created by Bhavesh Patel on 26/06/24.
//

import Foundation
import UIKit

class ToDoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var lblCategory : UILabel!
    @IBOutlet var lblDate : UILabel!
    @IBOutlet var viewOnTimeOrDelayed : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    func configure() -> Void {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 6
        self.layer.shadowOffset = CGSize(width: 5, height: 5)     
        
        self.viewOnTimeOrDelayed.layer.cornerRadius = 5
        self.viewOnTimeOrDelayed.backgroundColor = UIColor.green
    }
}
