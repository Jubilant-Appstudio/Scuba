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
    
    private let dbFileName = "Quote.sqlite"
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
    
    func insertData(getData: NSDictionary) {
        
        let quoteId = getData.object(forKey: "quote_id") as? Int ?? 0
        let quote = getData.object(forKey: "quote_description") as? String ?? ""
        let quotewriter = getData.object(forKey: "quote_author") as? String ?? ""
        
       // self.copyFile(dbFileName as NSString)
        database = FMDatabase(path: setDatabasePath as String)
        
        if openDatabase() {
            
            if !(database.executeUpdate("insert into Quotes (QId, Quote, writer) values (?,?,?)", withArgumentsIn: [quoteId, quote, quotewriter]) != nil) {
                print("insert 1 table failed: \(database.lastErrorMessage())")
            }
        }
        
        database.close()
        
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
   
    func deleteData(whereCondition: String) {
        
        //self.copyFile(dbFileName as NSString)
        database = FMDatabase(path: setDatabasePath as String)
        
        if openDatabase() {
            
            var dropTable = ""
            
            if whereCondition == "" {
                dropTable = "DELETE FROM Quotes"

            } else {
                dropTable = "DELETE FROM Quotes WHERE \(whereCondition)"
            }
            
            if !(database.executeUpdate(dropTable, withArgumentsIn: []) != nil) {
                print("delete failed \(database.lastErrorMessage())")
            }
            
        }
        
        database.close()
        
    }
    
}
