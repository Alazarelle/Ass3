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

