//
//  AllQueuesCell.swift
//  VirtualLine User
//
//  Created by Niklas Wagner on 07.06.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

class AllQueuesCell: UICollectionViewCell {


    @IBOutlet weak var queueNameLabel: UILabel!
    
    @IBOutlet weak var queueLengthLabel: UILabel!
    
    @IBOutlet weak var queueWaitingTimeLabel: UILabel!
    
    func update(queueName: String,queueTime: Int, queueLength: Int){
        
        queueNameLabel.text = queueName
        queueWaitingTimeLabel.text = "\(queueTime) Minuten"
        queueLengthLabel.text = "\(queueLength) Personen"
        
    }
}
