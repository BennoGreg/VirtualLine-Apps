//
//  SettingsSection.swift
//  VirtualLine User
//
//  Created by Niklas Wagner on 24.05.20.
//  Copyright © 2020 Benedikt. All rights reserved.
//

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool {get}
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible{
    
    case profile
    case settings
    case aboutUs
    
  
    var description: String {
        
        switch self {
        case .profile:
            return "Profile"
        case .settings:
            return "Settings"
        case .aboutUs:
            return "About us" 
        }
        
    }
    
    
}

enum ProfileOptions: Int, CaseIterable, CustomStringConvertible, SectionType{
    var containsSwitch: Bool {return false}
    
    
    case editProfile
    case logOut
    
    var description: String {
           
           switch self {
           case .editProfile:
               return "Edit Profile"
           case .logOut:
               return "Log Out"
           }
           
       }
}

enum SettingsOptions: Int, CaseIterable, SectionType{
  
   
    
    case notification
    case language
    
    var containsSwitch: Bool {
        
        switch self {
        case .notification:
            return true
        case .language:
            return false
        default:
            return false
        }
        
    }
    
    var description: String {
        
        switch self {
        case .notification:
            return "Notification"
        case .language:
            return "Language"
        }
        
    }
    
}

enum AboutUsOptions: Int, CaseIterable, CustomStringConvertible, SectionType{
    var containsSwitch: Bool {return false}
    
    
    case gtc
    case dataPrivacy
    
    var description: String {
           
           switch self {
           case .gtc:
               return "General terms and conditions (GTC)"
           case .dataPrivacy:
               return "Data Privacy"
           }
           
       }
}

