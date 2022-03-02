//
//  TimerEndVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 02/03/22.
//

import UIKit

class TimerEndVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Rejected".localized()
        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @IBAction func tapped_TryAgain(_ sender: UIButton){
        showDefaultAlert(viewController: self, title: "", msg: "WORK IN PROGRESS")
    }

}
