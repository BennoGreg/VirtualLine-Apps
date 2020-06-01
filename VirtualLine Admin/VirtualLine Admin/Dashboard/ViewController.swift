//
//  ViewController.swift
//  VirtualLine Admin
//
//  Created by Benedikt Langer on 04.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var newQueueButton: UIButton!

    @IBOutlet var queueWaitingTimeLabel: UILabel!
    @IBOutlet var queueLengthLabel: UILabel!
    @IBOutlet var nextCustomerIDLabel: UILabel!
    @IBOutlet var nextCustomerNameLabel: UILabel!
    @IBOutlet var currenCustomerIDLabel: UILabel!
    @IBOutlet var currentCustomerLabel: UILabel!
    @IBOutlet var customerDoneButton: UIButton!
    @IBOutlet var isCustomerHereButtonStackView: UIStackView!
    @IBOutlet var currentCustomerView: UIView!
    @IBOutlet var customerNotAvailableButton: UIButton!
    @IBOutlet var acceptCustomerButton: UIButton!
    @IBOutlet var bigStackView: UIStackView!
    var waitingNumber = 1
    
    struct segues {
        
        static let settingsSegue = "SettingsSegue"
        static let presentationModeSegue = "presentationModeSegue"
        
    }

    var testQueue = [User(name: "Niklas Wagner", userID: "A219"), User(name: "Benedikt Langer", userID: "B372"), User(name: "Jan Cortiel", userID: "D234"), User(name: "Antonia Langer", userID: "A282"), User(name: "Maria Rohnefeld", userID: "A232"), User(name: "Sebastian Kurz", userID: "O281")]

    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaults.standard.set(false, forKey: "isQueueCreated")
        bigStackView.isHidden = true
        customerDoneButton.isHidden = true
        setUpUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        
         setUpFirebase()
        
        let isQueueCreated = UserDefaults.standard.bool(forKey: "isQueueCreated")
        if isQueueCreated && !testQueue.isEmpty {
            newQueueButton.removeFromSuperview()
            bigStackView.isHidden = false
            currentCustomerLabel.text = testQueue.first?.name
            if let firstCus = testQueue.first{
            currenCustomerIDLabel.text = "Nummer: "+String(waitingNumber)
            nextCustomerNameLabel.text = String(waitingNumber+1)
            nextCustomerIDLabel.text = "ID: "+testQueue[1].userID
            queueLengthLabel.text = "\(testQueue.count) Personen"
            }else{
               
            }
        }
    }

    func setUpUI() {
        newQueueButton.applyGradient(colors: [ViewController.UIColorFromRGB(0x69BDD2).cgColor, ViewController.UIColorFromRGB(0x44BCDA).cgColor])
        newQueueButton.setTitle("Warteschlange erstellen", for: .normal)
    }
  
  
    
    /*
  
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segues.settingsSegue {
             if let settingsViewController = segue.destination as? AdminSettingsViewController {
                     //nextViewController.valueOfxyz = "XYZ"
                     //settingsViewController.valueOf123 = 123
             }
        }else if segue.identifier == segues.presentationModeSegue{

            if let presentationModeViewController = segue.destination as? AdminSettingsViewController {
                               //nextViewController.valueOfxyz = "XYZ"
                               //settingsViewController.valueOf123 = 123
                       }
        }
     }
 */

    static func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
        return UIColor(red: (CGFloat)((rgbValue & 0xFF0000) >> 16) / 255.0, green: (CGFloat)((rgbValue & 0x00FF00) >> 8) / 255.0, blue: (CGFloat)(rgbValue & 0x0000FF) / 255.0, alpha: 1.0)
    }

    @IBAction func customerDoneButtonPressed(_ sender: UIButton) {
        currentCustomerView.bringSubviewToFront(isCustomerHereButtonStackView)
        currentCustomerView.sendSubviewToBack(customerDoneButton)
        acceptCustomerButton.isHidden = false
        customerNotAvailableButton.isHidden = false
        customerDoneButton.isHidden = true
        nextCustomer()
        
    }

    @IBAction func customerNotAvailableButtonPressed(_ sender: UIButton) {
          if (!testQueue.isEmpty){
        acceptCustomerButton.isHidden = false
        customerNotAvailableButton.isHidden = false
        customerDoneButton.isHidden = true
        nextCustomer()
            
        }
    }

    @IBAction func acceptCustomerButtonPressed(_ sender: UIButton) {
        if (!testQueue.isEmpty){
        acceptCustomerButton.isHidden = true
        customerNotAvailableButton.isHidden = true
        customerDoneButton.isHidden = false
        currentCustomerView.bringSubviewToFront(customerDoneButton)
        currentCustomerView.sendSubviewToBack(isCustomerHereButtonStackView)
        }
    }

    func nextCustomer() {
        testQueue.removeFirst()
        waitingNumber += 1
        queueLengthLabel.text = "\(testQueue.count) Personen"

        if !testQueue.isEmpty {
            if let curCustomer = testQueue.first{
              
                
                currentCustomerLabel.text = curCustomer.name
                currenCustomerIDLabel.text = "Nummer: " + String(waitingNumber)
                
                
            }

            if testQueue.count == 1 {
                nextCustomerNameLabel.text = "Warteschlange derzeit leer"
                nextCustomerIDLabel.text = ""
                queueLengthLabel.text = "Keine Person"
                
            } else {
                nextCustomerNameLabel.text = testQueue[1].name
                
                nextCustomerIDLabel.text = "Nummer: " + String(waitingNumber+1)
                
                queueLengthLabel.text = "\(testQueue.count) Personen"
            }
        } else {
            currentCustomerLabel.text = "Warteschlange leer"
            currenCustomerIDLabel.text = ""
            nextCustomerNameLabel.text = ""
            nextCustomerIDLabel.text = ""
            queueLengthLabel.text = "Derzeit keine Personen"
        }
    }
    
    static func updateQueue(waitingTime: String, queueLength: String){
        
       // queueLengthLabel.text = queueLength
       // queueWaitingTimeLabel.text = waitingTime
        print("test")
        
    }
    
}

extension UIButton {
    func applyGradient(colors: [CGColor]) {
        backgroundColor = nil
        layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = frame.height / 2

        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false
        layer.insertSublayer(gradientLayer, at: 0)
        contentVerticalAlignment = .center
        setTitleColor(UIColor.white, for: .normal)
        // self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        titleLabel?.textColor = UIColor.white
    }
}
