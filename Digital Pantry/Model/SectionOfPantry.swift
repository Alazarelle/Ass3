//
//  SectionOfPantry.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

//Note: to be implemented if we have time to do so (Pantry breakdown of Ingredients into storage locations of: Pantry, Fridge or Freezer)

import Foundation

struct SectionOfPantry {
    //properties/members of Recipe_Diet
    var sectionID: Int64
    var section: String
    var appPantryID: Int64
    //var appUserID: Int64
    
    
    //initialised where we have not obtained a UniqueIdentifier (recipe_DietID) as yet
    init?(section: String, appPantryID: Int64) {
        self.sectionID = -1
        self.section = section
        self.appPantryID = appPantryID
        
    }
    
    //use case: calling data back from DB/table
    init?(sectionID: Int64, section: String, appPantryID: Int64) {
        self.sectionID = sectionID
        self.section = section
        self.appPantryID = appPantryID
    }
    
    mutating func setSectionID(sectionID: Int64) { //once the DB has a sectionID, use this to set it
        self.sectionID = sectionID
    }
    
    func getSectionID() -> Int64 { //retrieve sectionID
        return sectionID
    }
        
    func getSection() -> String { //retrieve section
        return section
    }
    
    mutating func setSection(section: String) { //add a section to item
        self.section = section
    }

    func getAppPantryID() -> Int64 { //retrieve appPantryID
        return appPantryID
    }
    
    mutating func setAppPantryID(appPantryID: Int64) { //add a appPantryID to item
        self.appPantryID = appPantryID
    }
}
