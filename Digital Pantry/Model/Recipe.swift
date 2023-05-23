//
//  Recipe.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation

struct Recipe {
    //properties/members of Recipe
    var recipeID: Int
    var recipeName: String
    var recipeDescription: String
    var cookingTime: Int
    var complexity: Int
    //initialised where we have not obtained a UniqueIdentifier (recipeID) as yet
    init?(foodCategoryID: Int, recipeName: String, recipeDescription: String, cookingTime: Int, complexity: Int) {
        self.recipeID = -1
        self.recipeName = recipeName
        self.recipeDescription = recipeDescription
        self.cookingTime = cookingTime
        self.complexity = complexity
    }
    
    //use case: calling data back from DB/table
    init?(recipeID: Int, foodCategoryID: Int, recipeName: String, recipeDescription: String, cookingTime: Int, complexity: Int) {
        self.recipeID = recipeID
        self.recipeName = recipeName
        self.recipeDescription = recipeDescription
        self.cookingTime = cookingTime
        self.complexity = complexity
    }
    
    mutating func setRecipeID(recipeID: Int) { //once the DB has a recipeID, use this to set it
        self.recipeID = recipeID
    }
    
    func getRecipeID() -> Int { //retrieve recipeID
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
    
    mutating func setCookingTime(cookingTime: Int) { //set cookingTime
        self.cookingTime = cookingTime
    }
    
    func getCookingTime() -> Int { //retrieve cookingTime
        return cookingTime
    }
    
    mutating func setComplexity(complexity: Int) { //set complexity
        self.complexity = complexity
    }
    
    func getComplexity() -> Int { //retrieve complexity
        return complexity
    }
}
