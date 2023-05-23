//
//  Recipe_Ingredient.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation


struct Recipe_Ingred {
    //properties/members of Recipe_Ingred
    var recipe_IngredientID: Int
    var recipeID: Int
    var ingredID: Int
    
    //initialised where we have not obtained a UniqueIdentifier (recipe_IngredientID) as yet
    init?(recipeID: Int, ingredID: Int) {
        self.recipe_IngredientID = -1
        self.recipeID = recipeID
        self.ingredID = ingredID
    }
    
    //use case: calling data back from DB/table
    init?(recipe_IngredientID: Int, recipeID: Int, ingredID: Int) {
        self.recipe_IngredientID = recipe_IngredientID
        self.recipeID = recipeID
        self.ingredID = ingredID
    }
    
    mutating func setRecipe_IngredientID(recipe_IngredientID: Int) { //once the DB has a recipe_IngredientID, use this to set it
        self.recipe_IngredientID = recipe_IngredientID
    }
    
    func getRecipe_IngredientID() -> Int { //retrieve recipe_IngredientID
        return recipe_IngredientID
    }
        
    func getRecipeID() -> Int { //retrieve recipeID
        return recipeID
    }
    
    mutating func setRecipeID(recipeID: Int) { //add a recipeID to item
        self.recipeID = recipeID
    }

    func getIngredID() -> Int { //retrieve ingredID
        return ingredID
    }
    
    mutating func setIngredID(ingredID: Int) { //add a ingredID to item
        self.ingredID = ingredID
    }
}
