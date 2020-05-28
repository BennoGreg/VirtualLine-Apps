//
//  CompanyCell.swift
//  VirtualLine User
//
//  Created by Niklas Wagner on 16.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

class CompanyCell: UICollectionViewCell {
    
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    
    func update(companyName: String){
        
        companyNameLabel.text = companyName
        
    }
}
