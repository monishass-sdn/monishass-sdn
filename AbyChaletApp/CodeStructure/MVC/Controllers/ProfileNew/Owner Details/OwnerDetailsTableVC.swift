//
//  OwnerDetailsTableVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 30/12/21.
//

import UIKit
import SDWebImage
import SVProgressHUD

class OwnerDetailsTableVC: UITableViewController {
    
    //MARK: cellProfile
    @IBOutlet weak var imgViewForProfile: UIImageView!
    @IBOutlet weak var imgViewProfilePic: UIImageView!
    @IBOutlet weak var lblForUserName: UILabel!
    @IBOutlet weak var lblForMobileNum: UILabel!
    @IBOutlet weak var lblForEmailId: UILabel!
    
    @IBOutlet weak var viewForTopUserDetails: UIView!
    @IBOutlet weak var viewForBottomBankDetails: UIView!
    var arrayAdminDetails = [Admin_details]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAdminDetails()
        self.setUpNavigationBar()
        setupForCustomNavigationTitle()
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setValuesToFields()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewForTopUserDetails.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        viewForBottomBankDetails.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
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
        let navTitle = NSMutableAttributedString(string: "Owner", attributes:[
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    //MARK:- Button Actions
    
    @IBAction func btnCivilID_Tapped(_ sender: UIButton!) {
        let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "CivilIDVC") as! CivilIDVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func btnChaletownership_Tapped(_ sender: UIButton!) {
        let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "chaletOwnershipVC") as! chaletOwnershipVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func btnAgreement_Tapped(_ sender: UIButton!) {
        let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "agreementVC") as! agreementVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func btnBankDetails_Tapped(_ sender: UIButton!) {
        let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "BankDetailsVC") as! BankDetailsVC
        navigationController?.pushViewController(nextVC, animated: true)
    }


   

}

extension OwnerDetailsTableVC {
   
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
}

extension OwnerDetailsTableVC{
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
}
