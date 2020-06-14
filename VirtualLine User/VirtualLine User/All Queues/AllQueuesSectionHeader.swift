//
//  AllQueuesSectionHeader.swift
//  VirtualLine User
//
//  Created by Niklas Wagner on 08.06.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit


class AllQueuesSectionHeader: UICollectionReusableView {
    
    
   
    @IBOutlet weak var allQueuesSectionLabel: UILabel!
    
    
    func update(sectionName: String){
        
        allQueuesSectionLabel.text = sectionName
       
    }
    
    
}

