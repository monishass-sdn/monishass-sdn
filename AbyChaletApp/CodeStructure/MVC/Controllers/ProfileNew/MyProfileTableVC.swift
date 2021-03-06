//
//  MyProfileTableVC.swift
//  AbyChaletApp
//
//  Created by TEJASWINI KADAM on 18/05/21.
//

import UIKit
import SDWebImage
import SVProgressHUD

class MyProfileTableVC: UITableViewController {
    
    //MARK: cellProfile
    @IBOutlet weak var imgViewForProfile: UIImageView!
    @IBOutlet weak var lblForUserName: UILabel!
    @IBOutlet weak var lblForMobileNum: UILabel!
    @IBOutlet weak var lblForEmailId: UILabel!
    
    
    @IBOutlet weak var btnForMyAccount: UIButton!
    @IBOutlet weak var lblForMyAccount: UILabel!
    
    @IBOutlet weak var btnForChangePassword: UIButton!
    @IBOutlet weak var lblChangePassword: UILabel!
    
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var lblNotification: UILabel!
    
    @IBOutlet weak var lblInviteFriends: UILabel!
    @IBOutlet weak var btnInviteFriends: UIButton!
    
    @IBOutlet weak var btnContactUs: UIButton!
    @IBOutlet weak var lblContactUs: UILabel!
    
    @IBOutlet weak var btnShareApp: UIButton!
    @IBOutlet weak var lblForShareApp: UILabel!
    
    @IBOutlet weak var btnAddChalet: UIButton!
    @IBOutlet weak var lblForAddChalet: UILabel!
    
    @IBOutlet weak var btnInstaGram: UIButton!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var btnLegalPrivacy: UIButton!
    @IBOutlet weak var viewForTopUserDetails: UIView!
    @IBOutlet weak var imgViewProfilePic: UIImageView!
    
    @IBOutlet weak var viewForBottomAddYourChalet: UIView!
    @IBOutlet weak var viewForBottomFAQ: UIView!
    @IBOutlet weak var notificationCount: UILabel!
    @IBOutlet weak var viewNotificationcount: UIView!
    @IBOutlet weak var btnOwnerTap: UIButton!
    @IBOutlet weak var heightForInstagramView : NSLayoutConstraint!
    
    @IBOutlet weak var viewOwnerMYchalet : UIView!
    @IBOutlet weak var viewOwner : UIView!
    @IBOutlet weak var viewMychalet: UIView!
    @IBOutlet weak var widthofViewOwner : NSLayoutConstraint!
    @IBOutlet weak var widthofViewMyChalet : NSLayoutConstraint!
    
    var arrayAdminDetails = [Admin_details]()
    var notiCount : Int = 0
    var Deviceheight : CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        getNotificationcount()
        
        
        
        if kCurrentLanguageCode == "ar"{
            btnLogOut.titleLabel?.font = UIFont(name: kFontAlmaraiRegular, size: 15)!
            btnLegalPrivacy.titleLabel?.font = UIFont(name: kFontAlmaraiRegular, size: 15)!
            self.lblForMyAccount.font = UIFont(name: kFontAlmaraiRegular, size: 15)!
            self.lblChangePassword.font = UIFont(name: kFontAlmaraiRegular, size: 15)!
            self.lblNotification.font = UIFont(name: kFontAlmaraiRegular, size: 15)!
            self.lblInviteFriends.font = UIFont(name: kFontAlmaraiRegular, size: 15)!
            self.lblContactUs.font = UIFont(name: kFontAlmaraiRegular, size: 15)!
            self.lblForShareApp.font = UIFont(name: kFontAlmaraiRegular, size: 15)!
            self.lblForAddChalet.font = UIFont(name: kFontAlmaraiRegular, size: 15)!
        }else{
            //Roboto-Medium 15.0
            btnLogOut.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 15)!
            btnLegalPrivacy.titleLabel?.font = UIFont(name: "Roboto-Light", size: 15)!
            
        }
        self.lblForMyAccount.text = "My Account".localized()
        self.lblChangePassword.text  = "Change Password".localized()
        self.lblNotification.text  = "Notifications".localized()
        self.lblInviteFriends.text  = "Invite friend".localized()
        self.lblContactUs.text  = "Contact Us WhatsApp".localized()
        self.lblForShareApp.text  = "Share App".localized()
        self.lblForAddChalet.text  = "Add your Chalet".localized()
        self.btnLegalPrivacy.setTitle("Legal & Privacy".localized(), for: .normal)
        self.btnLogOut.setTitle("LOG OUT".localized(), for: .normal)
        self.getAdminDetails()
        NotificationCenter.default.addObserver(self, selector: #selector(logoutUser), name: NSNotification.Name(rawValue: NotificationNames.kBlockedUser), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkNotiCount), name: NSNotification.Name(rawValue: NotificationNames.KNotificationCountCheck), object: nil)
        
        let bounds = UIScreen.main.bounds
        Deviceheight = bounds.size.height
        
        if Deviceheight > 800 {
            heightForInstagramView.constant = 100
        }else{
            heightForInstagramView.constant = 70
        }
        
        let ownerAndmyChaletWidth = UIScreen.main.bounds.width - 40
        widthofViewOwner.constant = (ownerAndmyChaletWidth / 2) - 0.5
        widthofViewMyChalet.constant = (ownerAndmyChaletWidth / 2) - 0.5
        
    }
    
    
    
    
    @objc func logoutUser() {
        appDelegate.logOut()
    }
    
    @objc func checkNotiCount() {
        getNotificationcount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // self.tabBarController?.tabBar.isHidden = false
      //  self.navigationItem.setHidesBackButton(true, animated: true)
        self.setValuesToFields()
        NotificationCenter.default.addObserver(self, selector: #selector(checkNotiCount), name: NSNotification.Name(rawValue: NotificationNames.KNotificationCountCheck), object: nil)
        getNotificationcount()
        appDelegate.checkBlockStatus()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewForTopUserDetails.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
       // if CAUser.currentUser.userstatus != "owner"{
            viewForBottomFAQ.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
       // }else{
       //     viewForBottomAddYourChalet.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
      //  }
        
    }
    
    @IBAction func btnForMyAccountDidTap(_ sender: Any) {
        let myAccountTVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "MyAccountTVC") as! MyAccountTVC
        myAccountTVC.country = CAUser.currentUser.country ?? ""
        navigationController?.pushViewController(myAccountTVC, animated: true)
        
    }
    
    @IBAction func btnChangePasswordDidTap(_ sender: Any) {
        let changePasswordTVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "ChangePasswordTVC") as! ChangePasswordTVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
    
    @IBAction func btnNotificationDidTap(_ sender: Any) {
        let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        nextVC.isFromProfile = true
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnInviteFriendDidTap(_ sender: Any) {
        let changePasswordTVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "InviteAFriendTVC") as! InviteAFriendTVC
        if arrayAdminDetails.count > 0{
            changePasswordTVC.inviteFriendUrl = (arrayAdminDetails.first?.invite_friend!)!
        }
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
    
    @IBAction func btnContactUsDidTap(_ sender: Any) {
        let contactUSVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "ContactUSVC") as! ContactUSVC
        navigationController?.pushViewController(contactUSVC, animated: true)
    }
    
    @IBAction func btnShareDidTap(_ sender: Any) {
        
        if arrayAdminDetails.count > 0{
            /* if let name = URL(string: (arrayAdminDetails.first?.invite_friend!)!), !name.absoluteString.isEmpty {
             let objectsToShare = [name]
             let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
             self.present(activityVC, animated: true, completion: nil)
             } else {
             // show alert for not available
             }*/
            let activityController = UIActivityViewController(activityItems: [(arrayAdminDetails.first?.invite_friend!)!], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnAddChaletDidTap(_ sender: Any) {
        /*guard let url = URL(string: "https://web.sicsglobal.com/aby_chalet/adminmail") else { return }
         UIApplication.shared.open(url)*/
        
        let addNewChaletVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "AddNewChaletVC") as! AddNewChaletVC
        navigationController?.pushViewController(addNewChaletVC, animated: true)
    }
    
    @IBAction func btnFAQsDidTap(_ sender: Any) {
      let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "FAQsViewController") as! FAQsViewController
        navigationController?.pushViewController(nextVC, animated: true)

    }
    
    @IBAction func btnInstagramDidTap(_ sender: Any) {
        
        if self.arrayAdminDetails.count > 0 {
            let Username =  self.arrayAdminDetails.first!.insta_url! // Your Instagram Username here
            let appURL = URL(string: "instagram://user?username=\(Username)")!
            let application = UIApplication.shared
            if application.canOpenURL(appURL) {
                application.open(appURL)
            } else {
                // if Instagram app is not installed, open URL inside Safari
                let webURL = URL(string: "https://instagram.com/\(Username)")!
                application.open(webURL)
            }
        }
    }
    
    @IBAction func Owner_Tapped(_ sender: Any) {
        let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "OwnerDetailsTableVC") as! OwnerDetailsTableVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func MyChalet_Tapped(_ sender: Any) {
        let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "myChaletVC") as! myChaletVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func btnLogOutDidTap(_ sender: Any) {
        
        let alert = UIAlertController(title: "Message", message: "Are you sure you want to logout?".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            UserDefaults.standard.removeObject(forKey: "kCurrentUserDetails")
            appDelegate.logOut()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnLegalPrivacyDidTap(_ sender: Any) {
        
        if self.arrayAdminDetails.count > 0 {
            let termsAndConditionsVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "TermsAndConditionVC") as! TermsAndConditionVC
            termsAndConditionsVC.UrlString = self.arrayAdminDetails.first!.legal_privacy!
            let vc = UINavigationController(rootViewController: termsAndConditionsVC)
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1 {
            if CAUser.currentUser.userstatus == "owner" {
                return super.tableView(tableView, heightForRowAt: indexPath)
            }else{
                return 0
            }
        }
        
        if indexPath.row == 9 {
            if CAUser.currentUser.userstatus != "owner" {
                return super.tableView(tableView,heightForRowAt: indexPath)
            }else{
                return super.tableView(tableView,heightForRowAt: indexPath)
            }
        }
        
        if indexPath.row == 10 {
            if self.Deviceheight > 890 {
                return 90
            }else{
                return 60
            }
        }
        
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
}
// MARK: - Table view data source
extension MyProfileTableVC {
   
    func setValuesToFields() {
        self.imgViewForProfile.image = #imageLiteral(resourceName: "Icn_UserProfileImage")
        self.lblForUserName.text = "\(CAUser.currentUser.first_name!) \(CAUser.currentUser.last_name!)"
        self.lblForMobileNum.text = "\(CAUser.currentUser.country_code!)-\(CAUser.currentUser.phone!) - \(CAUser.currentUser.country ?? "")"
        self.lblForEmailId.text = CAUser.currentUser.email!
        
        if CAUser.currentUser.profile_pic != nil{
            if CAUser.currentUser.profile_pic != "" {
                self.imgViewProfilePic.sd_setImage(with: URL(string: CAUser.currentUser.profile_pic!), placeholderImage: kPlaceHolderImage, options: .highPriority) { image, error, cache, url in
                    if image != nil{
                        self.imgViewProfilePic.image = image
                    }else{
                        self.imgViewProfilePic.image = CAUser.currentUser.gender == "Female" ? kFemalePlaceHolderImage : kMalePlaceHolderImage
                    }
                }
            }else{
                self.imgViewProfilePic.image = CAUser.currentUser.gender == "Female" ? kFemalePlaceHolderImage : kMalePlaceHolderImage
            }
            
        }else{
            self.imgViewProfilePic.image = CAUser.currentUser.gender == "Female" ? kFemalePlaceHolderImage : kMalePlaceHolderImage
        }
    }
}
extension MyProfileTableVC {
    func getAdminDetails() {
        ServiceManager.sharedInstance.postMethodAlamofire("api/view_admin", dictionary: nil, withHud: true) { [self] (success, response, error) in
           
            if success {
                if response!["status"] as! Bool == true {
                    
                    let jsonBase = AdminDetailsBase(dictionary: response as! NSDictionary)
                    self.arrayAdminDetails = (jsonBase?.admin_details)!
                    
                }else{
                    showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Failed...!")
                }
            }else{
                showDefaultAlert(viewController: self, title: "Message".localized(), msg: error!.localizedDescription)
            }
        }
    }
    
    
    func getNotificationcount(){
        
        if CAUser.currentUser.id != nil {
            SVProgressHUD.show()
            ServiceManager.sharedInstance.postMethodAlamofire("api/notification_count", dictionary: ["userid": CAUser.currentUser.id!], withHud: true) { (success, response, error) in
                if success {
                    let messageCount = ((response as! NSDictionary)["message_count"] as! Int)
                    self.notiCount = messageCount
                    if self.notiCount == 0 {
                        self.viewNotificationcount.isHidden = true
                    }else{
                        self.notificationCount.text = String(self.notiCount)
                        self.viewNotificationcount.isHidden = false
                    }
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
}
