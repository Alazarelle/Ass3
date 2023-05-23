//
//  FoodCategory.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation

struct FoodCategory {
    //properties/members of Ingredient
    var foodCategoryID: Int
    var foodCategName: String
    var foodCategDescripion: String
    
    //initialised where we have not obtained a UniqueIdentifier (ingredientID) as yet
    init?(foodCategName: String, foodCategDescripion: String) {
        self.foodCategoryID = -1
        self.foodCategName = foodCategName
        self.foodCategDescripion = foodCategDescripion
    }
    
    //use case: calling data back from DB/table
    init?(foodCategoryID: Int, foodCategName: String, foodCategDescripion: String) {
        self.foodCategoryID = foodCategoryID
        self.foodCategName = foodCategName
        self.foodCategDescripion = foodCategDescripion
        
    }
    
    mutating func setFoodCategoryID(foodCategoryID: Int) { //once the DB has a foodCategoryID, use this to set it
        self.foodCategoryID = foodCategoryID
    }
    
    func getFoodCategoryID() -> Int { //retrieve foodCategoryID
        return foodCategoryID
    }
        
    func getFoodCategName() -> String { //retrieve foodCategName
        return foodCategName
    }
    
    mutating func setFoodCategName(foodCategName: String) { //add a foodCategName to item
        self.foodCategName = foodCategName
    }

    func getFoodCategDescripion() -> String { //retrieve foodCategDescripion
        return foodCategDescripion
    }
    
    mutating func setfoodCategDescripion(foodCategDescripion: String) { //add a foodCategDescripion to item
        self.foodCategDescripion = foodCategDescripion
    }
}
