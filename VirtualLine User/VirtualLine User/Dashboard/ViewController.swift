//
//  ViewController.swift
//  VirtualLine User
//
//  Created by Benedikt Langer on 04.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    struct Segues {
        static let queueDetailsSegue = "queueDetailSegue"
        static let companyDetailSegue = "companyDetailSegue"
    }

    var data = QueuesData()
    var selectedQueue: Queue?

    
 
    @IBOutlet weak var queueCollectionView: UICollectionView!
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        self.parent?.title = "Virtual Line"
       navigationItem.largeTitleDisplayMode = .always
       self.navigationController?.navigationBar.prefersLargeTitles = true
     
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]


       
        
   
        
    }
   
     // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        if indexPath.section == 0{
            
            selectedQueue = data.currentQueues[indexPath.row]
            performSegue(withIdentifier: Segues.queueDetailsSegue, sender: nil)
            
        }else {
            selectedQueue = data.allQueues[indexPath.row]
            performSegue(withIdentifier: Segues.companyDetailSegue, sender: nil)
        }
       
        
      }

      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.queueDetailsSegue {
              let vc = segue.destination as! CompanyViewController // TODO: Details vs
              let detailsVC = vc.self
              detailsVC.currentCompanyQueue = selectedQueue
        }else if segue.identifier == Segues.companyDetailSegue {
            let vc = segue.destination as! CompanyViewController
            let detailsVC = vc.self
            detailsVC.currentCompanyQueue = selectedQueue
        }
      }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 2
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return data.currentQueues.count
        }else {
            return data.allQueues.count
        }
    }
    
  
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        if indexPath.section == 0{
        let cell: QueueCell = collectionView.dequeueReusableCell(withReuseIdentifier: "queueCell", for: indexPath) as! QueueCell
            cell.update(queueName: data.allQueues[indexPath.row].name, queueTime:data.allQueues[indexPath.row].waitingTime, queueLength: data.allQueues[indexPath.row].queueLength)
           
            updateCellLayout(cell: cell)
             return cell

        }else  {
            
            let cell: CompanyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "companyCell", for: indexPath) as! CompanyCell
            cell.update(companyName: data.allQueues[indexPath.row].name)
             updateCellLayout(cell: cell)
            return cell
        
        }
    }
    
    // Section Header View
       func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "QueueSectionHeader", for: indexPath) as! QueueSectionHeader

        if indexPath.section == 0{
        sectionHeaderView.update(sectionName: "Aktuelle Warteschlange")
        }else{
        sectionHeaderView.update(sectionName: "Warteschlangen in der Nähe")
        }
        
        
           return sectionHeaderView
       }
    
    
    func updateCellLayout(cell: UICollectionViewCell){
        cell.backgroundColor = .cyan
       cell.layer.cornerRadius = 10
       cell.layer.borderWidth = 1.0
       cell.layer.borderColor = UIColor.lightGray.cgColor
       
       cell.layer.backgroundColor = UIColor.white.cgColor
//       cell.layer.shadowColor = UIColor.gray.cgColor
//       cell.layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
//       cell.layer.shadowRadius = 1.0
//       cell.layer.shadowOpacity = 1.0
//       cell.layer.masksToBounds = false
    }
    
    


}

// Extension to adjust Cell size according to section
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        if (indexPath.section == 0){
        return CGSize(width: 180, height: 180)
        }else {
            return CGSize(width: 110, height: 110)

        }
    }
}

