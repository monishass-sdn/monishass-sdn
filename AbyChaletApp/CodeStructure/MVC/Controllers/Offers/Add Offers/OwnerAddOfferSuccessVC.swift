//
//  OwnerAddOfferSuccessVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 24/02/22.
//

import UIKit

class OwnerAddOfferSuccessVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        
        // Do any additional setup after loading the view.
    }
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Offer is Confirmed".localized()
        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @IBAction func tapped_goToTry(_ sender: UIButton){
        self.navigationController?.popToRootViewController(animated: true)
    }

}
