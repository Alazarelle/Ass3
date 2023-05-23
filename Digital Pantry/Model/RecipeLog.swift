//
//  RecipeLog.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation

struct RecipeLog {
    //properties/members of RecipeLog
    var recipeLogID: Int
    //var appUserID: Int
    var recipeID: Int
    var createdAtDate: Date
    

    //initialised where we have not obtained a UniqueIdentifier (recipeLogID) as yet
    init?(recipeID: Int, createdAtDate: Date) {
        self.recipeLogID = -1
        //self.appUserID = appUserID
        self.recipeID = recipeID
        self.createdAtDate = createdAtDate
    }
    
    //use case: calling data back from DB/table
    init?(recipeLogID: Int, recipeID: Int, createdAtDate: Date) {
        self.recipeLogID = recipeLogID
        //self.appUserID = appUserID
        self.recipeID = recipeID
        self.createdAtDate = createdAtDate
    }
    
    mutating func setRecipeLogID(recipeLogID: Int) { //once the DB has a recipeLogID, use this to set it
        self.recipeLogID = recipeLogID
    }
    
    func getRecipeLogID() -> Int { //retrieve recipeLogID
        return recipeLogID
    }
    
    //func getAppUserId() -> Int { //retrieve AppUserID
    //    return appUserID
    //}
    
    func getRecipeId() -> Int { //retrieve recipeID
        return recipeID
    }
    
    mutating func setRecipeID(recipeID: Int) { //add a recipeID to item
        self.recipeID = recipeID
    }
    
    mutating func setCreatedAtDate(createdAtDate: Date) { //set new createdAtDate
        self.createdAtDate = createdAtDate
    }
    
    func getCreatedAtDate() -> Date { //retrieve createdAtDate
        return createdAtDate
    }
}
