//
//  AppDelegate.swift
//  ScubaCalendar
//
//  Created by Mahipalsinh on 10/23/17.
//  Copyright © 2017 CodzGarage. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var isUserLogin = false
    
    // swiftlint:disable line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //keyboard apperance
        UITextField.appearance().keyboardAppearance = .dark
        //UITextField.appearance().autocorrectionType = .no
        //UITextField.appearance().autocapitalizationType = .none
        
        // IQkeyboarManager
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        
        // set rootview controller
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        if isUserLogin == false {
         
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            guard let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {
                return false
            }
            
            let nav = UINavigationController(rootViewController: loginVC)
            nav.setNavigationBarHidden(true, animated: false)
            
            appdelegate.window!.rootViewController = nav

        } else {
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            
            appdelegate.window?.rootViewController = mainStoryboard.instantiateInitialViewController()
            
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}
