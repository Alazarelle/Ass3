//
//  Recipe.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation

struct Recipe {
    //properties/members of Recipe
    var recipeID: Int64
    var recipeName: String
    var recipeDescription: String
    var cookingTime: Int64
    var complexity: Int64
    //initialised where we have not obtained a UniqueIdentifier (recipeID) as yet
    init?(foodCategoryID: Int64, recipeName: String, recipeDescription: String, cookingTime: Int64, complexity: Int64) {
        self.recipeID = -1
        self.recipeName = recipeName
        self.recipeDescription = recipeDescription
        self.cookingTime = cookingTime
        self.complexity = complexity
    }
    
    //use case: calling data back from DB/table
    init?(recipeID: Int64, foodCategoryID: Int64, recipeName: String, recipeDescription: String, cookingTime: Int64, complexity: Int64) {
        self.recipeID = recipeID
        self.recipeName = recipeName
        self.recipeDescription = recipeDescription
        self.cookingTime = cookingTime
        self.complexity = complexity
    }
    
    mutating func setRecipeID(recipeID: Int64) { //once the DB has a recipeID, use this to set it
        self.recipeID = recipeID
    }
    
    func getRecipeID() -> Int64 { //retrieve recipeID
        return recipeID
    }
    
    mutating func setRecipeName(recipeName: String) { //set recipeName
        self.recipeName = recipeName
    }

    func getRecipeName() -> String { //get recipeName
        return recipeName
    }
    
    func getRecipeDescription() -> String { //retrieve ingredient description
        return recipeDescription
    }
    
    mutating func setRecipeDescription(recipeDescription: String) { //add a ingredient description to item
        self.recipeDescription = recipeDescription
    }
    
    mutating func setCookingTime(cookingTime: Int64) { //set cookingTime
        self.cookingTime = cookingTime
    }
    
    func getCookingTime() -> Int64 { //retrieve cookingTime
        return cookingTime
    }
    
    mutating func setComplexity(complexity: Int64) { //set complexity
        self.complexity = complexity
    }
    
    func getComplexity() -> Int64 { //retrieve complexity
        return complexity
    }
}
