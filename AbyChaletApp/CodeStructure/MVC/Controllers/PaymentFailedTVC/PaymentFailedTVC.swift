//
//  PaymentFailedTVC.swift
//  AbyChaletApp
//
//  Created by Visakh Srishti on 17/08/21.
//

import UIKit

class PaymentFailedTVC: UITableViewController {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblPaymentFailed: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewBg.addCornerForView(cornerRadius: 10)
        self.setUpNavigationBar()
        lblPaymentFailed.text = "Payment is failed, Please try again!".localized()
        
        if kCurrentLanguageCode == "ar"{
            lblPaymentFailed.font = UIFont(name: kFontAlmaraiRegular, size: 15)
        }else{
            lblPaymentFailed.font = UIFont(name: "Roboto-Regular", size: 15)
        }
       
    }

    override func viewWillAppear(_ animated: Bool) {
        self.checkNotificationCount()
    }
    //MARK:- SetUp NavigationBar
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let notificationButton = UIBarButtonItem(image: Images.kIconNotification, style: .plain, target: self, action: #selector(notificationButtonTouched))
       // self.navigationItem.rightBarButtonItems = [notificationButton]
        
        let backButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(BackButtonTouched))
        self.navigationItem.leftBarButtonItems = [backButton]
        self.navigationItem.title = "Payment Failed"
        
    }
    //MARK:- ButtonActions
    @objc func notificationButtonTouched()  {
        
        
    }
    @objc func BackButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func checkNotificationCount() {
        if CAUser.currentUser.id != nil {
            ServiceManager.sharedInstance.postMethodAlamofire("api/notification_count", dictionary: ["userid": CAUser.currentUser.id!], withHud: true) { (success, response, error) in
                if success {
                    let messageCount = ((response as! NSDictionary)["message_count"] as! Int)
                    kNotificationCount = messageCount
                    let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
                    self.navigationItem.rightBarButtonItems = [notificationButton]
                }
            }
        }
    }
    @objc func didMoveToNotification(){
        
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
}
