//
//  QueueSectionHeader.swift
//  VirtualLine User
//
//  Created by Niklas Wagner on 16.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

class QueueSectionHeader: UICollectionReusableView {
    
    
    @IBOutlet weak var sectionNameLabel: UILabel!
    
    
    func update(sectionName: String){
        
        sectionNameLabel.text = sectionName
    }
    
    
}
