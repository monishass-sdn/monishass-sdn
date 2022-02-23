//
//  agreementVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 30/12/21.
//

import UIKit
import SVProgressHUD

class agreementVC: UIViewController {
    @IBOutlet weak var imageAgreement:UIImageView!
    
    var arrayOwnerInfo : Owner_details?
    var imageURLStored = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAgreement()
        self.setUpNavigationBar()
        self.setupForCustomNavigationTitle()
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
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
        let navTitle = NSMutableAttributedString(string: "Agreement", attributes:[
                                                    NSAttributedString.Key.foregroundColor: UIColor.white,
                                                    NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 25)! ])

        navTitle.append(NSMutableAttributedString(string: "", attributes:[
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

extension agreementVC {
        
        func getAgreement() {
           //["userid":CAUser.currentUser.id!]
            SVProgressHUD.show()
            self.view.isUserInteractionEnabled = false
            ServiceManager.sharedInstance.postMethodAlamofire("api/owner_details", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : ""], withHud: true) { (success, response, error) in
                self.checkNotificationCount()
                if success {
                    if ((response as! NSDictionary) ["status"] as! Bool) == true {
                        let responseBase = OwnerInfoBase(dictionary: response as! NSDictionary)
                        self.arrayOwnerInfo = (responseBase?.owner_details)!
                        self.imageURLStored = (responseBase?.owner_details?.agreement)!
                        print(self.imageURLStored)
                        if self.arrayOwnerInfo?.agreement != ""{
                            self.imageAgreement.sd_setImage(with: URL(string: (self.arrayOwnerInfo?.agreement!)!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
                        }else{
                            self.imageAgreement.image = kPlaceHolderImage
                        }
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




