//
//  SignUPVC.swift
//  ScubaCalendar
//
//  Created by Mahipalsinh on 10/28/17.
//  Copyright © 2017 CodzGarage. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwifterSwift

class SignUPVC: UIViewController {

    // MARK: - Variable Declare
    var userModelObj: UserData?
    var sharedObj: Shared?
    var isSocialLogin = 1
    var userSocialID = "asd4as8d7a6s54da6s57d65as4d5as4d8874"
    
    // MARK: - Outlet Declare
    @IBOutlet weak var txtName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var txtConfirmPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var btnSignUP: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
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
        
        // set common layer
        txtName = CommonMethods.setCommonTextfield(getTextfield: txtName)
        txtEmail = CommonMethods.setCommonTextfield(getTextfield: txtEmail)
        txtPassword = CommonMethods.setCommonTextfield(getTextfield: txtPassword)
        txtConfirmPassword = CommonMethods.setCommonTextfield(getTextfield: txtConfirmPassword)
        
        // set font & font size
        txtName.font = CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
        txtEmail.font = CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
        txtPassword.font = CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
        txtConfirmPassword.font = CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
        btnLogin.titleLabel?.font =  CommonMethods.SetFont.MontserratBold?.withSize(CGFloat(CommonMethods.SetFontSize.S15))
        btnSignUP.titleLabel?.font =  CommonMethods.SetFont.MontserratBold?.withSize(CGFloat(CommonMethods.SetFontSize.S15))
    }
    
    // MARK: - Signup Validation
    func signupValidation() -> Bool {
        
        if txtName.text?.trimmed.length == 0 {
            CommonMethods.showAlert("", Description: AlertMessages.strInvalidName as NSString)
            
            return false
        }
        
        if !(txtEmail.text?.isEmail)! {
            CommonMethods.showAlert("", Description: AlertMessages.strInvalidEmail as NSString)
            
            return false
        }
        
        if txtPassword.text?.length == 0 {
            CommonMethods.showAlert("", Description: AlertMessages.strInvalidPWD as NSString)
            
            return false
        }
        
        if txtPassword.text == txtConfirmPassword.text {
            CommonMethods.showAlert("", Description: AlertMessages.strPwdNotMatch as NSString)
            
            return false
        }
        
        // Approved Terms & condition reaminig
        
        return true
    }
    // MARK: - signUP
    @IBAction func signUPAction(_ sender: Any) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let signupObj = mainStoryboard.instantiateViewController(withIdentifier: "SignupVC2") as? SignupVC2 {
            
            CommonMethods.navigateTo(signupObj, inNavigationViewController: self.navigationController!, animated: true)
            
        }
        
        return
        // ---------------------------
        if (sharedObj?.isReachable)! {
            
            // if signup validation == true
            if signupValidation() {
                
                guard let getName = txtName.text else {
                    return
                }
                
                guard let getEmail = txtEmail.text else {
                    return
                }
                
                guard let getPwd = txtPassword.text else {
                    return
                }
                
                let strParameter = "user_name=\(getName)&user_email=\(getEmail)&user_password=\(getPwd)"
                
                CommonMethods.showMBProgressHudView(self.view)
                
                let apiManagerObj = APIManager()
                apiManagerObj.delegate = self
                apiManagerObj.requestForURL(strUrl: APIList.strUserCreate, httpMethod: "post", parameters: strParameter, includeHeader: false, apiIdentifier: "SignupAction")
                
            }
            
        } else {
            CommonMethods.showAlert("", Description: AlertMessages.strAlertNetworkUnavailable as NSString)
        }
        
    }
    
    // MARK: - Login
    @IBAction func logINAction(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let loginObj = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            
            UIView.beginAnimations("animation", context: nil)
            UIView.setAnimationDuration(1.0)
            
            CommonMethods.navigateTo(loginObj, inNavigationViewController: self.navigationController!, animated: false)
            
            UIView.setAnimationTransition(UIViewAnimationTransition.flipFromRight, for: self.navigationController!.view, cache: false)
            
            UIView.commitAnimations()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - API Manager Delegate
extension SignUPVC: APIManagerDelegate {
    
    func apiResponseSuccess(response: NSDictionary, apiIdentifier: String) {
        
        if apiIdentifier == "SignupAction" {
            CommonMethods.hideMBProgressHud()
            print(response)
            
            guard let getData: NSArray = response.object(forKey: "data") as? NSArray else {
                return
            }
            
            guard let getUserDict: NSDictionary = getData.object(at: 0) as? NSDictionary else {
                return
            }
            print(getUserDict)
            
            // goto signupVC2
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let signupObj = mainStoryboard.instantiateViewController(withIdentifier: "SignupVC2") as? SignupVC2 {
                
                CommonMethods.navigateTo(signupObj, inNavigationViewController: self.navigationController!, animated: false)
                
            }
        }
    }
    
    func apiResponseFail(response: NSDictionary, apiIdentifier: String) {
        
        if apiIdentifier == "SignupAction" {
            CommonMethods.hideMBProgressHud()
            
        }
    }
    
    func apiResponseError(error: Error?, apiIdentifier: String) {
        
        if apiIdentifier == "SignupAction" {
            CommonMethods.hideMBProgressHud()
            CommonMethods.showAlert("", Description: AlertMessages.strErrorAlert as NSString)
        }
    }
}
