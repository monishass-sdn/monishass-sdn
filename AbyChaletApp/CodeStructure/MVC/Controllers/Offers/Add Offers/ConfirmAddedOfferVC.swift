//
//  ConfirmAddedOfferVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 17/01/22.
//

import UIKit
import SVProgressHUD

class ConfirmAddedOfferVC: UIViewController {
    
    @IBOutlet weak var selectedOfferdChaletTV : UITableView!
    var offerAppliedChaletLists = [Offered_Chalet_details]()
    var selectedOfferedChaletData = [Inserted_offered_chalets]()
    var dictOfferData : Available_Offer_list?
    var offerid = 0
    var userid = CAUser.currentUser.id!
    var token_id = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        // Do any additional setup after loading the view.
    }
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Confirm the Offer".localized()

        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
        let notificationButton = UIBarButtonItem(image: Images.kIconNotification, style: .plain, target: self, action: #selector(notificationButtonTouched))
        //self.navigationItem.rightBarButtonItems = [notificationButton]
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    @objc func backButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func notificationButtonTouched()  {
        
        
    }
    @objc func didMoveToNotification(){
        
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
    
    @IBAction func tapped_ConfirmBtn(_ sender: UIButton){
        confirmOffer()
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

extension ConfirmAddedOfferVC : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else{
            return offerAppliedChaletLists.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "showSelectedOfferTVCell", for: indexPath) as! showSelectedOfferTVCell
            cell.lblcheckin.text = dictOfferData?.check_in
            cell.lblcheckout.text = dictOfferData?.check_out
            cell.setValuesToFields(dict: dictOfferData!)
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "confirmaddedOfferChaletTVCell", for: indexPath) as! confirmaddedOfferChaletTVCell
            cell.setValuesToFields(dict: offerAppliedChaletLists[indexPath.row])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 120
        }else if indexPath.section == 2{
            return 275
        }else{
            return 64
        }
    }
    
}

extension ConfirmAddedOfferVC{
    //MARK:- Confirm Offer
    
    func confirmOffer() {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/confirm-offer", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : "","tokenid":token_id], withHud: true) { (success, response, error) in
            self.checkNotificationCount()
            if success {
                print(response)
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    
                    let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "OwnerAddOfferSuccessVC") as! OwnerAddOfferSuccessVC
                    self.navigationController?.pushViewController(nextVC, animated: true)
                    
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.view.isUserInteractionEnabled = true
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "Alert", msg: response!["message"]! as! String)
                }
            }else{
                showDefaultAlert(viewController: self, title: "Alert", msg: "Request Failed..!")
            }
        }
    }
}
