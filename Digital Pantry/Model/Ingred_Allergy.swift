//
//  Ingred_Allergy.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation

struct Ingred_Allergy {
    //properties/members of DietCategory
    var ingred_AllergyID: Int64
    var ingredID: Int64
    var allergyID: Int64
    
    //initialised where we have not obtained a UniqueIdentifier (ingred_AllergyID) as yet
    init?(ingredID: Int64, allergyID: Int64) {
        self.ingred_AllergyID = -1
        self.ingredID = ingredID
        self.allergyID = allergyID
    }
    
    //use case: calling data back from DB/table
    init?(ingred_AllergyID: Int64, ingredID: Int64, allergyID: Int64) {
        self.ingred_AllergyID = ingred_AllergyID
        self.ingredID = ingredID
        self.allergyID = allergyID
        
    }
    
    mutating func setIngred_AllergyID(ingred_AllergyID: Int64) { //once the DB has a ingred_AllergyID, use this to set it
        self.ingred_AllergyID = ingred_AllergyID
    }
    
    func getIngred_AllergyID() -> Int64 { //retrieve ingred_AllergyID
        return ingred_AllergyID
    }
        
    func getIngredID() -> Int64 { //retrieve ingredID
        return ingredID
    }
    
    mutating func setIngredID(ingredID: Int64) { //add a ingredID to item
        self.ingredID = ingredID
    }

    func getAllergyID() -> Int64 { //retrieve allergyID
        return allergyID
    }
    
    mutating func setAllergyID(allergyID: Int64) { //add a allergyID to item
        self.allergyID = allergyID
    }
}
