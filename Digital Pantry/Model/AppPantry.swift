//
//  AppPantry.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 19/5/2023.
//for calendar/ working with days,
//thanks and acknowledgement to auth0.com/blog/date-time-calculations-swift-1/

import Foundation

var userLocale = Locale.autoupdatingCurrent
var gregorianCalendar = Calendar(identifier: .gregorian)

let iso8601DateFormatter = ISO8601DateFormatter()
var dateFormatter = DateFormatter()


struct AppPantryItem {
    //properties/members of AppUser
    var appPantryID: Int
    //var appUserID: Int
    var ingredientID: Int
    var quantity: Double
    var expiryDate: Date
    

    //initialised where we have not obtained a UniqueIdentifier (appUserID) as yet
    init?(appUserID: Int, ingredientID: Int, quantity: Double, expiryDate: Date) {
        self.appPantryID = -1
        if quantity.isZero { //if mandatory fields/properties are empty
            print("Pantry quantity not set")
            return nil
        }
        //self.appUserID = appUserID
        self.ingredientID = ingredientID
        self.quantity = quantity
        self.expiryDate = expiryDate
    }
    
    //use case: calling data back from DB/table
    init?(appPantryID: Int, appUserID: Int, ingredientID: Int, quantity: Double, expiryDate: Date) {
        self.appPantryID = appPantryID
        //self.appUserID = appUserID
        self.ingredientID = ingredientID
        self.quantity = quantity
        self.expiryDate = expiryDate
    }
    
    mutating func setAppPantryID(appPantryID: Int) { //once the DB has a UserID, use this to set it
        self.appPantryID = appPantryID
    }
    
    func getAppPantryID() -> Int { //retrieve PantryID
        return appPantryID
    }
    
    //func getAppUserId() -> Int { //retrieve AppUserID
    //    return appUserID
    //}
    
    func getIngredientId() -> Int { //retrieve IngredientID
        return ingredientID
    }
    
    mutating func setQuantity(quantity: Double) { //add a quantity to item
        self.quantity = quantity
    }
    
    func getQuantity() -> Double { //retrieve quantity of pantry item
        return quantity
    }
    
    mutating func deductFromQuantity(updateAmount: Double) -> Double { //update quantity (subtract)
        if self.quantity >= updateAmount { //if there is enough quantity
            self.quantity -= updateAmount
            return updateAmount //how much we reduced it by
        }
        else { //if insufficient quantity, let them know it wasn't reduced
            return 0.00
        }
    }
    
    mutating func addToQuantity(updateAmount: Double) -> Double { //update quantity (add)
        return self.quantity
    }
    
    mutating func setExpiryDate(expiryDate: Date) { //set new expiry date
        self.expiryDate = expiryDate
    }
    
    func getExpiryDate() -> Date { //retrieve expiry date
        return expiryDate
    }
    
    func isExpiryDateOlder(newExpiryDate: Date) -> Bool { //check if expiry date is older than current item
        if newExpiryDate < self.expiryDate {
            return true
        }
        return false
    }
    
    func isExpired(expiryDate: Date) -> Bool { //check if an ingredient in the pantry is already expired
        let currentDate = Date()
        if currentDate <= expiryDate  { //if it expired
            return true
        }
        return false
    }
    
    func getDaysUntilExpired(expiryDate: Date) -> Int { //return # of days to expiry of pantry ingredient
        gregorianCalendar.locale = userLocale
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        let numOfDays = gregorianCalendar.dateComponents([.day], from: expiryDate, to: Date())
        return numOfDays.day!
    }
    
    func getExpiryDateAsString(expiryDate: Date) -> String { //convert date to String
        
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        
        return formatter.string(from: expiryDate)
    }

}

