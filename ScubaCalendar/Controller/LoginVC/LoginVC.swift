//
//  LoginVC.swift
//  ScubaCalendar
//
//  Created by Mahipalsinh on 10/24/17.
//  Copyright © 2017 CodzGarage. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwifterSwift

class LoginVC: UIViewController {
    
    // MARK: - Variable Declare
    var userModelObj: UserData?
    var sharedObj: Shared?
    var isSocialLogin = 1
    var userSocialID = "asd4as8d7a6s54da6s57d65as4d5as4d8874"
    
    // MARK: - Outlet Declare
    @IBOutlet weak var txtLogin: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btnGuest: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnForgotPwd: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUP: UIButton!
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - SetupUI
    func setupUI() {
        
        sharedObj = Shared.sharedInstance
        
        // set common layer & set font & font size
        btnFacebook = CommonMethods.setCommonLayer(getButton: btnFacebook)
        btnFacebook.titleLabel?.font =  CommonMethods.SetFont.MontserratMedium?.withSize(CGFloat(CommonMethods.SetFontSize.S15))
        
        btnGoogle = CommonMethods.setCommonLayer(getButton: btnGoogle)
        btnGoogle.titleLabel?.font =  CommonMethods.SetFont.MontserratMedium?.withSize(CGFloat(CommonMethods.SetFontSize.S15))
        
        txtLogin = CommonMethods.setCommonTextfield(getTextfield: txtLogin)
        txtLogin.font = CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
        
        txtPassword = CommonMethods.setCommonTextfield(getTextfield: txtPassword)
        txtPassword.font = CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
        
        btnForgotPwd.setTitleColor(CommonMethods.SetColor.themeColor, for: .normal)
        btnForgotPwd.titleLabel?.font =  CommonMethods.SetFont.MontserratBold?.withSize(CGFloat(CommonMethods.SetFontSize.S10))
        
        btnLogin.titleLabel?.font =  CommonMethods.SetFont.MontserratBold?.withSize(CGFloat(CommonMethods.SetFontSize.S15))
        
        btnGuest = CommonMethods.setCommonLayer(getButton: btnGuest)
        btnGuest.titleLabel?.font =  CommonMethods.SetFont.MontserratBold?.withSize(CGFloat(CommonMethods.SetFontSize.S15))
        
        btnSignUP.titleLabel?.font =  CommonMethods.SetFont.MontserratBold?.withSize(CGFloat(CommonMethods.SetFontSize.S15))
    }
    
    // MARK: - Login Validation
    func loginValidation() -> Bool {
        
        if !(txtLogin.text?.isEmail)! {
            CommonMethods.showAlert("", Description: AlertMessages.strInvalidEmail as NSString)
            
            return false
        }
        
        if txtPassword.text?.length == 0 {
            CommonMethods.showAlert("", Description: AlertMessages.strInvalidPWD as NSString)
            
            return false
        }
        
        return true
    }
    
    // MARK: - Login Action
    @IBAction func loginAction(_ sender: Any) {
        
        if (sharedObj?.isReachable)! {
            
            // if login validation == true
            if loginValidation() {
                
                guard let getEmail = txtLogin.text else {
                    return
                }
                
                guard let getPwd = txtPassword.text else {
                    return
                }
                
                let strParameter = "user_email=\(getEmail)&user_password=\(getPwd)&is_social_login=\(isSocialLogin)&user_social_id=\(userSocialID)"
                
                CommonMethods.showMBProgressHudView(self.view)
                
                let apiManagerObj = APIManager()
                apiManagerObj.delegate = self
                apiManagerObj.requestForURL(strUrl: APIList.strUserLogin, httpMethod: "post", parameters: strParameter, includeHeader: false, apiIdentifier: "LoginAction")
                
            }
            
        } else {
            CommonMethods.showAlert("", Description: AlertMessages.strAlertNetworkUnavailable as NSString)
        }
        
    }
    
    // MARK: - Guest Action
    
    @IBAction func guestAction(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        
        guard let homeVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC else {
            return
        }
        
        CommonMethods.showViewControllerWith(storyboard: "Home", newViewController: homeVC, usingAnimation: .ANIMATELEFT)
    
    }
    
    // MARK: - SignUP Action
    @IBAction func signUPAction(_ sender: Any) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let signupObj = mainStoryboard.instantiateViewController(withIdentifier: "SignUPVC") as? SignUPVC {
            
            UIView.beginAnimations("animation", context: nil)
            UIView.setAnimationDuration(1.0)
            
            CommonMethods.navigateTo(signupObj, inNavigationViewController: self.navigationController!, animated: false)
            
            UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: self.navigationController!.view, cache: false)
            
            UIView.commitAnimations()
        }
    }
    
    // MARK: - Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - API Manager Delegate
extension LoginVC: APIManagerDelegate {
    
    func apiResponseSuccess(response: NSDictionary, apiIdentifier: String) {
        
        if apiIdentifier == "LoginAction" {
            CommonMethods.hideMBProgressHud()
            print(response)
            
            guard let getData: NSArray = response.object(forKey: "data") as? NSArray else {
                return
            }
            
            guard let getUserDict: NSDictionary = getData.object(at: 0) as? NSDictionary else {
                return
            }
            
            userModelObj = UserData.init(fromDictionary: getUserDict)
        }
    }
    
    func apiResponseFail(response: NSDictionary, apiIdentifier: String) {
        
        if apiIdentifier == "LoginAction" {
            CommonMethods.hideMBProgressHud()
            
        }
    }
    
    func apiResponseError(error: Error?, apiIdentifier: String) {
        
        if apiIdentifier == "LoginAction" {
            CommonMethods.hideMBProgressHud()
            CommonMethods.showAlert("", Description: AlertMessages.strErrorAlert as NSString)
        }
    }
}
