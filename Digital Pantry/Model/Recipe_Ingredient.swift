//
//  Recipe_Ingredient.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation


struct Recipe_Ingred {
    //properties/members of Recipe_Ingred
    var recipe_IngredientID: Int64
    var recipeID: Int64
    var ingredID: Int64
    
    //initialised where we have not obtained a UniqueIdentifier (recipe_IngredientID) as yet
    init?(recipeID: Int64, ingredID: Int64) {
        self.recipe_IngredientID = -1
        self.recipeID = recipeID
        self.ingredID = ingredID
    }
    
    //use case: calling data back from DB/table
    init?(recipe_IngredientID: Int64, recipeID: Int64, ingredID: Int64) {
        self.recipe_IngredientID = recipe_IngredientID
        self.recipeID = recipeID
        self.ingredID = ingredID
    }
    
    mutating func setRecipe_IngredientID(recipe_IngredientID: Int64) { //once the DB has a recipe_IngredientID, use this to set it
        self.recipe_IngredientID = recipe_IngredientID
    }
    
    func getRecipe_IngredientID() -> Int64 { //retrieve recipe_IngredientID
        return recipe_IngredientID
    }
        
    func getRecipeID() -> Int64 { //retrieve recipeID
        return recipeID
    }
    
    mutating func setRecipeID(recipeID: Int64) { //add a recipeID to item
        self.recipeID = recipeID
    }

    func getIngredID() -> Int64 { //retrieve ingredID
        return ingredID
    }
    
    mutating func setIngredID(ingredID: Int64) { //add a ingredID to item
        self.ingredID = ingredID
    }
}
