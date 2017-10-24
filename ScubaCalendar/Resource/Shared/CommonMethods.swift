//
//  CommonMethods.swift
//  CredDirectory
//
//  Created by Mahipal on 13/4/17.
//  Copyright © 2017 Mahipal. All rights reserved.
//

import UIKit
import MBProgressHUD

class CommonMethods: NSObject {
    
    static var hud: MBProgressHUD = MBProgressHUD()
    static var  navControl: UINavigationController?
    static var alert: UIAlertView?
    static var sharedObj: Shared?
    
    class func navigateTo(_ destinationVC: UIViewController, inNavigationViewController navigationController: UINavigationController, animated: Bool ) {
        
        //Assign to global value
        navControl = navigationController
        
        var VCFound: Bool = false
        let viewControllers: NSArray = navigationController.viewControllers as NSArray
        var indexofVC: NSInteger = 0
        
        for vc in navigationController.viewControllers {
            
            if vc.nibName == (destinationVC.nibName) {
                
                VCFound = true
                break
            } else {
                indexofVC += 1
            }
            
        }
        
        DispatchQueue.main.async(execute: {
            if VCFound == true {
             //   navigationController .popToViewController(viewControllers.object(at: indexofVC) as! UIViewController, animated: animated)
               
                if let navigationObj: UIViewController = viewControllers.object(at: indexofVC) as? UIViewController {
                    navigationController.popToViewController(navigationObj, animated: animated)
                }
                
            } else {
                navigationController .pushViewController(destinationVC, animated: animated)
            }
        })
    }
    
    class func findViewControllerRefInStack(_ destinationVC: UIViewController, inNavigationViewController navigationController: UINavigationController) -> UIViewController {
        
        var VCFound = false
        var viewControllers = navigationController.viewControllers
        var indexofVC = 0
        
        for vc: UIViewController in viewControllers {
            if vc.nibName == (destinationVC.nibName) {
                VCFound = true
                break
            } else {
                indexofVC += 1
            }
        }
        if VCFound == true {
            return viewControllers[indexofVC]
        } else {
            return destinationVC
        }
    }
    
    // MARK: UIAlertView
    class func showAlert(_ title: NSString, Description message: NSString) {
        
        if alert != nil {
            
            self.dismissAlertView()
        }
        
        DispatchQueue.main.async {
            alert = UIAlertView(title: title as String, message: message as String, delegate: nil, cancelButtonTitle: "Okay")
            alert!.show()
        }
    }
    
    class func dismissAlertView() {
        
        alert?.dismiss(withClickedButtonIndex: 0, animated: true)
    }
    
    // MARK: - Navigation elements
    class func setUpNavigationBar(_ navControl: UINavigationController, navItem: UINavigationItem, title: String) {
        
        //navControl.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //navControl.navigationBar.shadowImage = UIImage()
        
        navControl.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: UIFont(name: "Roboto-Regular", size: 17)!, NSAttributedStringKey.foregroundColor: UIColor.white]
        navItem.title = title
        navControl.navigationBar.tintColor = UIColor.white
    }
    
    class func setSpacing(getString: String, getLinespacing: CGFloat, getCharacterspace: CGFloat ) -> NSAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = getLinespacing
        
        let attrString = NSMutableAttributedString(string: getString)
       // attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        let range = NSMakeRange(0, attrString.length)
        attrString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: range)
        attrString.addAttribute(NSAttributedStringKey.kern, value: getCharacterspace, range: NSRange(location: 0, length: getString.characters.count))
        
        return attrString
    }
    
    class func showNotificationAlert(getViewController: UIViewController) {
        
        /*
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let popup : PreOrderVC = mainStoryboard.instantiateViewController(withIdentifier: "PreOrderVC") as! PreOrderVC
        let navigationController = UINavigationController(rootViewController: popup)
        
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        navigationController.setNavigationBarHidden(true, animated: false)
        
        getViewController.present(navigationController, animated: true, completion: nil)
        */
    }
    
    class func getTopViewController() -> UIViewController {
        
        var viewController = UIViewController()
        
        if let vc =  UIApplication.shared.delegate?.window??.rootViewController {
            
            viewController = vc
            var presented = vc
            
            while let top = presented.presentedViewController {
                presented = top
                viewController = top
            }
        }
        
        print(viewController)
        
        return viewController
    }
    
    class func showMBProgressHudView(_ view: UIView) {
        
        DispatchQueue.main.async(execute: {
            self.hud = MBProgressHUD.showAdded(to: view, animated: true)
        })
        
    }
    
    class func showPercentageMBProgressHudView(_ view: UIView) {
        
        DispatchQueue.main.async(execute: {
            
            self.hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = .determinateHorizontalBar
        })
        
    }
    
    class func hideMBProgressHud() {
        
        DispatchQueue.main.async(execute: {
            
            self.hud.hide(animated: true)
        })
    }
    
    class func convertDateFormat(fullDate: String) -> String {
        
        if fullDate != "" {
            let dateFormatter = DateFormatter()
            let tempLocale = dateFormatter.locale
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = dateFormatter.date(from: fullDate)!
            dateFormatter.dateFormat = "dd-MM-yyyy"
            dateFormatter.locale = tempLocale
            let dateString = dateFormatter.string(from: date)
            
            return dateString
        } else {
            return ""
        }
        
    }
    
    class func setCounterValue(getCount: Int) -> String {
        
        var setCounterValue = ""
        
        if getCount <= 99 {
            setCounterValue = String(getCount)
        } else if getCount <= 9999 {
            print("\(Int(getCount/1000)) M")
            setCounterValue = "\(Int(getCount/1000)) M"
        } else if getCount <= 99999 {
            setCounterValue = "\(Int(getCount/10000)) M"
        }
        
        return setCounterValue
    }
    
}
