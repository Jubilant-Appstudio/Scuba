//
//  CommonMethods.swift
//  CredDirectory
//
//  Created by Mahipal on 13/4/17.
//  Copyright © 2017 Mahipal. All rights reserved.
//

import UIKit
import MBProgressHUD
import SkyFloatingLabelTextField

class CommonMethods: NSObject {
    
    struct SetFont {
        static let MontserratSemiBold = UIFont(name: "Montserrat-SemiBold", size: 15.0)
        static let MontserratMedium = UIFont(name: "Montserrat-Medium", size: 15.0)
        static let MontserratBold = UIFont(name: "Montserrat-Bold", size: 15.0)
        static let RalewayRegular = UIFont(name: "Raleway-Regular", size: 15.0)
        static let RalewaySemiBold = UIFont(name: "Raleway-SemiBold", size: 15.0)
    }
    
    struct SetFontSize {
        static let S10 = 10.0
        static let S12 = 12.0
        static let S15 = 15.0
        static let S17 = 17.0
        static let S20 = 20.0
    }
    
    struct SetColor {
        static let clearColor = UIColor.clear
        static let whiteColor = UIColor.white
        static let themeColor = UIColor(red: 63/255.0, green: 81/255.0, blue: 114/255.0, alpha: 1.0)
        static let darkGrayColor = UIColor(red: 104/255.0, green: 104/255.0, blue: 104/255.0, alpha: 1.0)
        static let searchbarBGColor = UIColor(red: 15/255.0, green: 19/255.0, blue: 30/255.0, alpha: 1.0)
        static let pickerBorderColor = UIColor(red: 0.0/255.0, green: 81.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    }
    
    /*
    static var setTextColor = UIColor.white
    static var setLineColor = UIColor.white
    static var setTopPlaceHolderColor = UIColor(red: 63/255.0, green: 81/255.0, blue: 114/255.0, alpha: 1.0)
    */
    
    static var hud: MBProgressHUD = MBProgressHUD()
    static var  navControl: UINavigationController?
    static var alert: UIAlertController?
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
        //    alert = UIAlertView(title: title as String, message: message as String, delegate: nil, cancelButtonTitle: "Okay")
         //   alert!.show()
            
            alert = UIAlertController(title: title as String, message: message as String, preferredStyle: .alert)
           
            alert?.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))

            getTopViewController().present(alert!, animated: true, completion: nil)
        }
    }
    
    class func dismissAlertView() {
        
        alert?.dismiss(animated: true, completion: nil)
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

    class func setCommonLayer(getButton: UIButton) -> UIButton {
 
        getButton.layer.borderColor = UIColor.white.cgColor
        getButton.layer.borderWidth = 0.5
        getButton.layer.cornerRadius = 5.0
        
        return getButton
    }
    
    class func setCommonTextfield(getTextfield: SkyFloatingLabelTextField) -> SkyFloatingLabelTextField {
       
        getTextfield.textColor = CommonMethods.SetColor.whiteColor
        getTextfield.selectedLineColor = CommonMethods.SetColor.whiteColor
        
        getTextfield.placeholderColor = CommonMethods.SetColor.themeColor
        getTextfield.titleColor = CommonMethods.SetColor.themeColor
        getTextfield.lineColor = CommonMethods.SetColor.themeColor
        getTextfield.selectedTitleColor = CommonMethods.SetColor.themeColor
        
        return getTextfield
    }
    
    class func setCommonSearchField(getSearchBar: UISearchBar) -> UISearchBar {
        
        getSearchBar.borderColor = CommonMethods.SetColor.darkGrayColor
        getSearchBar.borderWidth = 0.5
        getSearchBar.cornerRadius = 5
        
        getSearchBar.shadowOffset = CGSize(width: 0, height: 1)
        
        getSearchBar.barTintColor = CommonMethods.SetColor.clearColor
        
        getSearchBar.barStyle = .black
        getSearchBar.barTintColor = CommonMethods.SetColor.clearColor
        getSearchBar.tintColor = CommonMethods.SetColor.clearColor
        
        getSearchBar.textField?.textColor = CommonMethods.SetColor.whiteColor
        
        return getSearchBar
    }
}
