//
//	AnimalModel.swift
//
//	Create by Mahipal sinh on 28/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class AnimalModel {

    var databaseObj: DatabaseManager!
    
	var animalBigImg: String!
	var animalCreatedOn: String!
	var animalId: Int!
	var animalImg: String!
	var animalName: String!
	var animalSmallImg: String!
	var animalStatus: Int!

	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: NSDictionary) {
		animalBigImg = dictionary["animal_big_img"] as? String ?? ""
		animalCreatedOn = dictionary["animal_created_on"] as? String ?? ""
		animalId = dictionary["animal_id"] as? Int ?? 0
		animalImg = dictionary["animal_img"] as? String ?? ""
		animalName = dictionary["animal_name"] as? String ?? ""
		animalSmallImg = dictionary["animal_small_img"] as? String ?? ""
		animalStatus = dictionary["animal_status"] as? Int ?? 0
        
        insertAnimalRecord(dataDict: dictionary)
	}

    func insertAnimalRecord(dataDict: NSDictionary) {
        
        databaseObj = DatabaseManager()
        
        // Remove old data
        //databaseObj.deleteData(tableName: "Animal", whereCondition: "")
        
        // Insert new Animal data
        databaseObj.insertData(tableName: "Animal", getData: dataDict)
        
    }
}
