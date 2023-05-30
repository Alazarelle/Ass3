//
//  DB_update.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 29/5/2023.
//

import Foundation

import Foundation
import SQLite
import SQLite3
import CoreXLSX


func updateAllergy(allergyID: Int64, updatedAllergy : AllergyCategory) {//query to make a change to an allergy record in DB
    do {
        let db = connectDatabase()
        //handle allergy  data
        let allergy = Table("allergyCategory")
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
        let thisAllergy = allergy.filter( id == allergyID)
        
        try db.run(thisAllergy.update(
            name <- updatedAllergy.allergyCategName,
            desc <- updatedAllergy.allergyCategdescription ))
    } catch {
        print (error)
    }
}

func updateDietCat(dietID: Int64, updatedDiet : DietCategory) {//query to make a change to an DietCategory record in DB
    do {
        let db = connectDatabase()
        //handle dietCat  data
        let dietCat = Table("dietCategory")
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
        let thisDiet = dietCat.filter(id == dietID)
        
        try db.run(thisDiet.update(
            name <- updatedDiet.dietCategName,
            desc <- updatedDiet.dietCategdescription ))
    } catch {
        print (error)
    }
}

func updateFoodCat(foodCatId : Int64, updatedFoodCat : FoodCategory) {//query to make a change to an FoodCategory record in DB
    do {
        let db = connectDatabase()
        //handle foodCat  data
        let foodCat = Table("foodCategory")
        
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        
        let thisFoodCat = foodCat.filter(id == foodCatId)
        
        try db.run(thisFoodCat.update(
            name <- updatedFoodCat.foodCategName))
    } catch {
        print (error)
    }
}

func updateIngredient(ingredientID : Int64, updatedIngredient : Ingredient) {//query to make a change to an Ingredient record in DB
    do {
        let db = connectDatabase()
        
        //handle ingredients  data
        let ingredients = Table("ingredients")
        
        let id = Expression<Int64>("id")
        let foodCatId = Expression<Int64>("foodCategoryId")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
        let thisIngredient = ingredients.filter(id == ingredientID)
        
        try db.run(thisIngredient.update(
            foodCatId <- updatedIngredient.foodCategoryID,
            name <- updatedIngredient.ingredName,
            desc <- updatedIngredient.ingredDescription ))
    } catch {
        print (error)
    }
}

func updateInventory(pantryID : Int64, updatedPantryItem : AppPantryItem) {//query to make a change to an AppPantryItem record in DB
 do {
     let db = connectDatabase()
     //handle Inventory  data
     let inventory = Table("inventory")
     let ingredient = Table("ingredients")

     let id = Expression<Int64>("id")
//     let ingredientID = Expression<Int64>("ingredientID")
     let quantity = Expression<Int64>("quantity")
     let expiryDate = Expression<Date>("expiryDate")
     let name = Expression<String>("name")
     let desc = Expression<String>("desc")
     
     let thisInventory = inventory.filter(id == pantryID)
     let thisIngredient = ingredient.filter(id == updatedPantryItem.ingredientID)
     
     try db.run(thisInventory.update(
        id <- pantryID,
        quantity <- updatedPantryItem.quantity,
        expiryDate <- updatedPantryItem.expiryDate
//   shoppingList <- newPantryItem.shoppingList
     ))
     
     try db.run(thisIngredient.update(
        id <- updatedPantryItem.ingredientID,
        name <- updatedPantryItem.ingredientName,
        desc <- updatedPantryItem.ingredientDesc
     ))
     } catch {
         print (error)
     }
}

func updateRecipes(recipeId : Int64, updatedRecipe : Recipe) {//query to make a change to an recipe record in DB
    do {
        let db = connectDatabase()
        
//        let inventory = Table("inventory")
//        let ingredient = Table("ingredients")

        
        //handle recipe  data
        let recipe = Table("recipe")
        
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let instructions = Expression<String>("instructions")
        let cookingTime = Expression<String>("cookingTime")
        
        let thisRecipe = recipe.filter(id == recipeId)
        
        try db.run(thisRecipe.update(
            name <- updatedRecipe.recipeName,
            instructions <- updatedRecipe.instructions,
            cookingTime <- updatedRecipe.cookingTime ))
        
        } catch {
            print (error)
        }
}


func updateRecipeLog(recipeLogId : Int64, updatedRecipeLogs : RecipeLog) {//query to make a change to an RecipeLog record in DB
    do {
        let db = connectDatabase()
        //handle recipeLog  data
        let recipeLog = Table("recipeLog")
        
        let id = Expression<Int64>("id")
        let recipeId = Expression<Int64>("recipeId")
        let createdDate = Expression<Date>("createdDate")
        
        let thisRecipeLog = recipeLog.filter(id == recipeLogId)
        
        try db.run(thisRecipeLog.update(
            recipeId <- updatedRecipeLogs.recipeID,
            createdDate <- updatedRecipeLogs.createdAtDate))
        } catch {
            print (error)
        }
}
    
func updatePreferences(preferencesId : Int64, updatedPreferences : Preference) {//query to make a change to an Preference record in DB
    do {
        let db = connectDatabase()
        //handle preferences  data
        let preferences = Table("preferences")
        let id = Expression<Int64>("id")
        let type = Expression<String>("type")
        let typeId = Expression<Int64>("typeId")
        
        let thisPreference = preferences.filter(id == preferencesId)
        
        try db.run(thisPreference.update(
            type <- updatedPreferences.type,
            typeId <- updatedPreferences.typeID ))
        
    } catch {
        print (error)
    }
}

func updateIngredient_allergy(ingredientAllergyId : Int64, updatedIngredient_allergy : Ingred_Allergy) {//query to make a change to an Ingred_Allergy record in DB
    do {
        let db = connectDatabase()
        //handle ingredient_allergy  data
        let ingredient_allergy = Table("ingredient_allergy")
        
        let id = Expression<Int64>("id")
        let ingredId = Expression<Int64>("ingredId")
        let allergyId = Expression<Int64>("allergyId")
        
        let thisIngredient_Allergy = ingredient_allergy.filter(id == ingredientAllergyId)
        
        try db.run(thisIngredient_Allergy.update(
            //id <- newIngredient_allergy.ingred_AllergyID
            ingredId <- updatedIngredient_allergy.ingredID,
            allergyId <- updatedIngredient_allergy.allergyID ))
        
    } catch {
        print (error)
    }
}

func updateRecipe_ingredient(recipeIngredientId : Int64, updatedRecipe_ingredient : Recipe_Ingred) {//query to make a change to an Recipe_Ingred record in DB
    do {
        let db = connectDatabase()
        //handle recipe_ingredient  data
        let recipe_ingredient = Table("recipe_ingredient")
        
        let id = Expression<Int64>("id")
        let recipeId = Expression<Int64>("recipeId")
        let ingredId = Expression<Int64>("ingredId")
        
        let thisRecipe_Ingredient = recipe_ingredient.filter(id == recipeIngredientId)
        
        try db.run(thisRecipe_Ingredient.update(
            //id <- newRecipe_ingredient.recipe_IngredientID
            recipeId <- updatedRecipe_ingredient.recipeID,
            ingredId <- updatedRecipe_ingredient.ingredID ))
    } catch {
        print (error)
    }
}

func updateRecipe_diet(recipeDietId : Int64, updatedRecipe_diet : Recipe_Diet) {//query to make a change to an Recipe_Diet record in DB
    do {
        let db = connectDatabase()
        //handle recipe_diet  data
        let recipe_diet = Table("recipe_diet")
        
        let id = Expression<Int64>("id")
        let recipeId = Expression<Int64>("recipeId")
        let ingredId = Expression<Int64>("ingredId")
        
        let thisRecipe_Diet = recipe_diet.filter(id == recipeDietId)
        
        try db.run(thisRecipe_Diet.update(
            //id <- newRecipe_diet.recipe_DietID
            recipeId <- updatedRecipe_diet.recipeID,
            ingredId <- updatedRecipe_diet.dietID ))
        
    } catch {
        print (error)
    }
}

func updateSection(sectionId : Int64, updatedSection : SectionOfPantry) {//query to make a change to an SectionOfPantry record in DB
    do {
        let db = connectDatabase()
        //handle sections  data
        let sections = Table("section")
        
        let id = Expression<Int64>("id")
        let desc = Expression<String>("desc")
        let ingredId = Expression<Int64>("ingredId")
        
        let thisSection = sections.filter(id == sectionId)
        
        try db.run(thisSection.update(
            //id <- newSection.sectionID
            desc <- updatedSection.section,
            ingredId <- updatedSection.appPantryID ))
        } catch {
            print (error)
        }
}
