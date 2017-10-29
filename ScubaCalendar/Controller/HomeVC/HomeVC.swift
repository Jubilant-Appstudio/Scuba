//
//  HomeVC.swift
//  ScubaCalendar
//
//  Created by Mahipalsinh on 10/29/17.
//  Copyright © 2017 CodzGarage. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {
            return
        }
        
        CommonMethods.showViewControllerWith(storyboard: "Main", newViewController: loginVC, usingAnimation: .ANIMATERIGHT)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
