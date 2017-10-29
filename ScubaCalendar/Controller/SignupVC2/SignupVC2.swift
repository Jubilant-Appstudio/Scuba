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
    var sharedObj: Shared?
    
    var isAnimalSearch = false
    var isCountrySearch = false
    var databaseObj: DatabaseManager!
    
    var animalModelObj: AnimalModel!
    var arrayFavAnimal = [AnimalModel]()
    var arraySelectedAnimal = [Int]()
    
    var countryModelObj: CountryModel!
    var arrayFavCountry = [CountryModel]()
    var arraySelectedCountry = [Int]()
    
    var birthdayPickerView = UIDatePicker()
    
    var countryPickerView = UIPickerView()
    var arrayCountry = [String]()
    
    var ganderPickerView = UIPickerView()
    var arrayGander = ["Male", "Female"]
    
    var describedPickerView = UIPickerView()
    var arrayDeacribed = ["Beginner diver", "Expert diver"]
    
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
    
    @IBOutlet weak var lblFavCountry: UILabel!
    @IBOutlet weak var btnSearchCountry: UIButton!
    @IBOutlet weak var searchCountry: UISearchBar!
    @IBOutlet weak var searchCountryHeightCN: NSLayoutConstraint!
    @IBOutlet weak var collectionCountry: UICollectionView!
    
    @IBOutlet weak var lblDescribed: UILabel!
    @IBOutlet weak var txtDescribed: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btnSave: UIButton!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAnimal()
        fetchCountry()
    }
    
    // MARK: - Back
    func setupUI() {
        
        sharedObj = Shared.sharedInstance
        
        databaseObj = DatabaseManager()
        
        // Register Animal cell
        let animalNib = UINib(nibName: "AnimalCell", bundle: nil)
        collectionAnimal.register(animalNib, forCellWithReuseIdentifier: "Animal")
        collectionAnimal.tag = 101
        collectionAnimal.delegate = self
        collectionAnimal.dataSource = self
        
        // Register Country cell
        let countryNib = UINib(nibName: "CountryCell", bundle: nil)
        collectionCountry.register(countryNib, forCellWithReuseIdentifier: "Country")
        collectionCountry.tag = 102
        collectionCountry.delegate = self
        collectionCountry.dataSource = self
        
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
        
        lblFavCountry.font = CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
        lblFavCountry.textColor = CommonMethods.SetColor.themeColor
        
        // Birthday Picker
        /*
         DispatchQueue.main.async(execute: {
         
         self.birthdayPickerView.setValue(CommonMethods.SetColor.whiteColor, forKey: "textColor")
         self.birthdayPickerView.backgroundColor = CommonMethods.SetColor.themeColor
         })
         */
        self.birthdayPickerView.setValue(CommonMethods.SetColor.whiteColor, forKey: "textColor")
        self.birthdayPickerView.backgroundColor = CommonMethods.SetColor.themeColor
        
        birthdayPickerView.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        txtBirthday.delegate = self
        txtBirthday.keyboardAppearance = .default
        
        searchAnimal = CommonMethods.setCommonSearchField(getSearchBar: searchAnimal)
        searchAnimalHeightCN.constant = 0
        
        // Country Picker
        arrayCountry.append("India")
        arrayCountry.append("Canada")
        arrayCountry.append("Aus")
        
        self.countryPickerView.delegate = self
        self.countryPickerView.dataSource = self
        self.countryPickerView.backgroundColor = CommonMethods.SetColor.themeColor
        
        txtCountry.inputView = countryPickerView
        txtCountry.keyboardToolbar.isHidden = true
        txtCountry.keyboardAppearance = .default
        
        searchCountry = CommonMethods.setCommonSearchField(getSearchBar: searchCountry)
        searchCountryHeightCN.constant = 0
        
        // Gander Picker
        self.ganderPickerView.delegate = self
        self.ganderPickerView.dataSource = self
        self.ganderPickerView.backgroundColor = CommonMethods.SetColor.themeColor
        
        txtGander.inputView = ganderPickerView
        txtGander.keyboardToolbar.isHidden = true
        txtGander.keyboardAppearance = .default
        
        lblDescribed.font = CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
        lblDescribed.textColor = CommonMethods.SetColor.themeColor
        
        txtDescribed = CommonMethods.setCommonTextfield(getTextfield: txtDescribed)
        txtDescribed.font = CommonMethods.SetFont.RalewayRegular?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
        
        // Described Picker
        self.describedPickerView.delegate = self
        self.describedPickerView.dataSource = self
        self.describedPickerView.backgroundColor = CommonMethods.SetColor.themeColor
        
        txtDescribed.inputView = describedPickerView
        txtDescribed.keyboardToolbar.isHidden = true
        txtDescribed.keyboardAppearance = .default
        
        btnSave.titleLabel?.font =  CommonMethods.SetFont.MontserratBold?.withSize(CGFloat(CommonMethods.SetFontSize.S15))
        
    }
    
    // MARK: - Fetch animal from DB
    func fetchAnimal() {
        
        let getAnimal = databaseObj.fetchRecord(tableName: "Animal", whereCondition: "")
        
        for animalObj in getAnimal {
            
            if let getAnimals = animalObj as? NSDictionary {
                animalModelObj = AnimalModel(fromDictionary: getAnimals)
                arrayFavAnimal.append(animalModelObj)
            }
        }
        
        DispatchQueue.main.async(execute: {
            self.collectionAnimal.reloadData()
        })
    }
    
    // MARK: - Fetch country from DB
    func fetchCountry() {
        let getCountry = databaseObj.fetchRecord(tableName: "Country", whereCondition: "")
        
        for countryObj in getCountry {
            
            if let getCountries = countryObj as? NSDictionary {
                countryModelObj = CountryModel(fromDictionary: getCountries)
                arrayFavCountry.append(countryModelObj)
            }
        }
        
        DispatchQueue.main.async(execute: {
            self.collectionCountry.reloadData()
        })
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
            searchAnimal.resignFirstResponder()
        }
        
    }
    
    // MARK: - Country Search
    @IBAction func countrySearchAction(_ sender: Any) {
        
        if isCountrySearch == false {
            isCountrySearch = true
            searchCountryHeightCN.constant = 30
            searchCountry.becomeFirstResponder()
        } else {
            isCountrySearch = false
            searchCountryHeightCN.constant = 0
            searchCountry.resignFirstResponder()
        }
        
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtBirthday.text = formatter.string(from: birthdayPickerView.date)
    }
    
    // MARK: - Save
    @IBAction func saveAction(_ sender: Any) {
        
        /*
         user_id required
         user_password
         user_name
         user_email
         user_dob
         user_country int
         user_gander
         userfile
         user_fav_animal
         user_fav_country
         user_described_as
         */
        
        if (sharedObj?.isReachable)! {
            
            // if signup validation == true
            
            guard let getBirthday = txtBirthday.text else {
                return
            }
            
            guard let getCountry = txtCountry.text else {
                return
            }
            
            guard let getGander = txtGander.text else {
                return
            }
            
            guard let getDescribed = txtDescribed.text else {
                return
            }
            
            var strCountryID = ""
            for getCountryID in arraySelectedCountry {
                strCountryID += "&user_fav_country[]=\(getCountryID)"
            }
            
            var strAnimalID = ""
            for getAnimalID in arraySelectedAnimal {
                strAnimalID += "&user_fav_animal[]=\(getAnimalID)"
            }
            
            let strParameter = "user_id=\(3)&user_password=&user_name=&user_email=&user_dob=\(getBirthday)&user_country=\(3)&user_gander=\(getGander.lowercased())&userfile=&user_described_as=\(getDescribed)\(strCountryID)\(strAnimalID)"
            
            CommonMethods.showMBProgressHudView(self.view)
            
            let apiManagerObj = APIManager()
            apiManagerObj.delegate = self
            apiManagerObj.requestForURL(strUrl: APIList.strUserProfile, httpMethod: "post", parameters: strParameter, includeHeader: false, apiIdentifier: "ProfileAction")
            
        } else {
            CommonMethods.showAlert("", Description: AlertMessages.strAlertNetworkUnavailable as NSString)
        }
        
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
        if apiIdentifier == "ProfileAction" {
            print(response)
            CommonMethods.hideMBProgressHud()
        }
    }
    
    func apiResponseFail(response: NSDictionary, apiIdentifier: String) {
        
        if apiIdentifier == "ProfileAction" {
            CommonMethods.hideMBProgressHud()
        }
    }
    
    func apiResponseError(error: Error?, apiIdentifier: String) {
        
        if apiIdentifier == "ProfileAction" {
            CommonMethods.hideMBProgressHud()
            CommonMethods.showAlert("", Description: AlertMessages.strErrorAlert as NSString)
        }
    }
}

// MARK: - API Manager Delegate
extension SignupVC2: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == collectionAnimal {
            return arrayFavAnimal.count
        } else if collectionView == collectionCountry {
            return arrayFavCountry.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionAnimal {
            
            guard let animalCell: AnimalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Animal", for: indexPath) as? AnimalCell else {
                return UICollectionViewCell()
            }
            
            let animalDataDict = arrayFavAnimal[indexPath.row]
            animalCell.updateUI(animalData: animalDataDict)
            
            return animalCell
        } else {
            
            guard let countryCell: CountryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Country", for: indexPath) as? CountryCell else {
                return UICollectionViewCell()
            }
            
            let countryDataDict = arrayFavCountry[indexPath.row]
            countryCell.updateUI(countryData: countryDataDict)
            
            return countryCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionAnimal {
            
            if let animalCell: AnimalCell = collectionView.cellForItem(at: indexPath) as? AnimalCell {
                
                let animalDataDict = arrayFavAnimal[indexPath.row]
                
                if arraySelectedAnimal.contains(animalDataDict.getAnimalID) {
                    let deselectedAnimals = arraySelectedAnimal.filter { $0 != animalDataDict.getAnimalID }
                    arraySelectedAnimal = deselectedAnimals
                    
                    animalDataDict.getIsSelected = false
                } else {
                    arraySelectedAnimal.append(animalDataDict.getAnimalID)
                    animalDataDict.getIsSelected = true
                }
                
                animalCell.updateUI(animalData: animalDataDict)
            }
            
        } else {
            
            if let countryCell: CountryCell = collectionView.cellForItem(at: indexPath) as? CountryCell {
                
                let countryDataDict = arrayFavCountry[indexPath.row]
                
                if arraySelectedCountry.contains(countryDataDict.getCountryId) {
                    let deselectedCountry = arraySelectedCountry.filter { $0 != countryDataDict.getCountryId }
                    arraySelectedCountry = deselectedCountry
                    
                    countryDataDict.getIsSelected = false
                } else {
                    //arraySelectedCountry.append(indexPath.row)
                    arraySelectedCountry.append(countryDataDict.getCountryId)
                    countryDataDict.getIsSelected = true
                }
                print(arraySelectedCountry)
                countryCell.updateUI(countryData: countryDataDict)
            }
        }
    }
}

//MARK :- UIPickerView Delegate, DataSource
extension SignupVC2: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == countryPickerView {
            return arrayCountry.count
        } else if pickerView == ganderPickerView {
            return arrayGander.count
        } else {
            return arrayDeacribed.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if pickerView == countryPickerView {
            
            guard let attributedString: NSAttributedString = NSAttributedString(string: arrayCountry[row] as String, attributes: [NSAttributedStringKey.foregroundColor: CommonMethods.SetColor.whiteColor]) else {
                
                return NSAttributedString()
            }
            
            return attributedString
            
        } else if pickerView == ganderPickerView {
            
            guard let attributedString: NSAttributedString = NSAttributedString(string: arrayGander[row] as String, attributes: [NSAttributedStringKey.foregroundColor: CommonMethods.SetColor.whiteColor]) else {
                
                return NSAttributedString()
            }
            
            return attributedString
        } else {
            guard let attributedString: NSAttributedString = NSAttributedString(string: arrayDeacribed[row] as String, attributes: [NSAttributedStringKey.foregroundColor: CommonMethods.SetColor.whiteColor]) else {
                
                return NSAttributedString()
            }
            
            return attributedString
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == countryPickerView {
            txtCountry.text = arrayCountry[row]
        } else if pickerView == ganderPickerView {
            txtGander.text = arrayGander[row]
        } else {
            txtDescribed.text = arrayDeacribed[row]
        }
    }
    
}

// MARK :- UITextField Delegate
extension SignupVC2: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == txtBirthday {
            
            birthdayPickerView.datePickerMode = .date
            
            //ToolBar
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
            toolbar.backgroundColor = CommonMethods.SetColor.pickerBorderColor
            
            txtBirthday.inputAccessoryView = toolbar
            txtBirthday.inputView = birthdayPickerView
            
        } 
        return true
    }
    
}
