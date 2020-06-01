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
        queueReminderTextfield.keyboardType = .numberPad
        queueAverageWaitingTimeTextfield.keyboardType = .numberPad
        // ready for receiving notification
      

    }
    
    func setUpUI(){
        self.createQueueButton.applyGradient(colors: [ViewController.UIColorFromRGB(0x69bdd2).cgColor,ViewController.UIColorFromRGB(0x44bcda).cgColor])
        self.createQueueButton.setTitle("Warteschlange erstellen", for: .normal)
    }
    
    @IBAction func createQueueButtonPressed(_ sender: UIButton) {
        
        
        if queueNameTextField.text != "" && queueAverageWaitingTimeTextfield.text != "" && queueReminderTextfield.text != ""{
            if let navController = self.navigationController {
                
                if let name = queueNameTextField.text {
                    if let waitTime = queueAverageWaitingTimeTextfield.text{
                        if let reminder = queueReminderTextfield.text{
                
                createQueue(queueName: name, averageTimeCustomer: waitTime, minutesBeforeNotifyingCustomer: reminder)
                UserDefaults.standard.set(true, forKey: "isQueueCreated")
                navController.popViewController(animated: true)
            }
                }
                }
            }
        }
        
    }
}
