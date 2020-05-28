//
//  QueueCell.swift
//  VirtualLine User
//
//  Created by Niklas Wagner on 16.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

class QueueCell: UICollectionViewCell {
    
    @IBOutlet weak var queueNameLabel: UILabel!
    
    @IBOutlet weak var queueTimeLabel: UILabel!
    
    @IBOutlet weak var queueLengthLabel: UILabel!
    
    let horizontalCollectionView: UICollectionView = {
     
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
        
    }()
    
    func setUp(){
        
    }
    
    func update(queueName: String,queueTime: Int, queueLength: Int){
        
        queueNameLabel.text = queueName
        queueTimeLabel.text = "\(queueTime) Minuten"
        queueLengthLabel.text = "\(queueLength) Personen"
        
    }
}
