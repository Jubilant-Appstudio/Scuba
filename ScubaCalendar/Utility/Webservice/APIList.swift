//
//  APIList.swift
//  CredDirectory
//
//  Created by Mahipal on 11/4/17.
//  Copyright © 2017 Mahipal. All rights reserved.
//

import UIKit

class APIList: NSObject {

    static let strBaseUrl = "http://scuba.codzgarage.com/" // Base URL
    static let strUserUrl = "http://scuba.codzgarage.com/api/user/" // User
    static let strAnimalUrl = "http://scuba.codzgarage.com/api/animal/" // Animal
    static let strCountryUrl = "http://scuba.codzgarage.com/api/country/" // Country
    
    //User Login
    static let strUserLogin =  strUserUrl + "login"
    
    //User Login create
    static let strUserCreate =  strUserUrl + "create"
    
    //User update profile
    static let strUserProfile =  strUserUrl + "profile"
    
    // Animal List
    static let strAnimalList = strAnimalUrl + "get_list"
    
    // Country List
    static let strCountryList = strCountryUrl + "get_list"
    
}
