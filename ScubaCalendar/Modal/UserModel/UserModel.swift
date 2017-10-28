//
//  UserModel.swift
//  ScubaCalendar
//
//  Created by Mahipalsinh on 10/25/17.
//  Copyright © 2017 CodzGarage. All rights reserved.
//

import Foundation

class UserData {
    
    var databaseObj: DatabaseManager!

    var userCountry: Int!
    var userCreatedOn: String!
    var userDescribedAs: String!
    var userDob: String!
    var userEmail: String!
    var userFavAnimal: String!
    var userFavCountry: String!
    var userFcmDevice: String!
    var userFcmToken: String!
    var userGander: String!
    var userId: Int!
    var userImg: String!
    var userName: String!
    var userPassword: String!
    var userSocialId: String!
    var userSocialType: String!
    var userStatus: Int!
    var userToken: Int!
    
    init(fromDictionary dictionary: NSDictionary) {
        
        userCountry = dictionary["user_country"] as? Int ?? 0
        userCreatedOn = dictionary["user_created_on"] as? String ?? ""
        userDescribedAs = dictionary["user_described_as"] as? String ?? ""
        userDob = dictionary["user_dob"] as? String ?? ""
        userEmail = dictionary["user_email"] as? String ?? ""
        userFavAnimal = dictionary["user_fav_animal"] as? String ?? ""
        userFavCountry = dictionary["user_fav_country"] as? String ?? ""
        userFcmDevice = dictionary["user_fcm_device"] as? String ?? ""
        userFcmToken = dictionary["user_fcm_token"] as? String ?? ""
        userGander = dictionary["user_gander"] as? String ?? ""
        userId = dictionary["user_id"] as? Int ?? 0
        userImg = dictionary["user_img"] as? String ?? ""
        userName = dictionary["user_name"] as? String ?? ""
        userPassword = dictionary["user_password"] as? String ?? ""
        userSocialId = dictionary["user_social_id"] as? String ?? ""
        userSocialType = dictionary["user_social_type"] as? String ?? ""
        userStatus = dictionary["user_status"] as? Int ?? 0
        userToken = dictionary["user_token"] as? Int ?? 0
        
        insertDataintoDB(dataDict: dictionary)
    }

    func insertDataintoDB(dataDict: NSDictionary) {
        print(dataDict)
        
        databaseObj = DatabaseManager()
        
        // Remove old data
        databaseObj.deleteData(tableName: "User", whereCondition: "")
        
        // Insert new user data
        databaseObj.insertData(tableName: "User", getData: dataDict)
    }
    
}
