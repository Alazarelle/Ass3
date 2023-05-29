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
    var instructions: String
    var cookingTime: String
    var complexity: Int64
    
    
    //initialised where we have not obtained a UniqueIdentifier (recipeID) as yet
    init(recipeName: String, instructions: String, cookingTime: String, complexity: Int64) {
        self.recipeID = -1
        self.recipeName = recipeName
        self.instructions = instructions
        self.cookingTime = cookingTime
        self.complexity = complexity
    }
    
    //use case: calling data back from DB/table
    init?(recipeID: Int64, recipeName: String, instructions: String, cookingTime: String, complexity: Int64) {
        self.recipeID = recipeID
        self.recipeName = recipeName
        self.instructions = instructions
        self.cookingTime = cookingTime
        self.complexity = complexity
    }
    
    init?(aiGeneratedRecipe: AIGeneratedRecipe){
        self.recipeID = -1
        self.recipeName = aiGeneratedRecipe.recipeName
        self.instructions = ""
        for instruction in aiGeneratedRecipe.instructions{
            self.instructions.append(instruction)
            self.instructions.append("\n")
        }
        self.cookingTime = aiGeneratedRecipe.cookingTime
        self.complexity = Int64(aiGeneratedRecipe.complexity)!
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
    
    func getRecipeInstructions() -> String { //retrieve ingredient description
        return instructions
    }
    
    mutating func setRecipeDescription(instructions: String) { //add a ingredient description to item
        self.instructions = instructions
    }
    
    mutating func setCookingTime(cookingTime: String) { //set cookingTime
        self.cookingTime = cookingTime
    }
    
    func getCookingTime() -> String { //retrieve cookingTime
        return cookingTime
    }
    
    mutating func setComplexity(complexity: Int64) { //set complexity
        self.complexity = complexity
    }
    
    func getComplexity() -> Int64 { //retrieve complexity
        return complexity
    }
    

}

struct AIGeneratedRecipe: Codable {
    //properties/members of Recipe
    var recipeName: String
    var instructions: [String]
    var cookingTime: String
    var complexity: String
    var ingredients: [String]
    
    private enum CodingKeys: String, CodingKey {
        case recipeName = "recipeName"
        case ingredients = "ingredients"
        case instructions = "instructions"
        case cookingTime = "cookingTime"
        case complexity = "complexity"
    }
}
