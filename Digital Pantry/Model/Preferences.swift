//
//  Preferences.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

//to store a person's allergies and diets and your pantry items about to expire
import Foundation

struct Preference {
    //properties/members of Preference
    var preferenceID: Int64
    var type: String
    var typeID: Int64
    
    //initialised where we have not obtained a UniqueIdentifier (preferenceID) as yet
    init?(type: String, typeID: Int64) {
        self.preferenceID = -1
        self.type = type
        self.typeID = typeID
    }
    
    //use case: calling data back from DB/table
    init?(preferenceID: Int64, type: String, typeID: Int64 ) {
        self.preferenceID = preferenceID
        self.type = type
        self.typeID = typeID
        
    }
    
    mutating func setDietCategoryID(preferenceID: Int64) { //once the DB has a preferenceID, use this to set it
        self.preferenceID = preferenceID
    }
    
    func getPreferenceID() -> Int64 { //retrieve preferenceID
        return preferenceID
    }
        
    func getType() -> String { //retrieve type
        return type
    }
    
    mutating func setType(type: String) { //add a type to item
        self.type = type
    }

    func getTypeID() -> Int64 { //retrieve typeID
        return typeID
    }
    
    mutating func setTypeID(typeID: Int64) { //add a typeID to item
        self.typeID = typeID
    }
}
