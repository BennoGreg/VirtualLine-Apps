//
//  CurrentQueueDetailsViewController.swift
//  VirtualLine User
//
//  Created by Niklas Wagner on 22.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

class CurrentQueueDetailsViewController: UIViewController{
    
    var currentQueue: Queue? = nil
    
    override func viewWillAppear(_ animated: Bool) {
         self.parent?.title = "Scan Code"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
              navigationController?.navigationBar.titleTextAttributes = textAttributes
              navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    
}
