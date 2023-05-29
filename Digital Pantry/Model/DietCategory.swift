//
//  DietCategory.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation

struct DietCategory {
    //properties/members of DietCategory
    var dietCategoryID: Int
    var dietCategName: String
    var dietCategdescription: String
    
    //initialised where we have not obtained a UniqueIdentifier (dietCategoryID) as yet
    init?(dietCategName: String, dietCategdescription: String) {
        self.dietCategoryID = -1
        self.dietCategName = dietCategName
        self.dietCategdescription = dietCategdescription
    }
    
    //use case: calling data back from DB/table
    init?(dietCategoryID: Int, dietCategName: String, dietCategdescription: String) {
        self.dietCategoryID = dietCategoryID
        self.dietCategName = dietCategName
        self.dietCategdescription = dietCategdescription
        
    }
    
    mutating func setDietCategoryID(dietCategoryID: Int) { //once the DB has a dietCategoryID, use this to set it
        self.dietCategoryID = dietCategoryID
    }
    
    func getDietCategoryID() -> Int { //retrieve dietCategoryID
        return dietCategoryID
    }
        
    func getDietdCategName() -> String { //retrieve dietCategName
        return dietCategName
    }
    
    mutating func setDietCategName(dietCategName: String) { //add a dietCategName to item
        self.dietCategName = dietCategName
    }

    func getDietCategdescription() -> String { //retrieve dietCategdescription
        return dietCategdescription
    }
    
    mutating func setDietCategdescription(dietCategdescription: String) { //add a dietCategdescription to item
        self.dietCategdescription = dietCategdescription
    }
}
