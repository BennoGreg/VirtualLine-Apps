//
//  AddQueueViewController.swift
//  VirtualLine Admin
//
//  Created by Niklas Wagner on 30.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

class AddQueueViewController: UIViewController{
    
    @IBOutlet weak var queueReminderTextfield: UITextField!
    @IBOutlet weak var queueAverageWaitingTimeTextfield: UITextField!
    @IBOutlet weak var queueNameTextField: UITextField!
    @IBOutlet weak var createQueueButton: UIButton!
    override func viewDidLoad() {
        setUpUI()
    }
    
    func setUpUI(){
        self.createQueueButton.applyGradient(colors: [ViewController.UIColorFromRGB(0x69bdd2).cgColor,ViewController.UIColorFromRGB(0x44bcda).cgColor])
        self.createQueueButton.setTitle("Warteschlange erstellen", for: .normal)
    }
    
    @IBAction func createQueueButtonPressed(_ sender: UIButton) {
        
    if let navController = self.navigationController {
        navController.popViewController(animated: true)
    }
        
    }
}
