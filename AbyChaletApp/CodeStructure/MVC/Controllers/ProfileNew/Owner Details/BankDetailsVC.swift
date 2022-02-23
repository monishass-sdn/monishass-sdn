//
//  BankDetailsVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 30/12/21.
//

import UIKit
import SVProgressHUD

class BankDetailsVC: UIViewController {
    
    @IBOutlet weak var ViewBg: UIView!
    @IBOutlet weak var tfAccountHolderName: UITextField!
    @IBOutlet weak var tfBankName: UITextField!
    @IBOutlet weak var tfIBANNumber: UITextField!

    var arrayOwnerInfo : Owner_details?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBankDetailst()
        self.setUpNavigationBar()
        self.setupForCustomNavigationTitle()
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
        //ViewBg.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        //ViewBg.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
        // Do any additional setup after loading the view.
    }
    
    //MARK:- SetUp NavigationBar
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
        let notificationButton = UIBarButtonItem(image: Images.kIconNotification, style: .plain, target: self, action: #selector(notificationButtonTouched))
        //self.navigationItem.rightBarButtonItems = [notificationButton]
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    
    func setupForCustomNavigationTitle(){

        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "Bank", attributes:[
                                                    NSAttributedString.Key.foregroundColor: UIColor.white,
                                                    NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 25)! ])

        navTitle.append(NSMutableAttributedString(string: " Details", attributes:[
                                                    NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 25)! ,
                                                    NSAttributedString.Key.foregroundColor: UIColor.white]))

        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
    }
    
    @objc func didMoveToNotification(){
        
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
    
    @objc func backButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func notificationButtonTouched()  {
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BankDetailsVC {
        
        func getBankDetailst() {
           //["userid":CAUser.currentUser.id!]
            SVProgressHUD.show()
            self.view.isUserInteractionEnabled = false
            ServiceManager.sharedInstance.postMethodAlamofire("api/owner_details", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : ""], withHud: true) { (success, response, error) in
                self.checkNotificationCount()
                if success {
                    if ((response as! NSDictionary) ["status"] as! Bool) == true {
                        let responseBase = OwnerInfoBase(dictionary: response as! NSDictionary)
                        self.arrayOwnerInfo = (responseBase?.owner_details)!
                        self.tfBankName.text = self.arrayOwnerInfo?.bank_name
                        self.tfAccountHolderName.text = self.arrayOwnerInfo?.bank_holder_name
                        self.tfIBANNumber.text = self.arrayOwnerInfo?.iban_num
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                            self.view.isUserInteractionEnabled = true
                        }
                    }else{
                        showDefaultAlert(viewController: self, title: "", msg: response!["message"]! as! String)
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "", msg: "Failed..!")
                }
            }
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

    }




