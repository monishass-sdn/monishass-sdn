//
//  ConfirmSeasonPriceSuccessVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 09/03/22.
//

import UIKit

class ConfirmSeasonPriceSuccessVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        // Do any additional setup after loading the view.
    }
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Season price is confirmed"
        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    
    @IBAction func tapped_GoTryIt(_ sender: UIButton!){
        let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "PackageListViewController") as! PackageListViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }


}
