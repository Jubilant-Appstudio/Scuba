//
//  SignupVC2.swift
//  ScubaCalendar
//
//  Created by Mahipalsinh on 10/28/17.
//  Copyright © 2017 CodzGarage. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SignupVC2: UIViewController {
    
    // MARK: - Variable Declare
    var isAnimalSearch = false
    var databaseObj: DatabaseManager!
    var arrayAnimal = [AnimalModel]()
    
    // MARK: - Outlet Declare
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var btnSkip: UIButton!
    
    @IBOutlet weak var txtBirthday: SkyFloatingLabelTextField!
    @IBOutlet weak var txtCountry: SkyFloatingLabelTextField!
    @IBOutlet weak var txtGander: SkyFloatingLabelTextField!
    
    @IBOutlet weak var lblFavAnimal: UILabel!
    @IBOutlet weak var btnSearchAnimal: UIButton!
    @IBOutlet weak var searchAnimal: UISearchBar!
    @IBOutlet weak var searchAnimalHeightCN: NSLayoutConstraint!
    
    @IBOutlet weak var collectionAnimal: UICollectionView!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchAnimal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Back
    func setupUI() {
        
        databaseObj = DatabaseManager()
        
        lblNavTitle.font = CommonMethods.SetFont.MontserratBold?.withSize(CGFloat(CommonMethods.SetFontSize.S15))
        
        btnSkip.titleLabel?.font =  CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S10))
        
        txtBirthday = CommonMethods.setCommonTextfield(getTextfield: txtBirthday)
        txtBirthday.font = CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
        
        txtCountry = CommonMethods.setCommonTextfield(getTextfield: txtCountry)
        txtCountry.font = CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
        
        txtGander = CommonMethods.setCommonTextfield(getTextfield: txtGander)
        txtGander.font = CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
        
        lblFavAnimal.font = CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
        lblFavAnimal.textColor = CommonMethods.SetColor.themeColor
        
        searchAnimal = CommonMethods.setCommonSearchField(getSearchBar: searchAnimal)
        searchAnimalHeightCN.constant = 0
    }
    
    // MARK: - Fetch animal from DB
    func fetchAnimal() {
        
        guard let getAnimal: [AnimalModel] = databaseObj.fetchRecord(tableName: "Animal", whereCondition: "") as? [AnimalModel] else {
            return
        }
        
        arrayAnimal = getAnimal
        
        print(arrayAnimal.count)
    }
    
    // MARK: - Animal Search
    @IBAction func animalSearchAction(_ sender: Any) {
        
        if isAnimalSearch == false {
            isAnimalSearch = true
            searchAnimalHeightCN.constant = 30
            searchAnimal.becomeFirstResponder()
        } else {
            isAnimalSearch = false
            searchAnimalHeightCN.constant = 0
            searchAnimal.resignFirstResponder()        }
        
    }
    
    // MARK: - Back
    @IBAction func backAction(_ sender: Any) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let signupObj = mainStoryboard.instantiateViewController(withIdentifier: "SignUPVC") as? SignUPVC {
            
            CommonMethods.navigateTo(signupObj, inNavigationViewController: self.navigationController!, animated: true)
        }
    }
    
    // MARK: - Skip
    @IBAction func skipAction(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - API Manager Delegate
extension SignupVC2: APIManagerDelegate {
    
    func apiResponseSuccess(response: NSDictionary, apiIdentifier: String) {
        
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
