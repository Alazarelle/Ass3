//
//  Ingredients.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation

struct Ingredient {
    //properties/members of Ingredient
    var ingredientID: Int
    var foodCategoryID: Int
    var ingredName: String
    var ingredDescripion: String
    
    //initialised where we have not obtained a UniqueIdentifier (ingredientID) as yet
    init?(ingredName: String, foodCategoryID: Int, ingredDescripion: String) { 
        self.ingredientID = -1
        self.foodCategoryID = foodCategoryID
        self.ingredName = ingredName
        self.ingredDescripion = ingredDescripion
    }
    
    //use case: calling data back from DB/table
    init?(ingredientID: Int, foodCategoryID: Int, ingredName: String, ingredDescripion: String) { //, sectionID: Int) {
        self.ingredientID = ingredientID
        self.foodCategoryID = foodCategoryID
        self.ingredName = ingredName
        self.ingredDescripion = ingredDescripion
    }
    
    mutating func setIngredientID(ingredientID: Int) { //once the DB has a ingredientID, use this to set it
        self.ingredientID = ingredientID
    }
    
    func getIngredientID() -> Int { //retrieve ingredientID
        return ingredientID
    }
    
    mutating func setFoodCategoryID(foodCategoryID: Int) { //set foodCategoryID
        self.foodCategoryID = foodCategoryID
    }
    
    func getFoodCategoryID() -> Int { //retrieve foodCategoryID
        return foodCategoryID
    }
    
    func getIngredName() -> String { //retrieve ingredient name
        return ingredName
    }
    
    mutating func setIngredName(ingredName: String) { //add a ingredient name to item
        self.ingredName = ingredName
    }

    func getIngredDescription() -> String { //retrieve ingredient name
        return ingredDescripion
    }
    
    mutating func setIngredDescription(ingredDescripion: String) { //add a ingredient name to item
        self.ingredDescripion = ingredDescripion
    }
}
