//
//  AppUser.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 19/5/2023.
//

import Foundation

struct AppUser {
    //properties/members of AppUser
    var appUserID: Int
    let loginEmail: String
    var preferredName: String
    var hasDietNeed: Bool?
    var isAdmin: Bool?
    var deactivate: Bool?
    
    //initialised where we have not obtained a UniqueIdentifier (appUserID) as yet
    init?(loginEmail: String, preferredName: String, hasDietNeed: Bool) {
        self.appUserID = -1
        if loginEmail.isEmpty || preferredName.isEmpty { //if mandatory fields/properties are empty
            print("LoginEmail or PreferredName not set")
            return nil
        }
        self.loginEmail = loginEmail
        self.preferredName = preferredName
        self.hasDietNeed = hasDietNeed
        self.isAdmin = false //new member setup defaults as false
        self.deactivate = false //new member setup defaults as false
    }
    
    //use case: calling data back from DB/table
    init?(appUserID: Int, loginEmail: String, preferredName: String, hasDietNeed: Bool, isAdmin: Bool, deactivate: Bool) {
        self.appUserID = appUserID
        self.loginEmail = loginEmail
        self.preferredName = preferredName
        self.hasDietNeed = hasDietNeed
        self.isAdmin = isAdmin
        self.deactivate = deactivate
    }
    
    mutating func setAppUserId(appUserID: Int) { //once the DB has a UserID, use this to set it
        self.appUserID = appUserID
    }
    
    func getAppUserId() -> Int { //retrieve UserID
        return appUserID
    }
    
    func getLoginEmail() -> String { //retrieve loginEmail
        return loginEmail
    }
    
    mutating func setPreferredName(preferredName: String) { //set new "preferred Name"
        self.preferredName = preferredName
    }
    
    func getPreferredName() -> String { //retrieve "preferred name"
        return preferredName
    }
    
    mutating func setHasDietNeed(hasDietNeed: Bool) { //set flag for dietary need
        self.hasDietNeed = hasDietNeed
    }
    
    func getHasDietNeed() -> Bool { //retrieve "hasDietNeed" flag
        return hasDietNeed!
    }
    
    mutating func setIsAdmin(isAdmin: Bool) { //set flag for admin
        self.isAdmin = isAdmin
    }
    
    func getIsAdmin() -> Bool { //get flag for admin
        return isAdmin!
    }
    
    mutating func setDeactivate(deactivate: Bool) { //set deactivate flag
        self.deactivate = deactivate
    }
    
    func getDeactivate() -> Bool { //get flag for deactivate account
        return deactivate!
    }
}
