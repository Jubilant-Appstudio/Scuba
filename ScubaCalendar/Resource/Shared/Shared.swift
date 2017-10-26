//
//  Shared.swift
//  CredDirectory
//
//  Created by Mahipal on 12/4/17.
//  Copyright © 2017 Mahipal. All rights reserved.
//

import UIKit
import Foundation
import ReachabilitySwift
import MBProgressHUD



class Shared: NSObject {
        
    static let sharedInstanceObj = sharedInstance
    
    var reachability: Reachability?
    var isReachable: Bool?
    let databaseObj = DatabaseManager()
    
    static var hud: MBProgressHUD = MBProgressHUD()
    
    fileprivate override init() {
        
        super.init()
        
        //Reachability
        do {
            reachability = Reachability.init()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: ReachabilityChangedNotification, object: reachability)
        do {
            try reachability!.startNotifier()
        } catch {
            
        }
    }
    
    class var sharedInstance: Shared {
        struct Static {
            static var instance: Shared?
            static var token: Int = 0
        }
        
        if Static.instance == nil {
            Static.instance = Shared()
        }
        
        return Static.instance!
        
    }
    
    //Self delegate
    @objc func reachabilityChanged(_ note: Notification) {
        
        //let reachability = note.object as! Reachability
        
        guard let reachability = note.object as? Reachability else {
            return
        }
        if reachability.isReachable {
            
            // WS call
            isReachable = true
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            
        } else {
            print("Not reachable")
            
            //  let strAlertString = AlertMessages.strAlertNetworkUnavailable
            ////  CommonMethods.ShowAlert(strAlertString as NSString, Description: "")
            
            isReachable = false
        }
    }
    
}
