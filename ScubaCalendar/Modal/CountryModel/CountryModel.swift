//
//	CountryModel.swift
//
//	Create by Mahipal sinh on 28/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class CountryModel {

    var databaseObj: DatabaseManager!
    
	var countryData: String!
	var countryId: Int!
	var countryMap: String!
	var countryMapSmall: String!
	var countryName: String!

    /**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
    
	init(fromDictionary dictionary: NSDictionary) {
		countryData = dictionary["country_data"] as? String ?? ""
		countryId = dictionary["country_id"] as? Int ?? 0
		countryMap = dictionary["country_map"] as? String ?? ""
		countryMapSmall = dictionary["country_map_small"] as? String ?? ""
		countryName = dictionary["country_name"] as? String ?? ""
        
	}

    func insertCountryRecord(dataDict: NSDictionary) {
        
        databaseObj = DatabaseManager()
        
        // Remove old data
        //databaseObj.deleteData(tableName: "Animal", whereCondition: "")
        
        // Insert new Animal data
        databaseObj.insertData(tableName: "Country", getData: dataDict)
        
    }
}
