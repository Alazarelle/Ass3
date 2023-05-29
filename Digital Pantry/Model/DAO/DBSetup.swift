//
//  DBSetup.swift
//  Digital Pantry
//
//  Created by Isabelle Leggat on 23/5/2023.
//

import Foundation
import SQLite
import CoreXLSX

func connectDatabase()->Connection{
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    return try! Connection("\(path)/db.sqlite3")
}

func createTables() {
    //wrap
    do {
        let db = connectDatabase()
        
        try db.execute("DROP TABLE if exists recipes")
        try db.execute("DROP TABLE if exists ingredients")
        try db.execute("DROP TABLE if exists allergyCategory")
        try db.execute("DROP TABLE if exists dietCategory")
        try db.execute("DROP TABLE if exists inventory")
        try db.execute("DROP TABLE if exists ingredients")
        try db.execute("DROP TABLE if exists foodCategory")

        //recipes
        let recipes = Table("recipes")
        try db.run(recipes.create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<String>("name"))
            t.column(Expression<String>("instructions"))
            //t.column(Expression<String>("ingredients"))//,references: ingredients, id) //will link to another table as ForeignKey
            //t.column(Expression<String?>("diets"))//,references: ingredients, id)) //will link to another table as ForeignKey
            t.column(Expression<String>("cookingTime"))
            t.column(Expression<Int64>("complexity"))
        })
        
        //ingredients
        try db.run(Table("ingredients").create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<String>("name"))
            t.column(Expression<String>("desc"))
            //t.column(Expression<Int64?>("foodCatId"), references: Table("foodCategory"), Expression<Int64>("id"))
            t.column(Expression<Int64?>("allergies"),references: Table("allergyCategory"), Expression<Int64>("id"))
        })
        
        //inventory
        try db.run(Table("inventory").create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<Int64>("quantity"))
            t.column(Expression<Date>("expiryDate"))
            t.column(Expression<Int64>("ingredientId"),references: Table("ingredients"), Expression<Int64>("id"))
            t.column(Expression<Bool>("shoppingList"))
            t.column(Expression<Int64>("storageId"),references: Table("storage"), Expression<Int64>("id"))
        })
        
        //storage
        
        try db.run(Table("storage").create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<String>("desc"))
        })
        
        //allergy
        try db.run(Table("allergyCategory").create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<String>("name"))
            t.column(Expression<String>("desc"))
        })
        
        //ingredient_allergy
        try db.run(Table("ingredient_allergy").create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<Int64>("ingredId"))
            t.column(Expression<Int64>("allergyId"))
        })
        
        //diet
        try db.run(Table("dietCategory").create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<String>("name"))
            t.column(Expression<String>("desc"))
        })
        
        //recipe_ingredient
        try db.run(Table("recipe_ingredient").create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<Int64>("recipeId"))
            t.column(Expression<Int64>("ingredId"))
        })
        
        //recipe_diet
        try db.run(Table("recipe_diet").create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<Int64>("recipeId"))
            t.column(Expression<Int64>("dietId"))
        })

        
        //recipeLog
        try db.run(Table("recipeLog").create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<Int64>("recipeID"),references: Table("recipes"), Expression<Int64>("id"))
            t.column(Expression<Date>("createdDate"))
        })
        
        //preferences
        try db.run(Table("preferences").create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<String>("type"))
            t.column(Expression<Int64?>("allergyId"),references: Table("allergyCategory"), Expression<Int64>("id"))
            t.column(Expression<Int64?>("dietId"),references: Table("dietCategory"), Expression<Int64>("id"))
        })
        
        //section (Pantry, Fridge or Freezer, if we decide to use)
        try db.run(Table("section").create(ifNotExists: true) { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<String>("desc"))
            t.column(Expression<Int64>("inventoryId")) //AppPantry
        })
        

    } catch {
        print (error)
    }
}

func insertTableData() {
    //wrap
    do {
        let db = connectDatabase()
        
        //Allergy data
        let allergy = Table("allergyCategory")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
        var count = try db.scalar(allergy.count)
        if (count == 0) {
            try db.run(allergy.insert(
                name <- "Peanut Allergy",
                desc <- "Suitable for people suffering from a peanut allergy. Recipes and ingredients containing peanuts or traces of peanuts will be omitted from your recipe searches"))
            
            try db.run(allergy.insert(
                name <- "Tree Nut Allergy",
                desc <- "People suffering from a tree nut allergy are typically allergic to most non-legume nuts (such as Hazelnut, Walnut, Almond, and Macadamia. Recipes and products containing nuts will be omitted from your recipe searches"))
            
            try db.run(allergy.insert(
                name <- "Shellfish Allergy",
                desc <- "People suffering from a shellfish allergy are typically allergic to molluscs, crustaceans, and cephlopods (such as Crab, Lobster, Oyster, and Octopus). Recipes and products containing shellfish will be omitted from your recipe searches"))
            
            try db.run(allergy.insert(
                name <- "Fish Allergy",
                desc <- "Suitable for people suffering from a fish allergy. Recipes and products containing fish will be omitted from your recipe searches"))
            
            try db.run(allergy.insert(
                name <- "Milk Allergy",
                desc <- "Suitable for people suffering from a milk allergy. Recipes and products containing cow milk will be omitted from your recipe searches"))
            
            try db.run(allergy.insert(
                name <- "Egg Allergy",
                desc <- "Suitable for people suffering from an egg allergy. Recipes and products containing eggs will be omitted from your recipe searches"))
            
            try db.run(allergy.insert(
                name <- "Soy Allergy",
                desc <- "Suitable for people suffering from a soybean allergy. Recipes and products containing soy will be omitted from your recipe searches"))
            
            try db.run(allergy.insert(
                name <- "Wheat Allergy",
                desc <- "Suitable for people suffering from a wheat allergy. Recipes and products containing wheat will be omitted from your recipe searches"))
            
            try db.run(allergy.insert(
                name <- "Sesame Allergy",
                desc <- "Suitable for people suffering from a sesame seed allergy. Recipes and products containing sesame will be omitted from your recipe searches"))
        }
        
        //Diet data
        let diet = Table("dietCategory")
        count = try db.scalar(diet.count)
        if (count == 0) {
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Vegan",
                dietCategdescription:  "People following a vegan diet typically abstain from consuming animal and animal by-products in their diet. A vegan diet excludes meat, fish, eggs, dairy, honey,  gelatine and other animal products and by-products. Recipes and products containing animal products and by-products will be excluded from your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Vegetarian (Ovo-Lacto)",
                 dietCategdescription:  "People following an ovo-lacto vegetarian diet typically abstain from consuming animal meat in their diet, but do consume animal products (such as egg, dairy, and honey). This diet excludes meat, fish and  gelatine, but includes eggs, dairy, honey, and other animal products. Recipes and products containing meat products will be excluded from your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Ovo-Vegetarian",
                 dietCategdescription:  "People following a lacto-vegetarian diet abstain from consuming animal meat and egg products in their diet, but do consume dairy products (such as milk, yoghurt, butter, and cheese). This diet excludes ingredients and recipes containing meat, fish,  gelatine, and egg. Recipes and products containing these will be excluded from your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Lacto-Vegetarian",
                 dietCategdescription:  "People following a lacto-vegetarian diet abstain from consuming animal meat and egg products in their diet, but do consume dairy products (such as milk, yoghurt, butter, and cheese). This diet excludes ingredients and recipes containing meat, fish,  gelatine, and egg. Recipes and products containing these will be excluded from your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Pescatarian",
                 dietCategdescription:  "People following a pescatarian diet typically incorporate seafood (such as fish and shellfish) into an otherwise vegetarian diet. This diet excludes meat and meat products except for seafood. Recipes and products containing these will be excluded from your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Flexatarian",
                 dietCategdescription:  "People following a flexitarian diet follow a mostly vegetarian diet, but occasionally consume animal meat and animal products from time to time.  Vegetarian and vegan recipes and products will be prioritised in your recipes, but recipes and products containing meat, fish and animal products will not be excluded from your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Keto",
                 dietCategdescription:  "People following a keto (ketogenic) diet consume foods high in fat and low in carbohydrate’s, causing the body to burn fats rather than carbohydrates for energy.  For this reason, it is often followed by people who undertake intermittent fasting to lose weight.  Recipes and products that are high in unsaturated fats and low in carbohydrates will be prioritised in your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Paleo",
                 dietCategdescription:  "People following a paleo (Paleogenic) diet typically consume whole foods and unprocessed foods. This diet attempts to allow the follower to only consume foods thought to have been able to have been consumed by hunter-gatherer humans during the Palaeolithic Era. This diet therefore excludes dairy, grains, legumes, and all processed foods (such as prepared meals, processed sugar, and alcohol). Recipes and products containing these will be excluded from your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Raw",
                 dietCategdescription:  "People following a raw food diet typically only consume foods that are uncooked and unprocessed. This diet focuses on consuming fruit, vegetables, some fermented foods (such as kimchi and yoghurt) and some meats that can be eaten raw (such as sashimi) and excludes processed foods and most processed dairy. Recipes and products containing these will be excluded from your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "No Sugar",
                 dietCategdescription:  "This diet primarily involves avoiding the consumption of processed carbohydrates, especially raw and processed sugar. Recipes and products containing processed sugar will be excluded from your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Low Fat",
                 dietCategdescription:  "This diet primarily involves minimising the consumption of saturated fats, especially in regard to processed and deep-fried foods. Recipes and products containing high amounts of saturated fats will be excluded from your recipes, and recipes and products containing low amounts will be prioritised in your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Kosher",
                 dietCategdescription:  "People following a Kosher diet typically must separate meat(except fish) from dairy products and not eat particular meat. This diet attempts to follow the dietary laws within the Torah, of the Jewish faith. This diet therefore avoids pork, shellfish, shrimps, particular animal products or by-products and separates meat from dairy products. Recipes and products containing these will be excluded from your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Halal",
                 dietCategdescription:  "People following a Halal diet typically must not eat pig (or pig by-products) or drink alcohol. This diet attempts to follow the dietary laws within the Qu’ran, of the Muslim faith. This diet avoids pig and pig by-products like animal blood, animal fats,  gelatine and alcohol. Recipes and products containing these will be excluded from your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Gluten Free (Coeliac)", dietCategdescription: "Most commonly followed by people suffering from Coeliac disease, this diet focuses on excluding foods containing gluten, such as wheat, barley and oats (such as bread and flour). This diet is also sometimes followed to reduce the symptoms of irritable bowel syndrome (IBS). Recipes and products containing gluten will be omitted from your recipe searches.")!)
            
            insertNewDietCat(newDiet: DietCategory(dietCategName: "Low FODMAP", dietCategdescription: "People following a Low FODMAP diet attempt to eliminate fermentable carbohydrates (FODMAPs) from their diets. This is usually followed by people attempting to reduce the symptoms of irritable bowel syndrome (IBS). This diet focusses on excluding foods high in fructans, fructose, and lactose (such as Apples, Onions, Fruit Juice, Milk, Soft Cheeses, and stone fruits among others). Recipes and products containing these will be excluded from your recipe searches.")!)
        }
        
        let storage = Table("storage")
        
        count = try db.scalar(storage.count)
        if (count == 0) {
            try db.run(storage.insert(
                desc <- "Pantry"))
            
            try db.run(storage.insert(
                desc <- "Fridge"))
            
            try db.run(storage.insert(
                desc <- "Freezer"))
        }
    } catch {
        print (error)
    }
}

func readMajorTables(){
    do {
        let db = connectDatabase()

        let allergy = Table("allergyCategory")
        let diet = Table("dietCategory")
        let foods = Table("ingredients")
        //let categories = Table("foodCategory")
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")

        print("Allergy Category:")
        for allergy in try db.prepare(allergy) {
                print("id: \(allergy[id]), name: \(allergy[name]), desc: \(allergy[desc])")
        }

        print("Diet Category:")
        for diet in try db.prepare(diet) {
                print("id: \(diet[id]), name: \(diet[name]), desc: \(diet[desc])")
        }
        
        print("Ingredients:")
        for food in try db.prepare(foods) {
                print("id: \(food[id]), name: \(food[name]), desc: \(food[desc])")
        }
        
        //print("Food Categories:")
        //for cat in try db.prepare(categories) {
        //        print("id: \(cat[id]), name: \(cat[name]), desc: \(cat[desc])")
        //}
    } catch {
        print (error)
    }
}


func importFoodDataCSV(){
    do {
        let db = connectDatabase()
        //let foodCat = Table("foodCategory")
        //let count = try db.scalar(foodCat.count)
        if (/*count == 0*/ true) {
            let path = Bundle.main.path(forResource: "IngredientsAndCategories", ofType: "xlsx") ?? "none"
            print(path)
            
            guard let file = XLSXFile(filepath: path) else {
                fatalError("XLSX file corrupted or does not exist")
            }
            let paths = try file.parseWorksheetPaths()
            let worksheet = try file.parseWorksheet(at: paths.first!)
            let sharedStrings = try file.parseSharedStrings()
            for row in worksheet.data?.rows ?? [] {
                //Add Category unless existing one
                //var category = ""
                var ingredient = ""
                var desc = ""
                for c in row.cells {
                    let ref = Int(c.value ?? "") ?? 0
                    //              Ingredient
                    if (ref < 1617) {
                        guard let ing = c.stringValue(sharedStrings!) else {return}
                        ingredient = ing
                        //              Category
                    } //else if (ref >= 1617 && ref < 1907) {
                        //guard let cat = c.stringValue(sharedStrings!) else {return}
                        //category = cat
                        //              Description
                    //}
                    else if (ref >= 1907) {
                        guard let d = c.stringValue(sharedStrings!) else {return}
                        desc = d
                    }
                    var fk:Int64 = 0
                    if (/*category != "" && */ingredient != "" && desc != "") {
                        //let newFoodCat = FoodCategory(foodCategName: category, foodCategdescription: category)!
                        //if (doesCategoryExist(newFoodCat: newFoodCat) == false){
                        //    insertNewFoodCat(newFoodCat: newFoodCat)
                        //}
                        /*do {
                            for cat in try db.prepare(foodCat.order( Expression<Int64>("id").desc).limit(1)){
                                fk = cat[ Expression<Int64>("id")]
                            }
                        }*/
                        //check for allergies
                        insertNewIngredient(newIngredient: Ingredient(ingredName: ingredient, /*foodCategoryID: fk,*/ ingredDescription: desc)!)
                        if (/*category.contains("peanut") ||*/ desc.contains("peanut")){
                            insertNewIngredient_allergy(newIngredient_allergy : Ingred_Allergy(ingredID: fk, allergyID: 1)!)
                        }
                        if (/*category.contains(" nut") ||*/ desc.contains(" nut")){
                            insertNewIngredient_allergy(newIngredient_allergy : Ingred_Allergy(ingredID: fk, allergyID: 2)!)
                        }
                        if (/*category.contains("Crustacea") ||*/ /*category.contains("Molluscs")*/false){
                            insertNewIngredient_allergy(newIngredient_allergy : Ingred_Allergy(ingredID: fk, allergyID: 3)!)
                        }
                        if (ingredient.contains("fish") /*|| category.contains("fish")*/){
                            insertNewIngredient_allergy(newIngredient_allergy : Ingred_Allergy(ingredID: fk, allergyID: 4)!)
                        }
                        if (desc.contains("cows milk") || desc.contains("cows skim milk")){
                            insertNewIngredient_allergy(newIngredient_allergy : Ingred_Allergy(ingredID: fk, allergyID: 5)!)
                        }
                        if (/*category.contains("egg") ||*/ desc.contains("egg")){
                            insertNewIngredient_allergy(newIngredient_allergy : Ingred_Allergy(ingredID: fk, allergyID: 6)!)
                        }
                        if (desc.contains("soy")){
                            insertNewIngredient_allergy(newIngredient_allergy : Ingred_Allergy(ingredID: fk, allergyID: 7)!)
                        }
                        if (desc.contains("wheat")){
                            insertNewIngredient_allergy(newIngredient_allergy : Ingred_Allergy(ingredID: fk, allergyID: 8)!)
                        }
                        if (desc.contains("sesame")){
                            insertNewIngredient_allergy(newIngredient_allergy : Ingred_Allergy(ingredID: fk, allergyID: 9)!)
                        }
                    }
                }
            }
        }
     } catch {
         print (error)
     }
}

