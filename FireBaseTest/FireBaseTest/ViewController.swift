//
//  ViewController.swift
//  FireBaseTest
//
//  Created by Benedikt Langer on 24.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFunctions
import UserNotifications

var dbstat: Firestore!

class ViewController: UIViewController {
    
    var db: Firestore!
    var ref: DocumentReference?
    var refID: String = "gxakLA319khxbfwMhr6Q"
    lazy var functions = Functions.functions()
    var userID: String = ""
    var firstUser: DocumentReference?
    var token: String?
    static var receivedAps: [String: AnyObject]?
    var inc: Int = 0;
    
    static func setAps(aps: [String: AnyObject]){
       receivedAps  = aps
    }

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // [START setup]
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error{
                print(error.localizedDescription)
            }else if let result = result{
                self.token = result.token
                
                //print(result.token)
            }
        }
        label.text = "\(ViewController.receivedAps?.keys)"
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
        
    }
    
    @objc func onDidReceiveData(_ notification:Notification) {
        // Do something now
        
        if let data = notification.userInfo as? [String: AnyObject]
        {
            let count = data["customerCount"] as? Int
            let firstName = data["first"] as? String
            let firstPosition = data["numberFirst"] as? Int
            let secondName = data["second"] as? String
            label.text = "Total Customers: \(count ?? 0), first: \(firstName ?? "")\n" +
            "FirstPosition: \(firstPosition ?? 0), SecondName: \(secondName ?? ""))"
        }
    }
    
    
    @IBAction func createQueue(_ sender: UIButton) {
        
        print("Token: \(token)" )
        
        
        ref = db.collection("queue").addDocument(data: [
            "CurrentNumber": 0
            "DeviceToken": token ?? "",
            "Name": "Queue4",
            "Reminder": 3,
            "TimePerCustomer": 5,
            "UserQueue" : [DocumentReference]()
        ]){error in
            if let error = error{
                print("Error adding document: \(error)")
            }else{
                print("Document added with ID: \(self.ref!.documentID)")
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
                self.firstUser = referenceArray[0]
                self.getUser(ref: self.firstUser!, totalTime: totalTime, count: referenceArray.count)
            }
            
            
            
        }
        //refID = ref?.documentID
        
    }
    
    func getUser(ref: DocumentReference, totalTime: Int, count: Int){
        
        ref.getDocument { (document, error) in
            guard let document = document else{
                print(error?.localizedDescription)
                return
            }
            if let name = document.data()?["Name"] as? String {
                print("Total Time: \(totalTime); First Customer: \(name)")
                print("Total in queue: \(count)")
            }else{
                self.getUser(ref: ref, totalTime: totalTime, count: count)
            }
        }
    }
    
    @IBAction func deleteActualQueue(_ sender: UIButton) {
        
        db.collection("queue").document(refID).delete(){err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    @IBAction func addUser(_ sender: UIButton) {
        
        let users = ["User1", "User2", "User3", "User4", "User5"]
        
        
        let dataDict: [String: Any] = ["id": refID, "reference": users[inc]]
        inc += 1
        
        functions.httpsCallable("putReference").call(dataDict) { (result, error) in
            if let error = error as NSError? {
              if error.domain == FunctionsErrorDomain {
                let code = FunctionsErrorCode(rawValue: error.code)
                let message = error.localizedDescription
                let details = error.userInfo[FunctionsErrorDetailsKey]
                print(message, details)
              }
              // ...
            }
            
        }
    }
    
    @IBAction func deleteFirstUser(_ sender: UIButton) {
        
        
        let call: Void = db.collection("queue").document(refID).updateData(["UserQueue" : FieldValue.arrayRemove([firstUser])])
        
    
}
    
    @IBAction func retrieveData(_ sender: UIButton) {
        
        let refDict = ["queueID": refID, "userID": "User3"]
        
        functions.httpsCallable("fetchQueueData").call(refDict) { (result, error) in
            
            guard let data = result?.data as? [String: Any] else{
                return
            }
            
            if let total = data["TotalNumber"] as? Int, let totalTime = data["TotalTime"] as? Int{
                print("There are \(total) user in the line. Total Time is \(totalTime) minutes")
            }
            
            if let index = data["CurrentIndex"] as? Int {
                print("Your position is \(index+1) in the queue. There are \(index) people ahead")
            }
            
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
    

    
//public struct Queue: Codable {
//    
//    var Name: String?
//    var Reminder: Int64?
//    var TimePerCustomer: Int64?
//    var UserQueue: [DocumentReference]
//    
//    enum CodingKeys: String, CodingKey{
//
//        case Name
//        case Reminder
//        case TimePerCustomer
//        case UserQueue
//    }
//}



}


