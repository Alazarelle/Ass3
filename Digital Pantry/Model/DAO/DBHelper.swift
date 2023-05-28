//
//  DBHelper.swift
//  Digital Pantry
//
//  Created by Alexander Korabelnikoff on 27/5/2023.
//

import Foundation
import SQLite
import SQLite3
import CoreXLSX

func insertTableData2() {
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let db = try! Connection("\(path)/db.sqlite3")
}


//class DBHelper {
//    //var db : OpaquePointer?
    //var path : String = "pantryDB.sqlite"
//    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//    let db = try! Connection("\(path)/db.sqlite3")
    
//    init() {
//        self.db = createDB()
//        self.createTable(queryText: "CREATE TABLE IF NOT EXISTS AppUser(appUserID INTEGER PRIMARY KEY AUTOINCREMENT, loginEmail TEXT, preferredName TEXT, hasDietNeed INTEGER, isAdmin INTEGER, deactivate INTEGER);")
//    }
    
//    func createDB() -> OpaquePointer? {
//        let filePath = try! FileManager.default.url(for: .documentDirectory, in:   .userDomainMask,  appropriateFor: nil, create: false).appendingPathExtension(path)
//        var db : OpaquePointer? = nil
        
//        if sqlite3_open(filePath.path,  &db) != SQLITE_OK {
//            print("There is an error in creating the DB")
//            return nil
//        } else {
//            print("Database has been created with path \(path)")
//            return db
//        }
//    }
    
//    func createTable(queryText : String) {
        //let query =
//        var createTable : OpaquePointer? = nil
        
//        if sqlite3_prepare_v2(self.db, queryText, -1, &createTable, nil) == SQLITE_OK {
//            if sqlite3_step(createTable) == SQLITE_DONE {
//                print("Table creation succeeded")
//                      } else {
 //                   print("Table creation failed")
//                }
//        } else {
//            print("Preparation failed")
//        }
//    }
//    
//    func insertAppUserDONTUSE(loginEmail: String, preferredName: String, hasDietNeed: Bool, isAdmin: Bool, deactivate: Bool) {
//        do {
//            
//            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//            let db = try! Connection("\(path)/db.sqlite3")
//            
//            //Allergy data
//            let allergy = Table("allergyCategory")
//            let name = Expression<String>("name")
//            let desc = Expression<String>("desc")
//            
//            try db.run(allergy.insert(
//            name <- "Peanut Allergy",
//            desc <- "Suitable for people suffering from a peanut allergy. Recipes and ingredients containing peanuts or traces of peanuts will be omitted from your recipe searches"))
//
//        } catch {
//            print (error)
//        }
//         //   let query = "INSERT INTO AppUser (appUserID, loginEmail, preferredName, hasDietNeed, isAdmin, deactivate) VALUES ( ?, ?, ?, ?, ? ?);"
//         //   var statement : OpaquePointer? = nil
//            
//        }
//            
//        if sqlite3_prepare(db, query, -1, &statement, nil ) == SQLITE_OK {
//            sqlite3_bind_int(statement, 1, 1)
//            sqlite3_bind_text(statement, 2, (loginEmail as NSString).utf8String, -1, nil)
//            sqlite3_bind_text(statement, 3, (preferredName as NSString).utf8String, -1, nil)
//            sqlite3_bind_int(statement, 4, (hasDietNeed ? 1 : 0))
//            sqlite3_bind_int(statement, 5, (isAdmin ? 1 : 0))
//            sqlite3_bind_int(statement, 6, (deactivate ? 1 : 0))
//            if sqlite3_step(statement) == SQLITE_DONE {
//                print("Data inserted successfully")
//            } else {
//                print("Data not inserted into table")
//            }
//        } else {
//            print("Query is not meeting requirements")
//        }
//    }
//    
//    func readAppUser(appUserID : Int) -> [AppUser] {
//        //var user : AppUser
//        var user = [AppUser]()
//        let query = "SELECT * FROM AppUser;"
//        var statement : OpaquePointer? = nil
//        
//        
//        if sqlite3_prepare(db, query, -1, &statement, nil ) == SQLITE_OK {
//            while sqlite3_step(statement) == SQLITE_ROW {
//                
//                if appUserID == Int(sqlite3_column_int(statement, 0)) {
//                    let loginEmail = String(describing: String(cString: sqlite3_column_text(statement, 1)))
//                    let preferredName = String(describing: String(cString:sqlite3_column_text(statement, 2)))
//                    let hasDietNeed = Bool(Int(sqlite3_column_int(statement, 3)) == 1 ? true : false)
//                    let isAdmin = Bool(Int(sqlite3_column_int(statement, 4)) == 1 ? true : false)
//                    let deactivate = Bool(Int(sqlite3_column_int(statement, 5)) == 1 ? true : false)
//                    
//                    let users = AppUser(appUserID: appUserID, loginEmail: loginEmail, preferredName: preferredName, hasDietNeed: hasDietNeed, isAdmin: isAdmin, deactivate: deactivate)
//                    user.append(users!)
//                }
//            }
//            return user
//        }
//        return user
//    }
//    
//    func updateAppUser(appUserID: Int, loginEmail: String, preferredName: String, hasDietNeed: Bool, isAdmin: Bool, deactivate: Bool) {
//        let query = "UPDATE AppUser SET loginEmail = '\(loginEmail)', preferredName = '\(preferredName)', hasDietNeed=" + String(hasDietNeed ? 1 : 0) +
//        " isAdmin=" + String(isAdmin ? 1 : 0) + " deactivate=" + String(deactivate ? 1 : 0) + " WHERE appUserID = \(appUserID);"
//        var statement : OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, query, -1, &statement, nil ) == SQLITE_OK {
//            if sqlite3_step(statement) == SQLITE_DONE {
//                print("Data updated successfully")
//            } else {
//                print("Data not updated into table")
//            }
//        }
//    }
//    
//    func deleteFromAppUser(appUserID: Int) {
//        let query = "DELETE FROM AppUser WHERE appUserID = \(appUserID);"
//        var statement : OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, query, -1, &statement, nil ) == SQLITE_OK {
//            if sqlite3_step(statement) == SQLITE_DONE {
//                print("Data deleted successfully")
//            } else {
//                print("Data not deleted into table")
//            }
//        }
//    }
//}
