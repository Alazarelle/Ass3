//
//  DB_read.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 30/5/2023.
//

import Foundation
import SQLite
import SQLite3
import CoreXLSX

func readDiets() -> [String]{
    var diets = [String]()
    do {
        let db = connectDatabase()
        
        let diet = Table("dietCategory")
        let name = Expression<String>("name")
        //let description = Expression<String>("desc")
        
        for diet in  try db.prepare(diet){
            diets.append(diet[name])
        }
    } catch {
        print (error)
    }
    return diets
}

func readAllergies() -> [String] {
    var allergies = [String]()
    do {
        let db = connectDatabase()
        
        let allergy = Table("allergyCategory")
        let name = Expression<String>("name")
        //let description = Expression<String>("desc")
        
        for allergy in  try db.prepare(allergy){
            allergies.append(allergy[name])
        }
    } catch {
        print (error)
    }
    return allergies
}

func getDietIdByName(dietName: String) -> Int{
    do {
        let db = connectDatabase()
        
        let dietCatTable = Table("dietCategory")
        let name = Expression<String>("name")
        let id = Expression<Int64>("id")
        
        for diet in try db.prepare(dietCatTable.where(dietCatTable[name] == dietName)){
            return Int(diet[id])
        }
    } catch {
        print (error)
    }
    return 0
}

func getAllergyIdByName(allergyName: String) -> Int{
    do {
        let db = connectDatabase()
        
        let allergyCatTable = Table("allergyCategory")
        let name = Expression<String>("name")
        let id = Expression<Int64>("id")
        
        for allergy in try db.prepare(allergyCatTable.where(allergyCatTable[name] == allergyName)){
            return Int(allergy[id])
        }
    } catch {
        print (error)
    }
    return 0
}

func readMyAllergies() -> [String] {
    var preferanceList = [String]()
    do {
        let db = connectDatabase()
        
        let prefs = Table("preferences")
        let allergies = Table("allergyCategory")
        let id = Expression<Int64>("id")
        let allergyId = Expression<Int64>("id")
        let type = Expression<String>("type")
        let allergyname = Expression<String>("name")
        //let description = Expression<String>("desc")
        let innerJoin = prefs.join(.inner, allergies, on: allergies[allergyId] == prefs[id])
        
        for innerJoin in try db.prepare(innerJoin.where(prefs[type] == "Allergy")) {
            preferanceList.append(innerJoin[allergies[allergyname]])
        }
    } catch {
        print (error)
    }
    return preferanceList
}

func readMyDiets() -> [String] {
    var preferanceList = [String]()
    do {
        let db = connectDatabase()
        
        let prefs = Table("preferences")
        let allergies = Table("allergyCategory")
        let id = Expression<Int64>("id")
        let allergyId = Expression<Int64>("id")
        let type = Expression<String>("type")
        let allergyname = Expression<String>("name")
        //let description = Expression<String>("desc")
        let innerJoin = prefs.join(.inner, allergies, on: allergies[allergyId] == prefs[id])
        
        for innerJoin in try db.prepare(innerJoin.where(prefs[type] == "Allergy")) {
            
            preferanceList.append(innerJoin[allergies[allergyname]])
        
        }
    } catch {
        print (error)
    }
    return preferanceList
}

func readPreferences() -> [String]{
    var preferanceList = [String]()
    preferanceList += readMyAllergies()
    preferanceList += readMyDiets()
    do {
        let db = connectDatabase()
        
        let prefs = Table("preferences")
        let diets = Table("dietCategory")
        //let allergies = Table("allergyCategory")
        let id = Expression<Int64>("id")
        let dietId = Expression<Int64>("dietId")
        //let allergyId = Expression<Int64>("allergyId")
        let dietName = Expression<String>("name")
        let type = Expression<String>("type")
        let dietname = Expression<String>("name")
        //let allergyname = Expression<String>("name")
        //let description = Expression<String>("desc")
        let innerJoin = prefs.join(.inner, diets, on: diets[id] == prefs[dietId])
        
        for innerJoin in try db.prepare(innerJoin.where(prefs[type] == "Diet")) {
            
            preferanceList.append(innerJoin[diets[dietName]])
        
        }
    } catch {
        print (error)
    }
    
    do {
        let db = connectDatabase()
        
        let prefs = Table("preferences")
        let diets = Table("dietCategory")
        let allergies = Table("allergyCategory")
        let id = Expression<Int64>("id")
        //let dietId = Expression<Int64>("id")
        let allergyId = Expression<Int64>("allergyId")
        let dietName = Expression<String>("name")
        let type = Expression<String>("type")
        let dietname = Expression<String>("name")
        let allergyname = Expression<String>("name")
        //let description = Expression<String>("desc")
        let innerJoin = prefs.join(.inner, allergies, on: allergies[id] == prefs[allergyId])
        
        for innerJoin in try db.prepare(innerJoin.where(prefs[type] == "Allergy")) {
            
            preferanceList.append(innerJoin[allergies[allergyname]])
        
        }
    } catch {
        print (error)
    }
    return preferanceList
}


