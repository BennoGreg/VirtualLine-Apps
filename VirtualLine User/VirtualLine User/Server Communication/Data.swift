//
//  Data.swift
//  VirtualLine User
//
//  Created by Niklas Wagner on 16.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

import UIKit

struct QueuesData{
    
    let allQueues: [Queue] = [
     
     .init(name: "Klipp", waitingTime: 62, queueLength: 4),
     .init(name: "Magenta Store", waitingTime: 12, queueLength: 3),
     .init(name: "Mödling BH", waitingTime: 143, queueLength: 16),
     .init(name: "Primark", waitingTime: 5, queueLength: 2),
     .init(name: "H&M", waitingTime: 23, queueLength: 3),
     .init(name: "Interspar", waitingTime: 2, queueLength: 1),
     .init(name: "Spar", waitingTime: 1, queueLength: 1),
         
     ]
     
     let currentQueues: [Queue] = [
     
     .init(name: "H&M", waitingTime: 23, queueLength: 3),
    
     
     ]
    
    
    
}



