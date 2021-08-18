//
//  PaymentFailedTVC.swift
//  AbyChaletApp
//
//  Created by Visakh Srishti on 17/08/21.
//

import UIKit

class PaymentFailedTVC: UITableViewController {

    @IBOutlet weak var viewBg: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewBg.addCornerForView(cornerRadius: 10)
        self.setUpNavigationBar()
       
    }

    //MARK:- SetUp NavigationBar
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
       
        let notificationButton = UIBarButtonItem(image: Images.kIconNotification, style: .plain, target: self, action: #selector(notificationButtonTouched))
        self.navigationItem.rightBarButtonItems = [notificationButton]
        self.navigationItem.title = "Payment Failed"
        
    }
    //MARK:- ButtonActions
    @objc func notificationButtonTouched()  {
        
        
    }
}
