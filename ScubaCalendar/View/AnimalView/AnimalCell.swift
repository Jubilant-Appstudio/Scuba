//
//  AnimalCell.swift
//  ScubaCalendar
//
//  Created by Mahipalsinh on 10/29/17.
//  Copyright © 2017 CodzGarage. All rights reserved.
//

import UIKit
import Kingfisher

class AnimalCell: UICollectionViewCell {

    @IBOutlet weak var imgAnimal: UIImageView!
    @IBOutlet weak var lblAnimalName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgAnimal.alpha = 0.5
        
        lblAnimalName.font = CommonMethods.SetFont.RalewaySemiBold?.withSize(CGFloat(CommonMethods.SetFontSize.S12))
        lblAnimalName.textColor = CommonMethods.SetColor.darkGrayColor
        
    }

    func updateUI(animalData: AnimalModel) {
        
        lblAnimalName.text = animalData.getAnimalName
        
        imgAnimal.kf.indicatorType = .activity
        let urlAnimal = URL(string: APIList.strBaseUrl+animalData.getAnimalImg)!
        imgAnimal.kf.setImage(with: urlAnimal, placeholder: #imageLiteral(resourceName: "logo"))

        selectedCEllUI(isSelected: animalData.getIsSelected)
    }
    
    func selectedCEllUI(isSelected: Bool) {
        
        if isSelected == true {
            imgAnimal.alpha = 1.0
            
            lblAnimalName.font = CommonMethods.SetFont.RalewaySemiBold?.withSize(CGFloat(CommonMethods.SetFontSize.S17))
            lblAnimalName.textColor = CommonMethods.SetColor.whiteColor
        } else {
            imgAnimal.alpha = 0.5
            
            lblAnimalName.font = CommonMethods.SetFont.RalewaySemiBold?.withSize(CGFloat(CommonMethods.SetFontSize.S12))
            lblAnimalName.textColor = CommonMethods.SetColor.darkGrayColor
        }
        
    }
    
}
