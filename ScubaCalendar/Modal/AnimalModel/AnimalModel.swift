//
//	AnimalModel.swift
//
//	Create by Mahipal sinh on 28/10/2017
//	Copyright © 2017. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class AnimalModel {

    var databaseObj: DatabaseManager!
    
	private var animalBigImg: String!
	private var animalCreatedOn: String!
	private var animalId: Int!
	private var animalImg: String!
	private var animalName: String!
	private var animalSmallImg: String!
	private var animalStatus: Int!

    private var animalSelected: Bool!
    
    // Getter
    var animalBigImage: String {
        return animalBigImg
    }
    
    var getAnimalCreatedOn: String {
        return animalCreatedOn
    }
   
    var getAnimalID: Int {
        return animalId
    }
   
    var getAnimalImg: String {
        return animalImg
    }
   
    var getAnimalName: String {
        return animalName
    }
   
    var getAnimlaSmallImg: String {
        return animalSmallImg
    }
   
    var getBigImage: Int {
        return animalStatus
    }
    
    public var getIsSelected: Bool {
        get {
            return animalSelected
        }
        set(selectedStatus) {
            animalSelected = selectedStatus
        }
    }
    
	init(fromDictionary dictionary: NSDictionary) {
		animalBigImg = dictionary["animal_big_img"] as? String ?? ""
		animalCreatedOn = dictionary["animal_created_on"] as? String ?? ""
		animalId = dictionary["animal_id"] as? Int ?? 0
		animalImg = dictionary["animal_img"] as? String ?? ""
		animalName = dictionary["animal_name"] as? String ?? ""
		animalSmallImg = dictionary["animal_small_img"] as? String ?? ""
		animalStatus = dictionary["animal_status"] as? Int ?? 0
        animalSelected = false
	}

    func insertAnimalRecord(dataDict: NSDictionary) {
        
        databaseObj = DatabaseManager()
        
        // Remove old data
        //databaseObj.deleteData(tableName: "Animal", whereCondition: "")
        
        // Insert new Animal data
        databaseObj.insertData(tableName: "Animal", getData: dataDict)
        
    }
}
