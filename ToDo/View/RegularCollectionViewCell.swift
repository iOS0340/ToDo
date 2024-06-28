//
//  RegularCollectionViewCell.swift
//  ToDo
//
//  Created by Bhavesh Patel on 26/06/24.
//

import Foundation
import UIKit

class RegularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblCategory : UILabel!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    
    override func awakeFromNib() {
        self.configure()
    }
    
    func configure() -> Void {
        self.layer.cornerRadius = 10        
    }
}
