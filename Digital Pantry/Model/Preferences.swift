//
//  Preferences.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation

struct Preference {
    //properties/members of Preference
    var preferenceID: Int
    var type: String
    var typeID: Int
    
    //initialised where we have not obtained a UniqueIdentifier (preferenceID) as yet
    init?(type: String, typeID: Int) {
        self.preferenceID = -1
        self.type = type
        self.typeID = typeID
    }
    
    //use case: calling data back from DB/table
    init?(preferenceID: Int, type: String, typeID: Int ) {
        self.preferenceID = preferenceID
        self.type = type
        self.typeID = typeID
        
    }
    
    mutating func setDietCategoryID(preferenceID: Int) { //once the DB has a preferenceID, use this to set it
        self.preferenceID = preferenceID
    }
    
    func getPreferenceID() -> Int { //retrieve preferenceID
        return preferenceID
    }
        
    func getType() -> String { //retrieve type
        return type
    }
    
    mutating func setType(type: String) { //add a type to item
        self.type = type
    }

    func getTypeID() -> Int { //retrieve typeID
        return typeID
    }
    
    mutating func setTypeID(typeID: Int) { //add a typeID to item
        self.typeID = typeID
    }
}
