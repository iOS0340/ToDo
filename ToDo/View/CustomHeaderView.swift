//
//  CustomHeaderView.swift
//  ToDo
//
//  Created by Bhavesh Patel on 26/06/24.
//

import UIKit

class CustomHeaderView: UICollectionReusableView {
   
    @IBOutlet weak var lblCount : UILabel!
    @IBOutlet weak var lblStatus : UILabel!
    
    override func awakeFromNib() {
        self.configure()
    }
    
    func configure () -> Void {
        self.lblCount.layer.cornerRadius = 10
        self.lblCount.layer.masksToBounds = true
    }
}
