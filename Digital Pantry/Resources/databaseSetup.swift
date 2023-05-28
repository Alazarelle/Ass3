//
//  databaseSetup.swift
//  Digital Pantry
//
//  Created by Isabelle Leggat on 23/5/2023.
//

import Foundation
import SQLite
import CoreXLSX

func createTables() {
    //wrap
    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
        try db.execute("DROP TABLE ingredients")
        try db.execute("DROP TABLE inventory")
        
        //ingredients
        try db.run(Table("ingredients").create { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<String>("name"))
            t.column(Expression<String>("desc"))
//            t.column(Expression<Int64>("categoryId"),references: foodCat, id)
            t.column(Expression<Int64?>("allergies"),references: Table("allergyCategory"), Expression<Int64>("id"))
        })
        
        //inventory
        try db.run(Table("inventory").create { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<Double>("quantity"))
            t.column(Expression<Date>("expiryDate"))
            t.column(Expression<Int64>("ingredientId"),references: Table("ingredients"), Expression<Int64>("id"))
            t.column(Expression<Bool>("shoppingList"))
        })
        
        //allergy
        try db.run(Table("allergyCategory").create { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<String>("name"))
            t.column(Expression<String>("desc"))
        })
        
        //diet
        try db.run(Table("dietCategory").create { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<String>("name"))
            t.column(Expression<String>("desc"))
        })
        
        //food category
        let foodCat = Table("foodCategory")
        try db.run(foodCat.create { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<String>("name"))
            t.column(Expression<String>("desc"))
        })
        
        
        
        
        //recipes
        let recipes = Table("recipes")
        try db.run(recipes.create { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<String>("name"))
            t.column(Expression<String>("desc"))
            t.column(Expression<String>("ingredients"))//,references: ingredients, id)
            t.column(Expression<String?>("diets"))//,references: ingredients, id))
            t.column(Expression<String>("cookingTime"))
            t.column(Expression<String>("complexity"))
        })
        
        //recipeLog
        try db.run(Table("recipeLog").create { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
//            t.column(Expression<Int64>("recipeID"),references: recipes, id)
            t.column(Expression<Date>("createdDate"))
        })
        
        //preferences
        try db.run(Table("preferences").create { t in
            t.column(Expression<Int64>("id"),primaryKey: true)
            t.column(Expression<String>("type"))
//            t.column(Expression<Int64>("typeId"),references: allergy, id)
        })

    } catch {
        print (error)
    }
}

func insertTableData() {
    //wrap
    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
        
        //Allergy data
        let allergy = Table("allergyCategory")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
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
        
        //Diet data
        let diet = Table("dietCategory")

        try db.run(diet.insert(
        name <- "Vegan",
        desc <- "People following a vegan diet typically abstain from consuming animal and animal by-products in their diet. A vegan diet excludes meat, fish, eggs, dairy, honey,  gelatine and other animal products and by-products. Recipes and products containing animal products and by-products will be excluded from your recipe searches."))
        
        try db.run(diet.insert(
        name <- "Vegetarian (Ovo-Lacto)",
        desc <- "People following an ovo-lacto vegetarian diet typically abstain from consuming animal meat in their diet, but do consume animal products (such as egg, dairy, and honey). This diet excludes meat, fish and  gelatine, but includes eggs, dairy, honey, and other animal products. Recipes and products containing meat products will be excluded from your recipe searches."))
        
        try db.run(diet.insert(
        name <- "Ovo-Vegetarian",
        desc <- "People following a lacto-vegetarian diet abstain from consuming animal meat and egg products in their diet, but do consume dairy products (such as milk, yoghurt, butter, and cheese). This diet excludes ingredients and recipes containing meat, fish,  gelatine, and egg. Recipes and products containing these will be excluded from your recipe searches."))
        
        try db.run(diet.insert(
        name <- "Lacto-Vegetarian",
        desc <- "People following a lacto-vegetarian diet abstain from consuming animal meat and egg products in their diet, but do consume dairy products (such as milk, yoghurt, butter, and cheese). This diet excludes ingredients and recipes containing meat, fish,  gelatine, and egg. Recipes and products containing these will be excluded from your recipe searches."))
        
        try db.run(diet.insert(
        name <- "Pescatarian",
        desc <- "People following a pescatarian diet typically incorporate seafood (such as fish and shellfish) into an otherwise vegetarian diet. This diet excludes meat and meat products except for seafood. Recipes and products containing these will be excluded from your recipe searches."))
        
        try db.run(diet.insert(
        name <- "Flexatarian",
        desc <- "People following a flexitarian diet follow a mostly vegetarian diet, but occasionally consume animal meat and animal products from time to time.  Vegetarian and vegan recipes and products will be prioritised in your recipes, but recipes and products containing meat, fish and animal products will not be excluded from your recipe searches."))
        
        try db.run(diet.insert(
        name <- "Keto",
        desc <- "People following a keto (ketogenic) diet consume foods high in fat and low in carbohydrate’s, causing the body to burn fats rather than carbohydrates for energy.  For this reason, it is often followed by people who undertake intermittent fasting to lose weight.  Recipes and products that are high in unsaturated fats and low in carbohydrates will be prioritised in your recipe searches."))
        
        try db.run(diet.insert(
        name <- "Paleo",
        desc <- "People following a paleo (Paleogenic) diet typically consume whole foods and unprocessed foods. This diet attempts to allow the follower to only consume foods thought to have been able to have been consumed by hunter-gatherer humans during the Palaeolithic Era. This diet therefore excludes dairy, grains, legumes, and all processed foods (such as prepared meals, processed sugar, and alcohol). Recipes and products containing these will be excluded from your recipe searches."))
        
        try db.run(diet.insert(
        name <- "Raw",
        desc <- "People following a raw food diet typically only consume foods that are uncooked and unprocessed. This diet focuses on consuming fruit, vegetables, some fermented foods (such as kimchi and yoghurt) and some meats that can be eaten raw (such as sashimi) and excludes processed foods and most processed dairy. Recipes and products containing these will be excluded from your recipe searches."))
        
        try db.run(diet.insert(
        name <- "No Sugar",
        desc <- "This diet primarily involves avoiding the consumption of processed carbohydrates, especially raw and processed sugar. Recipes and products containing processed sugar will be excluded from your recipe searches."))
        
        
        
        try db.run(diet.insert(
        name <- "Low Fat",
        desc <- "This diet primarily involves minimising the consumption of saturated fats, especially in regard to processed and deep-fried foods. Recipes and products containing high amounts of saturated fats will be excluded from your recipes, and recipes and products containing low amounts will be prioritised in your recipe searches."))
        
        try db.run(diet.insert(
        name <- "Kosher",
        desc <- "People following a Kosher diet typically must separate meat(except fish) from dairy products and not eat particular meat. This diet attempts to follow the dietary laws within the Torah, of the Jewish faith. This diet therefore avoids pork, shellfish, shrimps, particular animal products or by-products and separates meat from dairy products. Recipes and products containing these will be excluded from your recipe searches."))
        
        try db.run(diet.insert(
        name <- "Halal",
        desc <- "People following a Halal diet typically must not eat pig (or pig by-products) or drink alcohol. This diet attempts to follow the dietary laws within the Qu’ran, of the Muslim faith. This diet avoids pig and pig by-products like animal blood, animal fats,  gelatine and alcohol. Recipes and products containing these will be excluded from your recipe searches."))
        
        try db.run(diet.insert(
        name <- "Gluten Free (Coeliac)",
        desc <- "Most commonly followed by people suffering from Coeliac disease, this diet focuses on excluding foods containing gluten, such as wheat, barley and oats (such as bread and flour). This diet is also sometimes followed to reduce the symptoms of irritable bowel syndrome (IBS). Recipes and products containing gluten will be omitted from your recipe searches."))
        
        try db.run(diet.insert(
        name <- "Low FODMAP",
        desc <- "People following a Low FODMAP diet attempt to eliminate fermentable carbohydrates (FODMAPs) from their diets. This is usually followed by people attempting to reduce the symptoms of irritable bowel syndrome (IBS). This diet focusses on excluding foods high in fructans, fructose, and lactose (such as Apples, Onions, Fruit Juice, Milk, Soft Cheeses, and stone fruits among others). Recipes and products containing these will be excluded from your recipe searches."))
    } catch {
        print (error)
    }
}

func readAllergyTable(){
    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
    
        let allergy = Table("allergyCategory")
        let diet = Table("dietCategory")
        let id = Expression<Int64>("id")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
        print("Allergy Catgeory:")
        for allergy in try db.prepare(allergy) {
                print("id: \(allergy[id]), name: \(allergy[name]), desc: \(allergy[desc])")
        }
        
        print("Diet Catgeory:")
        for diet in try db.prepare(diet) {
                print("id: \(diet[id]), name: \(diet[name]), desc: \(diet[desc])")
        }
    } catch {
        print (error)
    }
}

func newInventoryItem(name: String, description: String, quantity: Double, expiryDate: Date, shoppingList: Bool){
    do{
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
        
        let inventory = Table("inventory")
        let ingredient = Table("ingredients")
        let dbid = Expression<Int64>("id")
        let dbname = Expression<String>("name")
        let dbdesc = Expression<String>("desc")
        let dbquantity = Expression<Double>("quantity")
        let dbexpiryDate = Expression<Date>("expiryDate")
        let dbingredientId = Expression<Int64>("ingredientId")
        let dbshoppingList = Expression<Bool>("shoppingList")
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
        dbshoppingList <- shoppingList
        ))
        
        print("Item added")
        
    } catch {
        print(error)
    }
}

func readInventoryTable() -> [AppPantryItem]{
    var items = [AppPantryItem]()
    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let db = try! Connection("\(path)/db.sqlite3")
    
        let inventory = Table("inventory")
        let ingredient = Table("ingredients")
        let id = Expression<Int64>("id")
        let quantity = Expression<Double>("quantity")
        let expiryDate = Expression<Date>("expiryDate")
        let ingredientId = Expression<Int64>("ingredientId")
        let name = Expression<String>("name")
        let desc = Expression<String>("desc")
        
        let innerJoin = inventory.join(.inner, ingredient, on: inventory[ingredientId] == ingredient[id])
        
        for innerJoin in try db.prepare(innerJoin) {
            items.append(AppPantryItem(appPantryID: innerJoin[inventory[id]],appUserID: 1, ingredientID: innerJoin[ingredient[id]], ingredientName: innerJoin[ingredient[name]], ingredientDesc: innerJoin[ingredient[desc]], quantity: innerJoin[inventory[quantity]], expiryDate: innerJoin[inventory[expiryDate]])!)
        }
    } catch {
        print (error)
    }
    return items
}





//
////food category
//try db.run(foodCategory.create { t in
//    t.column(Expression<Int64>("id"),primaryKey: true)
//    t.column(Expression<String>("name"))
//    t.column(Expression<String>("desc"))
//})
//
//
//



func importFoodDataCSV(){

    do {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print("./Release 2 – Food Details.xlsx")
        print("filemanager: \(FileManager.default)")
//        var lol = Bundle.main.bundleURL
//        print("bundleurl: \()")
//        print("filemanager: \(bundleURL.appendingPathComponent("Release 2 – Food Details.xlsx"))")
        guard let file = XLSXFile(filepath: "./Release 2 – Food Details.xlsx") else {
            fatalError("XLSX file corrupted or does not exist")
        }

        //Ingredients
//        let ingredients = Table("ingredients")
//        let name = Expression<String>("name")
//        let desc = Expression<String>("desc")
//        let quantity = Expression<Int64>("quantity")
        //go through sheet rows
//        for path in try file.parseWorksheetPaths() {
//            let ws = try file.parseWorksheet(at: path)
//            for row in ws.data?.rows ?? [] {
//                for c in row.cells {
//                    //something to store data into table
//                    //case switch for row cell
//                    print(c)
//                }
//                //check for allergies
//                //insert
//                //          try db.run(ingredients.insert(
//                //          name <- "Peanut Allergy",
//                //          desc <- "Suitable for people suffering from a peanut allergy. Recipes and ingredients containing peanuts or traces of peanuts will be omitted from your recipe searches"
//                //          quantity <- 0))
//            }
//        }
     } catch {
         print (error)
     }
}

//
//
//
//
//
////Recipes
//try db.run(recipes.insertMany(
//[name <- ""],
//[desc <- ""],
//[ingredients <- "[1:”1 tablespoon”, 56:”400 grams”]"],
//[diets <- "[]"],
//[cookingTime <- "20"],
//[complexity <- "2"])
//
//
//
//print("succeeded!")
//
//} catch {
//    print("insertion failed: \(error)")
//}
//
