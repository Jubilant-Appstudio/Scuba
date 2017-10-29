//
//  ScubaTabbar.swift
//  ScubaCalendar
//
//  Created by Mahipalsinh on 10/29/17.
//  Copyright © 2017 CodzGarage. All rights reserved.
//

import UIKit

class ScubaTabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    func setupUI() {
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: CommonMethods.SetColor.whiteColor], for: .normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: CommonMethods.SetColor.whiteColor], for: .selected)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
