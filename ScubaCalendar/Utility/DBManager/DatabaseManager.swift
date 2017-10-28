//
//  DatabaseManager.swift
//  QuoteApp
//
//  Created by YASH on 19/09/17.
//  Copyright © 2017 YASH. All rights reserved.
//

import UIKit
import FMDB

class DatabaseManager: NSObject {
    
    private let dbFileName = "ScubaCalendar.sqlite"
    private var database = FMDatabase()
    var setDatabasePath = String()
    
    override init() {
        super.init()
        
        self.copyFile(dbFileName as NSString)
    }
    
    func getPath(_ fileName: String) -> String {
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        return fileURL.path
    }
    
    func copyFile(_ fileName: NSString) {
        
        let dbPath: String = getPath(fileName as String)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dbPath) {
            
            let documentsURL = Bundle.main.resourceURL
            let fromPath = documentsURL!.appendingPathComponent(fileName as String)
            
            do {
                setDatabasePath = dbPath
                try fileManager.copyItem(atPath: fromPath.path, toPath: dbPath)
            } catch let error1 as NSError {
               print(error1.description)
            }
            
        } else {
            setDatabasePath = dbPath
        }
    }
    
    func openDatabase() -> Bool {
        
        if FileManager.default.fileExists(atPath: setDatabasePath) {
            database = FMDatabase(path: setDatabasePath)
        }
        
        if database.open() {
            return true
        }
        
        return false
    }
    
    func fetchRecord(whereCondition: String) -> NSMutableArray {
        
        let quotes = NSMutableArray()
        
      //  self.copyFile(dbFileName as NSString)
        database = FMDatabase(path: setDatabasePath as String)
        if openDatabase() {
            
            if whereCondition == "" {
                // get all record
                if let rs = database.executeQuery("select * from Quotes", withArgumentsIn: []) {
                    while rs.next() {
                        quotes.add(rs.resultDictionary!)
                    }
                } else {
                    print("select failure: \(database.lastErrorMessage())")
                }
                
            } else {
                
                // where condition
                let queryString = "select * from Quotes where \(whereCondition)"
                if let rs = database.executeQuery(queryString, withArgumentsIn: []) {
                    while rs.next() {
                        
                        quotes.add(rs.resultDictionary!)
                        
                    }
                } else {
                    print("select failure: \(database.lastErrorMessage())")
                }
            }
            
        }
        
        database.close()
        
        return quotes
    }
    
    func insertData(tableName: String, getData: NSDictionary) {
        print(tableName, getData)
        
        if tableName == "User" {
            
            let userCountry = getData.object(forKey: "user_country") as? Int ?? 0
            let userCreatedOn = getData.object(forKey: "user_created_on") as? String ?? ""
            let userDescribedAs = getData.object(forKey: "user_described_as") as? String ?? ""
            let userDob = getData.object(forKey: "user_dob") as? String ?? ""
            let userEmail = getData.object(forKey: "user_email") as? String ?? ""
            let userFavAnimal = getData.object(forKey: "user_fav_animal") as? String ?? ""
            let userFavCountry = getData.object(forKey: "user_fav_country") as? String ?? ""
            let userFcmDevice = getData.object(forKey: "user_fcm_device") as? String ?? ""
            let userFcmToken = getData.object(forKey: "user_fcm_token") as? String ?? ""
            let userGander = getData.object(forKey: "user_gander") as? String ?? ""
            let userId = getData.object(forKey: "user_id") as? Int ?? 0
            let userImg = getData.object(forKey: "user_img") as? String ?? ""
            let userName = getData.object(forKey: "user_name") as? String ?? ""
            let userPassword = getData.object(forKey: "user_password") as? String ?? ""
            let userSocialId = getData.object(forKey: "user_social_id") as? String ?? ""
            let userSocialType = getData.object(forKey: "user_social_type") as? String ?? ""
            let userStatus = getData.object(forKey: "user_status") as? Int ?? 0
            let userToken = getData.object(forKey: "user_token") as? Int ?? 0
            
            // self.copyFile(dbFileName as NSString)
            database = FMDatabase(path: setDatabasePath as String)
            
            if openDatabase() {
                
                if !(database.executeUpdate("insert into User (user_country, user_created_on, user_described_as,user_dob, user_email, user_fav_animal,user_fav_country, user_fcm_device, user_fcm_token,user_gander, user_id, user_img,user_name, user_password, user_social_id,user_social_type, user_status, user_token) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", withArgumentsIn: [userCountry,userCreatedOn,userDescribedAs,userDob,userEmail,userFavAnimal,userFavCountry,userFcmDevice,userFcmToken,userGander,userId,userImg,userName,userPassword,userSocialId,userSocialType,userStatus,userToken]) != nil) {
                    
                    print("insert 1 table failed: \(database.lastErrorMessage())")
                }
            }
            
            database.close()
            
        }
    }
    
    func updateData(whereCondition: String) {
      
       // self.copyFile(dbFileName as NSString)
        database = FMDatabase(path: setDatabasePath as String)
        
        if openDatabase() {
            
            let queryString = "update Quotes set \(whereCondition)"
            print(queryString)
            if !(database.executeUpdate(queryString, withArgumentsIn: []) != nil) {
            }
        }
        
        database.close()
        
    }
   
    func deleteData(tableName: String, whereCondition: String) {
        
        //self.copyFile(dbFileName as NSString)
        database = FMDatabase(path: setDatabasePath as String)
        
        if openDatabase() {
            
            var dropTable = ""
            
            if whereCondition == "" {
                dropTable = "DELETE FROM \(tableName)"

            } else {
                dropTable = "DELETE FROM \(tableName) WHERE \(whereCondition)"
            }
            
            if !(database.executeUpdate(dropTable, withArgumentsIn: []) != nil) {
                print("delete failed \(database.lastErrorMessage())")
            }
            
        }
        
        database.close()
        
    }
    
}
