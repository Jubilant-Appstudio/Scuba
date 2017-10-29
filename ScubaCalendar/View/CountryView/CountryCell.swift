//
//  CountryCell.swift
//  ScubaCalendar
//
//  Created by Mahipalsinh on 10/29/17.
//  Copyright © 2017 CodzGarage. All rights reserved.
//

import UIKit
import Kingfisher

class CountryCell: UICollectionViewCell {

    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var lblCountryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgCountry.alpha = 0.5
        
        lblCountryName.font = CommonMethods.SetFont.RalewaySemiBold?.withSize(CGFloat(CommonMethods.SetFontSize.S12))
        lblCountryName.textColor = CommonMethods.SetColor.darkGrayColor
    }
    
    func updateUI(countryData: CountryModel) {
        
        lblCountryName.text = countryData.getCountryName
        
        imgCountry.kf.indicatorType = .activity
        let urlAnimal = URL(string: APIList.strBaseUrl+countryData.getCountryMap)!
        imgCountry.kf.setImage(with: urlAnimal, placeholder: #imageLiteral(resourceName: "logo"))
        
        selectedCEllUI(isSelected: countryData.getIsSelected)
    }
    
    func selectedCEllUI(isSelected: Bool) {
        
        if isSelected == true {
            imgCountry.alpha = 1.0
            
            lblCountryName.font = CommonMethods.SetFont.RalewaySemiBold?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
            lblCountryName.textColor = CommonMethods.SetColor.whiteColor
        } else {
            imgCountry.alpha = 0.5
            
            lblCountryName.font = CommonMethods.SetFont.RalewaySemiBold?.withSize(CGFloat(CommonMethods.SetFontSize.S12))
            lblCountryName.textColor = CommonMethods.SetColor.darkGrayColor
        }
        
    }

}
