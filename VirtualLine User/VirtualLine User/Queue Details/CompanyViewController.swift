//
//  CompanyViewController.swift
//  VirtualLine User
//
//  Created by Niklas Wagner on 22.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

class CompanyViewController: UIViewController {
    
    @IBOutlet weak var ticketView: UIView!
  
    @IBOutlet weak var queueLengthLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var waitingTimeLabel: UILabel!
    var currentCompanyQueue: Queue? = nil
    @IBOutlet weak var queueUpButton: UIButton!
    var queuedUp = false
    @IBOutlet weak var queueInfoLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        // corner radius
        ticketView.layer.cornerRadius = 10
        companyNameLabel.text = currentCompanyQueue?.name
        if let curWaitingTime = currentCompanyQueue?.waitingTime{
             waitingTimeLabel.text = String(curWaitingTime)
        }
       
        if let curQueueLength = currentCompanyQueue?.queueLength{
            queueLengthLabel.text = String(curQueueLength)
        }
        
        queueUpButton.applyGradient(colors: [CompanyViewController.UIColorFromRGB(0x2B95CE).cgColor,CompanyViewController.UIColorFromRGB(0x2ECAD5).cgColor])
        self.queueInfoLabel.text = ""

        // border
     //   ticketView.layer.borderWidth = 1.0
       

        // shadow
//        ticketView.layer.shadowColor = UIColor.black.cgColor
//        ticketView.layer.shadowOffset = CGSize(width: 3, height: 3)
//        ticketView.layer.shadowOpacity = 0.7
//        ticketView.layer.shadowRadius = 4.0
         //self.applySemiCircleEffect(givenView: ticketView)
        updateMask()
    }
    @IBAction func queueButtonPressed(_ sender: UIButton) {
        
        let duration: TimeInterval = 0.8

        if queuedUp {
            UIView.animate(withDuration: duration, animations: {
                self.queueUpButton.center.y = self.queueUpButton.center.y-100
            }) { (true) in
                
                print("twst")
                if let layer = self.queueUpButton.layer.sublayers? .first {// The first sublayer of
                    layer.removeFromSuperlayer ()
                }
                self.queueUpButton.applyGradient(colors: [CompanyViewController.UIColorFromRGB(0x2B95CE).cgColor,CompanyViewController.UIColorFromRGB(0x2ECAD5).cgColor])
                 self.queueUpButton.setTitle("Jetzt anstellen", for: .normal)
                self.queueInfoLabel.text = ""
            }
        }else{
        
        UIView.animate(withDuration: duration, animations: {
            self.queueUpButton.center.y = self.queueUpButton.center.y+100
            
        }) { (true) in
            
             if let layer = self.queueUpButton.layer.sublayers? .first {
               layer.removeFromSuperlayer ()
           }
            self.queueUpButton.applyGradient(colors: [CompanyViewController.UIColorFromRGB(0xCC0000).cgColor,CompanyViewController.UIColorFromRGB(0x990000).cgColor])
            self.queueUpButton.setTitle("Warteschlange verlassen", for: .normal)
           // self.queueInfoLabel.text = "Sie sind jetzt in der Warteschange angestellt. \nWir werden Sie rechtzeitig benachrichten \nbevor Sie an der Reihe sind"
        
        }
        }
        queuedUp.toggle()
    }

    private func updateMask() {
        let leftCenter = CGPoint(x: ticketView.bounds.minX, y: ticketView.bounds.midY-60)
        let rightCenter = CGPoint(x: ticketView.bounds.maxX, y: ticketView.bounds.midY-60)

        let path = UIBezierPath(rect: ticketView.bounds)
       let path2 = UIBezierPath(rect: ticketView.bounds)
        
        path.addArc(withCenter: leftCenter, radius: 20, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        path2.addArc(withCenter: rightCenter, radius: 20, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        path.append(UIBezierPath(rect: ticketView.bounds))
        path.append(path2)

        let mask = CAShapeLayer()
        mask.fillRule = .evenOdd
        mask.path = path.cgPath

        ticketView.layer.mask = mask
        
        
      
       
        let layer = CAShapeLayer.init()
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: ticketView.bounds.minX, y: ticketView.bounds.midY-60))
        path3.addLine(to: CGPoint(x: ticketView.bounds.maxX, y: ticketView.bounds.midY-60))
      
        
        layer.path = path3.cgPath;
        layer.lineWidth = 5;
        layer.strokeColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor; // Set Dashed line Color
        layer.lineDashPattern = [7,7]; // Here you set line length
        layer.backgroundColor = UIColor.clear.cgColor;
        layer.fillColor = UIColor.clear.cgColor;
        self.ticketView.layer.addSublayer(layer);
        
    }
    
    private func updateMaskTry1() {
       let path = UIBezierPath()
        path.move(to: ticketView.bounds.origin)
        let center = CGPoint(x: ticketView.bounds.minX, y: ticketView.bounds.midY)
       path.addArc(withCenter: center, radius: 20, startAngle: .pi, endAngle: 0, clockwise: false)
        path.addLine(to: CGPoint(x: ticketView.bounds.maxX, y: ticketView.bounds.minY))
        path.addLine(to: CGPoint(x: ticketView.bounds.maxX, y: ticketView.bounds.maxY))
        path.addLine(to: CGPoint(x: ticketView.bounds.minX, y: ticketView.bounds.maxY))
       path.close()

       let mask = CAShapeLayer()
       mask.path = path.cgPath

        ticketView.layer.mask = mask
       }
    
    /*
    func applySemiCircleEffect(givenView: UIView){
        let shapeLayer = CAShapeLayer(layer: givenView.layer)
        shapeLayer.path = self.pathSemiCirclesPathForView(givenView: givenView).cgPath
        shapeLayer.frame = givenView.bounds
        shapeLayer.masksToBounds = true
        shapeLayer.shadowOpacity = 1
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 3

        givenView.layer.mask = shapeLayer
    }
    
    func pathSemiCirclesPathForView(givenView: UIView, ciclesRadius:CGFloat = 10, circlesDistance : CGFloat = 2) ->UIBezierPath
    {
        let width = givenView.frame.size.width
        let height = givenView.frame.size.height

        let semiCircleWidth = CGFloat(ciclesRadius*2)

        let semiCirclesPath = UIBezierPath()
        semiCirclesPath.move(to: CGPoint(x:0, y:0))

        var x = CGFloat(0)
        var i = 0
        while x < width {
            x = (semiCircleWidth) * CGFloat(i) + (circlesDistance * CGFloat(i))
            let pivotPoint = CGPoint(x: x + semiCircleWidth/2, y: height)
            semiCirclesPath.addArc(withCenter: pivotPoint, radius: ciclesRadius, startAngle: -180 * .pi / 180.0, endAngle: 0 * .pi / 180.0, clockwise: true)
            semiCirclesPath.addLine(to: CGPoint(x: semiCirclesPath.currentPoint.x + circlesDistance, y: height))
            i += 1
        }

        semiCirclesPath.addLine(to: CGPoint(x:width,y: 0))

        i = 0
        while x > 0 {
            x = width - (semiCircleWidth) * CGFloat(i) - (circlesDistance * CGFloat(i))
            let pivotPoint = CGPoint(x: x - semiCircleWidth/2, y: 0)
            semiCirclesPath.addArc(withCenter: pivotPoint, radius: ciclesRadius, startAngle: 0 * .pi / 180.0, endAngle: -180 * .pi / 180.0, clockwise: true)
            semiCirclesPath.addLine(to: CGPoint(x: semiCirclesPath.currentPoint.x - circlesDistance, y: 0))
            i += 1
        }

        semiCirclesPath.close()
        return semiCirclesPath
    }
    */
    
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
         self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
         self.titleLabel?.textColor = UIColor.white
     }
    
  
 }
