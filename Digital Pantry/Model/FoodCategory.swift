//
//  FoodCategory.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 23/5/2023.
//

import Foundation

struct FoodCategory {
    //properties/members of Ingredient
    var foodCategoryID: Int64
    var foodCategName: String
    
    //initialised where we have not obtained a UniqueIdentifier (ingredientID) as yet
    init?(foodCategName: String) {
        self.foodCategoryID = -1
        self.foodCategName = foodCategName
    }
    
    //use case: calling data back from DB/table
    init?(foodCategoryID: Int64, foodCategName: String) {
        self.foodCategoryID = foodCategoryID
        self.foodCategName = foodCategName
        
    }
    
    mutating func setFoodCategoryID(foodCategoryID: Int64) { //once the DB has a foodCategoryID, use this to set it
        self.foodCategoryID = foodCategoryID
    }
    
    func getFoodCategoryID() -> Int64 { //retrieve foodCategoryID
        return foodCategoryID
    }
        
    func getFoodCategName() -> String { //retrieve foodCategName
        return foodCategName
    }
    
    mutating func setFoodCategName(foodCategName: String) { //add a foodCategName to item
        self.foodCategName = foodCategName
    }
}
