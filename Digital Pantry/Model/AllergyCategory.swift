//
//  AllergyCategory.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation

struct AllergyCategory {
    //properties/members of AllergyCategory
    var allergyCategoryID: Int
    var allergyCategName: String
    var allergyCategdescription: String
    
    //initialised where we have not obtained a UniqueIdentifier (allergyCategoryID) as yet
    init?(allergyCategName: String, allergyCategdescription: String) {
        self.allergyCategoryID = -1
        self.allergyCategName = allergyCategName
        self.allergyCategdescription = allergyCategdescription
    }
    
    //use case: calling data back from DB/table
    init?(allergyCategoryID: Int, allergyCategName: String, allergyCategdescription: String) {
        self.allergyCategoryID = allergyCategoryID
        self.allergyCategName = allergyCategName
        self.allergyCategdescription = allergyCategdescription
        
    }
    
    mutating func setAllergyCategoryID(allergyCategoryID: Int) { //once the DB has a allergyCategoryID, use this to set it
        self.allergyCategoryID = allergyCategoryID
    }
    
    func getAllergyCategoryID() -> Int { //retrieve allergyCategoryID
        return allergyCategoryID
    }
        
    func getAllergydCategName() -> String { //retrieve allergyCategName
        return allergyCategName
    }
    
    mutating func setAllergyCategName(allergyCategName: String) { //add a allergyCategName to item
        self.allergyCategName = allergyCategName
    }

    func getAllergyCategdescription() -> String { //retrieve allergyCategdescription
        return allergyCategdescription
    }
    
    mutating func setAllergyCategdescription(allergyCategdescription: String) { //add a allergyCategdescription to item
        self.allergyCategdescription = allergyCategdescription
    }
}
