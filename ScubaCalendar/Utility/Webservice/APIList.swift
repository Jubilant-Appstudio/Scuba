//
//  APIList.swift
//  CredDirectory
//
//  Created by Mahipal on 11/4/17.
//  Copyright © 2017 Mahipal. All rights reserved.
//

import UIKit

class APIList: NSObject {

    static let empId = "EmpId"
    static let isAuthenticated = "empAuthenticated"
    static let iOSDeviceToken = "deviceToken"

    static let strQuoteUrl = "http://quoteapp.codzgarage.com/api/quotes/"
    static let strUserUrl = "http://quoteapp.codzgarage.com/api/user/"
    static let strTips = "http://quoteapp.codzgarage.com/api/tips/get"
    static let strNotification = "http://quoteapp.codzgarage.com/api/notification/"
    
    //Get all quote
    static let strGetAllQuote =  strQuoteUrl + "get_all"
    
    //Get quote like_count
    static let strLikeCount =  strQuoteUrl + "like_count"

    //Get share quote
    static let strShareCount =  strQuoteUrl + "share_count"
    
    //Get send quote
    static let strSendQuote =  strQuoteUrl + "send_us"
    
    // Login User
    static let strUserLogin =  strUserUrl + "login"
    
    // Get User Like
    static let strUserLike =  strUserUrl + "get_likes/"

    // Get Quote Backup
    static let strUserBackup =  strUserUrl + "backup"
    
    // Notification status on
    static let strNotificationOn =  strNotification + "add"
 
    // Notification status off
    static let strNotificationOff =  strNotification + "off"
    
}
