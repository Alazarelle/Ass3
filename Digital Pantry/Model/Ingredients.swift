//
//  Ingredients.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation

struct Ingredient {
    //properties/members of Ingredient
    var ingredientID: Int64
    //var foodCategoryID: Int64
    var ingredName: String
    var ingredDescription: String
    
    //initialised where we have not obtained a UniqueIdentifier (ingredientID) as yet
    init?(ingredName: String, /*foodCategoryID: Int64,*/ ingredDescription: String) {
        self.ingredientID = -1
        //self.foodCategoryID = foodCategoryID
        self.ingredName = ingredName
        self.ingredDescription = ingredDescription
    }
    
    //use case: calling data back from DB/table
    init?(ingredientID: Int64, /*foodCategoryID: Int64, */ingredName: String, ingredDescription: String) { //, sectionID: Int) {
        self.ingredientID = ingredientID
        //self.foodCategoryID = foodCategoryID
        self.ingredName = ingredName
        self.ingredDescription = ingredDescription
    }
    
    mutating func setIngredientID(ingredientID: Int64) { //once the DB has a ingredientID, use this to set it
        self.ingredientID = ingredientID
    }
    
    func getIngredientID() -> Int64 { //retrieve ingredientID
        return ingredientID
    }
    
    /*mutating func setFoodCategoryID(foodCategoryID: Int64) { //set foodCategoryID
        self.foodCategoryID = foodCategoryID
    }*/
    
    /*func getFoodCategoryID() -> Int64 { //retrieve foodCategoryID
        return foodCategoryID
    }*/
    
    func getIngredName() -> String { //retrieve ingredient name
        return ingredName
    }
    
    mutating func setIngredName(ingredName: String) { //add a ingredient name to item
        self.ingredName = ingredName
    }

    func getIngredDescription() -> String { //retrieve ingredient name
        return ingredDescription
    }
    
    mutating func setIngredDescription(ingredDescription: String) { //add a ingredient name to item
        self.ingredDescription = ingredDescription
    }
}
