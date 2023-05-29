//
//  DB_action.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 28/5/2023.
//

import Foundation
import SQLite
import SQLite3
import CoreXLSX

func insertNewAllergy(newAllergy : AllergyCategory) {
    do {
        let db = connectDatabase()
        //handle allergy  data
        let allergy = Table("allergyCategory")
        
        //let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
        try db.run(allergy.insert(
            //id <- newAllergy.allergyCategoryID
            name <- newAllergy.allergyCategName,
            desc <- newAllergy.allergyCategdescription ))
    } catch {
        print (error)
    }
}

func insertNewDietCat(newDiet : DietCategory) {
    do {
        let db = connectDatabase()
        //handle dietCat  data
        let dietCat = Table("dietCategory")
        //let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
        
        try db.run(dietCat.insert(
            //id <- newDiet.dietCategoryID
            name <- newDiet.dietCategName,
            desc <- newDiet.dietCategdescription ))
    } catch {
        print (error)
    }
}

func insertNewFoodCat(newFoodCat : FoodCategory) {
    do {
        let db = connectDatabase()
        //handle foodCat  data
        let foodCat = Table("foodCategory")
        
        //let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
        
        try db.run(foodCat.insert(
            //id <- newFoodCat.foodCategoryID
            name <- newFoodCat.foodCategName,
            desc <- newFoodCat.foodCategdescription))
    } catch {
        print (error)
    }
}

func doesCategoryExist(newFoodCat : FoodCategory) -> Bool {
    let db = connectDatabase()
    do {
        for _ in try db.prepare("SELECT * from foodCategory WHERE name = ?", newFoodCat.getFoodCategName()){
            return true
        }
        return false
    } catch {
        print(error)
        return true
        
    }
}

func insertNewIngredient(newIngredient : Ingredient) {
    do {
        let db = connectDatabase()
        //handle ingredients  data
        let ingredients = Table("ingredients")
        
//        let id = Expression<Int64>("id")
        //let foodCatId = Expression<Int64>("foodCatId")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
        try db.run(ingredients.insert(
            //id <- newIngredient.ingredientID
            //foodCatId <- newIngredient.foodCategoryID,
            name <- newIngredient.ingredName,
            desc <- newIngredient.ingredDescription))
    } catch {
        print (error)
    }
}

func insertNewInventory(newPantryItem : AppPantryItem) {
 do {
     let db = connectDatabase()
     //handle Inventory  data
     let Inventory = Table("inventory")

//     let id = Expression<Int64>("id")
     let ingredientID = Expression<Int64>("ingredientID")
     let quantity = Expression<Int64>("quantity")
     let expiryDate = Expression<Date>("expiryDate")
     let name = Expression<String>("name")
     let desc = Expression<String>("desc")
//     var ingredientName: String
     //var ingredientDesc: String
     //let shoppingList = Expression<Bool>("shoppingList")
     
     try db.run(Inventory.insert(
//     id <- newPantryItem.appPantryID,
     ingredientID <- newPantryItem.ingredientID,
     quantity <- newPantryItem.quantity,
     expiryDate <- newPantryItem.expiryDate,
    name <- newPantryItem.ingredientName,
     desc <- newPantryItem.ingredientDesc
//     shoppingList <- newPantryItem.shoppingList
            ))
     } catch {
         print (error)
     }
}

func insertNewRecipe(newRecipe : Recipe) {
 do {
     let db = connectDatabase()
     //handle recipe data
     let recipe = Table("recipes")

     print(newRecipe)
//     let id = Expression<Int64>("id")
     let name = Expression<String>("name")
     let instructions = Expression<String>("instructions")
     let cookingTime = Expression<String>("cookingTime")
     let complexity = Expression<Int64>("complexity")
     

     try db.run(recipe.insert(
     //id <- newRecipe.recipeID
     name <- newRecipe.recipeName,
     instructions <- newRecipe.instructions,
     cookingTime <- newRecipe.cookingTime,
     complexity <- newRecipe.complexity))
     } catch {
         print (error)
     }
}


func insertNewRecipeLog(newRecipeLogs : RecipeLog) {
    do {
        let db = connectDatabase()
        //handle recipeLog  data
        let recipeLog = Table("recipeLog")
        
//        let id = Expression<Int64>("id")
        let recipeId = Expression<Int64>("recipeId")
        let createdDate = Expression<Date>("createdDate")
        
        try db.run(recipeLog.insert(
            //id <- newRecipeLogs.recipeLogID
            recipeId <- newRecipeLogs.recipeID,
            createdDate <- newRecipeLogs.createdAtDate))
        
    } catch {
        print (error)
    }
}
func insertNewPreferences(newPreferences : Preference) {
    do {
        let db = connectDatabase()
        //handle preferences  data
        let preferences = Table("preferences")
//        let id = Expression<Int64>("id")
        let type = Expression<String>("type")
        let typeId = Expression<Int64>("typeId")
        
        
        try db.run(preferences.insert(
            //id <- newPreferences.preferenceID
            type <- newPreferences.type,
            typeId <- newPreferences.typeID ))
        
    } catch {
        print (error)
    }
}

func insertNewIngredient_allergy(newIngredient_allergy : Ingred_Allergy) {
    do {
        let db = connectDatabase()
        //handle ingredient_allergy  data
        let ingredient_allergy = Table("ingredient_allergy")
        
//        let id = Expression<Int64>("id")
        let ingredId = Expression<Int64>("ingredId")
        let allergyId = Expression<Int64>("allergyId")
        
        try db.run(ingredient_allergy.insert(
            //id <- newIngredient_allergy.ingred_AllergyID
            ingredId <- newIngredient_allergy.ingredID,
            allergyId <- newIngredient_allergy.allergyID ))
        
    } catch {
        print (error)
    }
}

func insertNewRecipe_ingredient(newRecipe_ingredient : Recipe_Ingred) {
    do {
        let db = connectDatabase()
        //handle recipe_ingredient  data
        let recipe_ingredient = Table("recipe_ingredient")
        
//        let id = Expression<Int64>("id")
        let recipeId = Expression<Int64>("recipeId")
        let ingredId = Expression<Int64>("ingredId")
        
        try db.run(recipe_ingredient.insert(
            //id <- newRecipe_ingredient.recipe_IngredientID
            recipeId <- newRecipe_ingredient.recipeID,
            ingredId <- newRecipe_ingredient.ingredID ))
    } catch {
        print (error)
    }
}

func insertNewRecipe_diet(newRecipe_diet : Recipe_Diet) {
    do {
        let db = connectDatabase()
        //handle recipe_diet  data
        let recipe_diet = Table("recipe_diet")
        
//        let id = Expression<Int64>("id")
        let recipeId = Expression<Int64>("recipeId")
        let ingredId = Expression<Int64>("ingredId")
        
        try db.run(recipe_diet.insert(
            //id <- newRecipe_diet.recipe_DietID
            recipeId <- newRecipe_diet.recipeID,
            ingredId <- newRecipe_diet.dietID ))
        
    } catch {
        print (error)
    }
}

func insertNewSection(newSection : SectionOfPantry) {
    do {
        let db = connectDatabase()
        //handle sections  data
        let sections = Table("section")
        
//        let id = Expression<Int64>("id")
        let desc = Expression<String>("desc")
        let ingredId = Expression<Int64>("ingredId")
        
        try db.run(sections.insert(
            //id <- newSection.sectionID
            desc <- newSection.section,
            ingredId <- newSection.appPantryID ))
    } catch {
        print (error)
    }
}

func newInventoryItem(name: String, description: String, quantity: Int64, expiryDate: Date, shoppingList: Bool, storageId: Int64){
    do{
        let db = connectDatabase()
        
        let inventory = Table("inventory")
        let ingredient = Table("ingredients")
        let dbid = Expression<Int64>("id")
        let dbname = Expression<String>("name")
        let dbdesc = Expression<String>("desc")
        let dbquantity = Expression<Int64>("quantity")
        let dbexpiryDate = Expression<Date>("expiryDate")
        let dbingredientId = Expression<Int64>("ingredientId")
        let dbshoppingList = Expression<Bool>("shoppingList")
        let dbstorageId = Expression<Int64>("storageId")
        var ingredientId:Int64 = 0
        
        try db.run(ingredient.insert(
        dbname <- name,
        dbdesc <- description))
    
        for ingredient in try db.prepare(ingredient.order(dbid.desc).limit(1)){
            ingredientId = ingredient[dbid]
        }
        
        try db.run(inventory.insert(
        dbquantity <- quantity,
        dbexpiryDate <- expiryDate,
        dbingredientId <- ingredientId,
        dbshoppingList <- shoppingList,
        dbstorageId <- storageId
        ))
        
        print("Item added")
        
    } catch {
        print(error)
    }
}


func readInventoryTableForShoppingList() -> [AppPantryItem]{
    var items = [AppPantryItem]()
    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
    
        let inventory = Table("inventory")
        let ingredient = Table("ingredients")
        let id = Expression<Int64>("id")
        let quantity = Expression<Int64>("quantity")
        let expiryDate = Expression<Date>("expiryDate")
        let ingredientId = Expression<Int64>("ingredientId")
        let shoppingList = Expression<Bool>("shoppingList")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
        let innerJoin = inventory.join(.inner, ingredient, on: inventory[ingredientId] == ingredient[id])
        
        for innerJoin in try db.prepare(innerJoin.where(inventory[shoppingList] == true)) {
            items.append(AppPantryItem(appPantryID: innerJoin[inventory[id]], ingredientID: innerJoin[ingredient[id]], ingredientName: innerJoin[ingredient[name]], ingredientDesc: innerJoin[ingredient[desc]], quantity: innerJoin[inventory[quantity]], expiryDate: innerJoin[inventory[expiryDate]])!)
        }
    } catch {
        print (error)
    }
    return items
}

func readInventoryTableForInventory(storageId: Int64) -> [AppPantryItem]{
    var items = [AppPantryItem]()
    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
    
        let inventory = Table("inventory")
        let ingredient = Table("ingredients")
        let id = Expression<Int64>("id")
        let quantity = Expression<Int64>("quantity")
        let expiryDate = Expression<Date>("expiryDate")
        let ingredientId = Expression<Int64>("ingredientId")
        let shoppingList = Expression<Bool>("shoppingList")
        let dbstorageId = Expression<Int64>("storageId")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
        let innerJoin = inventory.join(.inner, ingredient, on: inventory[ingredientId] == ingredient[id])
        
        for innerJoin in try db.prepare(innerJoin.where(inventory[shoppingList] == false).where(inventory[dbstorageId] == storageId)) {
            items.append(AppPantryItem(appPantryID: innerJoin[inventory[id]], ingredientID: innerJoin[ingredient[id]], ingredientName: innerJoin[ingredient[name]], ingredientDesc: innerJoin[ingredient[desc]], quantity: innerJoin[inventory[quantity]], expiryDate: innerJoin[inventory[expiryDate]])!)
        }
    } catch {
        print (error)
    }
    return items
}

func buyShoppingList(){
    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
    
        let inventory = Table("inventory")
        let shoppingList = Expression<Bool>("shoppingList")

        try db.run(inventory.where(shoppingList == true).update(shoppingList <- false))
    } catch {
        print (error)
    }
}

func readRecipes() -> [Recipe]{
    var recipes = [Recipe]()
    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
    
        let recipe = Table("recipes")
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let instructions = Expression<String>("instructions")
        let cookingTime = Expression<String>("cookingTime")
        let complexity = Expression<Int64>("complexity")

        for recipe in try db.prepare(recipe) {
                print("id: \(recipe[id]), name: \(recipe[name]), instructions: \(recipe[instructions]), cookingTime: \(recipe[cookingTime]), complexity: \(recipe[complexity])")
            recipes.append(Recipe(recipeID: recipe[id], recipeName: recipe[name], instructions: recipe[instructions], cookingTime: recipe[cookingTime], complexity: recipe[complexity])!)
        }
    } catch {
        print (error)
    }
    return recipes
}


func readStorage() -> [String]{
    var places = [String]()
    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
        
        let storage = Table("storage")
        let description = Expression<String>("desc")
        
        for storage in  try db.prepare(storage){
            places.append(storage[description])
        }
    } catch {
        print (error)
    }
    return places
}

func readIngredients() -> [Ingredient]{
    var ingredients = [Ingredient]()
    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
    
        let ingredientsTable = Table("ingredients")
        let id = Expression<Int64>("id")
        //let foodCategoryID = Expression<Int64?>("foodCatId")
        let ingredName = Expression<String>("name")
        let ingredDescription = Expression<String>("desc")
        //let allergyCategoryId = Expression<Int64?>("allergies")

        //let innerJoin = recipes.join(.inner, ingredient, on: inventory[ingredientId] == ingredient[id])
        for ingredient in try db.prepare(ingredientsTable) {

            ingredients.append(Ingredient(ingredientID: (ingredient[id]),/* foodCategoryID: ingredient[foodCategoryID]!,*/ ingredName: ingredient[ingredName], ingredDescription: ingredient[ingredDescription])!)
        }
    } catch {
        print (error)
    }
    return ingredients
}


func readRecipe_Ingredient(recipeId: Int64) -> [Ingredient]{
    var ingredients = [Ingredient]()
    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
    
        let recipe_ingredientTable = Table("recipe_ingredient")
        let ingredientsTable = Table("ingredients")
        let recipeId = Expression<Int64>("recipeId")
        let ingredId = Expression<Int64>("ingredId")
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        //let allergies = Expression<Int64?>("allergies")


        let innerJoin = ingredientsTable.join(.inner, recipe_ingredientTable, on: recipe_ingredientTable[ingredId] == ingredientsTable[id])
        
        for innerJoin in try db.prepare(innerJoin.where(ingredientsTable[id] == ingredId)) {
            ingredients.append(Ingredient(ingredientID: innerJoin[ingredientsTable[id]], ingredName: innerJoin[ingredientsTable[name]], ingredDescription: innerJoin[ingredientsTable[desc]])!)
        }

    } catch {
        print (error)
    }
    return ingredients
}

func readInventoryFromId(id: Int64) -> AppPantryItem?{
    var item:AppPantryItem?
    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
        
        let inventory = Table("inventory")
        let ingredient = Table("ingredients")
        let dbid = Expression<Int64>("id")
        let quantity = Expression<Int64>("quantity")
        let expiryDate = Expression<Date>("expiryDate")
        let ingredientId = Expression<Int64>("ingredientId")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
        let innerJoin = inventory.join(.inner, ingredient, on: inventory[ingredientId] == ingredient[dbid])
        
        for innerJoin in  try db.prepare(innerJoin.where(inventory[dbid] == id)){
            item = AppPantryItem(appPantryID: innerJoin[inventory[dbid]], ingredientID: innerJoin[ingredient[dbid]], ingredientName: innerJoin[ingredient[name]], ingredientDesc: innerJoin[ingredient[desc]], quantity: innerJoin[inventory[quantity]], expiryDate: innerJoin[inventory[expiryDate]])!
        }
    } catch {
        print (error)
    }
    return item
}

func deleteInventoryItem(id: Int64){
    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
        
        let inventory = Table("inventory")
        let dbid = Expression<Int64>("id")
        
        let thisInventory = inventory.filter(dbid == id)
        
        try db.run(thisInventory.delete())
        
    } catch {
        print (error)
    }
}
