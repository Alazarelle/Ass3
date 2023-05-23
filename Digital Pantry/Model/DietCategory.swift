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
    var dietCategDescripion: String
    
    //initialised where we have not obtained a UniqueIdentifier (dietCategoryID) as yet
    init?(dietCategName: String, dietCategDescripion: String) {
        self.dietCategoryID = -1
        self.dietCategName = dietCategName
        self.dietCategDescripion = dietCategDescripion
    }
    
    //use case: calling data back from DB/table
    init?(dietCategoryID: Int, dietCategName: String, dietCategDescripion: String) {
        self.dietCategoryID = dietCategoryID
        self.dietCategName = dietCategName
        self.dietCategDescripion = dietCategDescripion
        
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

    func getDietCategDescripion() -> String { //retrieve dietCategDescripion
        return dietCategDescripion
    }
    
    mutating func setDietCategDescripion(dietCategDescripion: String) { //add a dietCategDescripion to item
        self.dietCategDescripion = dietCategDescripion
    }
}
