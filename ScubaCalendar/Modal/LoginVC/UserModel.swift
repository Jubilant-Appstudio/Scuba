//
//  UserModel.swift
//  ScubaCalendar
//
//  Created by Mahipalsinh on 10/25/17.
//  Copyright © 2017 CodzGarage. All rights reserved.
//

import Foundation
/*
 "user_id": 1,
 "user_name": "Jon Doe",
 "user_email": "jon@doe.com",
 "user_img": "uploads/user/bbbea527ea02200352313bc059445190.jpg",    # append base URL to get full URL
 "user_social_type": "facebook",
 "user_social_id": "asd4as8d7a6s54da6s57d65as4d5as4d8874",
 "user_dob": "2017-08-30",
 "user_country": 1,
 "user_gander": "male",
 "user_fav_animal": "1,2,8,9",
 "user_fav_country": "91,82,8",
 "user_described_as": "Beginner Driver",
 "user_token": "",
 "user_fcm_token": "bbbea527ea02200352313bc059445190487a56s4d8s4d88v7",
 "user_created_on": "2017-08-30 15:59:45",
 "user_status": 1
 */

class UserData {
    
    private var userID: String!
    private var userName: String!
    private var userEmail: String!
    private var userImage: String!
    private var userSocialType: String!
    private var userSocialID: String!
    private var userDOB: String!
    private var userCountry: Int!
    private var userGander: String!
    private var userFavAnimal: [Int]!
    private var userFavCountry: [Int]!
    private var userDescribedAs: String!
    private var userToken: String!
    private var userFcmToken: String!
    private var userCreatedOn: String!
    private var userStatus: String!
    
    init(getUserData: NSDictionary) {
        print(getUserData)
    }
    
}
