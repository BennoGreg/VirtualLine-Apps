//
//  ViewController.swift
//  VirtualLine Admin
//
//  Created by Benedikt Langer on 04.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var newQueueButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI() {
        let userImage = UIImageView(image: UIImage(named: "user.png"))
        let userBarButton = UIBarButtonItem(customView: userImage)
        self.navigationItem.rightBarButtonItem = userBarButton

        let presentationModeImage = UIImageView(image: UIImage(named: "video-player.png"))
        let presentationModeBarButton = UIBarButtonItem(customView: presentationModeImage)
        self.navigationItem.leftBarButtonItem = presentationModeBarButton
        
        self.newQueueButton.applyGradient(colors: [ViewController.UIColorFromRGB(0x69bdd2).cgColor,ViewController.UIColorFromRGB(0x44bcda).cgColor])
        self.newQueueButton.setTitle("Warteschlange erstellen", for: .normal)
                   
    }
    
       
    static func UIColorFromRGB(_ rgbValue: Int) -> UIColor {
          return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((rgbValue & 0x00FF00) >> 8))/255.0, blue: ((CGFloat)((rgbValue & 0x0000FF)))/255.0, alpha: 1.0)
      }
}

 extension UIButton {
   
     func applyGradient(colors: [CGColor]) {
         self.backgroundColor = nil
         self.layoutIfNeeded()
         let gradientLayer = CAGradientLayer()
         gradientLayer.colors = colors
         gradientLayer.startPoint = CGPoint(x: 0, y: 0)
         gradientLayer.endPoint = CGPoint(x: 1, y: 0)
         gradientLayer.frame = self.bounds
         gradientLayer.cornerRadius = self.frame.height/2

         gradientLayer.shadowColor = UIColor.darkGray.cgColor
         gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
         gradientLayer.shadowRadius = 5.0
         gradientLayer.shadowOpacity = 0.3
         gradientLayer.masksToBounds = false
         self.layer.insertSublayer(gradientLayer, at: 0)
         self.contentVerticalAlignment = .center
         self.setTitleColor(UIColor.white, for: .normal)
        // self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
         self.titleLabel?.textColor = UIColor.white
     }
    
  
 }

