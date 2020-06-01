//
//  ServerCommunication.swift
//  VirtualLine Admin
//
//  Created by Niklas Wagner on 01.06.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseFunctions

var db: Firestore!
var ref: DocumentReference?
var functions = Functions.functions()

var dataDictionary = [String: Any]()


func setUpFirebase(){
    
    let settings = FirestoreSettings()

          Firestore.firestore().settings = settings
          // [END setup]
          db = Firestore.firestore()

}

func createQueue(queueName: String, averageTimeCustomer: String, minutesBeforeNotifyingCustomer: String){
    
    
    
    ref = db.collection("queue").addDocument(data: [
               "Name": queueName,
               "Reminder": Int (minutesBeforeNotifyingCustomer),
               "TimePerCustomer": Int(averageTimeCustomer),
               "UserQueue" : [DocumentReference]()
           ]){error in
               if let error = error{
                   print("Error adding document: \(error)")
               }else{
                   print("Document added with ID: \(ref!.documentID)")
               }
           }
           db.collection("queue").document(ref!.documentID).addSnapshotListener { (documentSnapshot, error) in
               guard let document = documentSnapshot else {
                   print("Error fetching document: \(error!)")
                   return
               }
               guard let data = document.data() else {
                   print("Document data was empty")
                   return
               }
               let referenceArray = data["UserQueue"] as! [DocumentReference]
               var totalTime = data["TimePerCustomer"] as! Int
               totalTime = totalTime * referenceArray.count

            if !referenceArray.isEmpty{
                let firstUser = referenceArray[0]
                getUser(ref: firstUser, totalTime: totalTime, count: referenceArray.count)
            }
            
           }
    
}


func getUser(ref: DocumentReference, totalTime: Int, count: Int){
    
    ref.getDocument { (document, error) in
        guard let document = document else{
            print(error?.localizedDescription)
            return
        }
        if let name = document.data()?["Name"] as? String {
            
          
            let newTotalTime = String(totalTime)
            let newLength = String(count)
            print("Total Time: \(totalTime); First Customer: \(name)")
            dataDictionary["name"] = name
            dataDictionary["waitingTime"] = totalTime
            dataDictionary["queueLength"] = count
            
            ViewController.updateQueue(waitingTime: newTotalTime, queueLength: newLength)
            
            
            print("Total Time: \(totalTime); First Customer: \(name)")
            print("Total in queue: \(count)")
        }else{
            getUser(ref: ref, totalTime: totalTime, count: count)
        }
    }
}




