//
//  RecipeDiet.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation

struct Recipe_Diet {
    //properties/members of Recipe_Diet
    var recipe_DietID: Int
    var recipeID: Int
    var dietID: Int
    
    //initialised where we have not obtained a UniqueIdentifier (recipe_DietID) as yet
    init?(recipeID: Int, dietID: Int) {
        self.recipe_DietID = -1
        self.recipeID = recipeID
        self.dietID = dietID
    }
    
    //use case: calling data back from DB/table
    init?(recipe_DietID: Int, recipeID: Int, dietID: Int) {
        self.recipe_DietID = recipe_DietID
        self.recipeID = recipeID
        self.dietID = dietID
    }
    
    mutating func setRecipe_DietID(recipe_DietID: Int) { //once the DB has a recipe_DietID, use this to set it
        self.recipe_DietID = recipe_DietID
    }
    
    func getRecipe_DietID() -> Int { //retrieve recipe_DietID
        return recipe_DietID
    }
        
    func getRecipeID() -> Int { //retrieve recipeID
        return recipeID
    }
    
    mutating func setRecipeID(recipeID: Int) { //add a recipeID to item
        self.recipeID = recipeID
    }

    func getDietID() -> Int { //retrieve dietID
        return dietID
    }
    
    mutating func setIngredID(dietID: Int) { //add a dietID to item
        self.dietID = dietID
    }
}
