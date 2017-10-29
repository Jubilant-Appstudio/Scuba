//
//	CountryModel.swift
//
//	Create by Mahipal sinh on 28/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class CountryModel {

    var databaseObj: DatabaseManager!
    
	private var countryData: String!
	private var countryId: Int!
	private var countryMap: String!
	private var countryMapSmall: String!
	private var countryName: String!

    private var countrySelected: Bool!
    
    var getCountryData: String {
        return countryData
    }
    
    var getCountryId: Int {
        return countryId
    }
    
    var getCountryMap: String {
        return countryMap
    }
    
    var getCountryMapSmall: String {
        return countryMapSmall
    }
    
    var getCountryName: String {
        return countryName
    }
    public var getIsSelected: Bool {
        get {
            return countrySelected
        }
        set(selectedStatus) {
            countrySelected = selectedStatus
        }
    }
    
	init(fromDictionary dictionary: NSDictionary) {
		countryData = dictionary["country_data"] as? String ?? ""
		countryId = dictionary["country_id"] as? Int ?? 0
		countryMap = dictionary["country_map"] as? String ?? ""
		countryMapSmall = dictionary["country_map_small"] as? String ?? ""
		countryName = dictionary["country_name"] as? String ?? ""
        countrySelected = false
	}

    func insertCountryRecord(dataDict: NSDictionary) {
        
        databaseObj = DatabaseManager()
        
        // Remove old data
        //databaseObj.deleteData(tableName: "Animal", whereCondition: "")
        
        // Insert new Animal data
        databaseObj.insertData(tableName: "Country", getData: dataDict)
        
    }
}
