//
//  addNewOfferVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 03/01/22.
//

import UIKit
import SVProgressHUD

class addNewOfferVC: UIViewController {
    
    @IBOutlet weak var BtnaddNewOffer: UIButton!
    @IBOutlet weak var addOfferTableView: UITableView!
    @IBOutlet weak var lblthereisnoOffer: UILabel!
    
    var arryAvailableOfferList = [Available_Offer_list]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAvailableOffers()
        self.setUpNavigationBar()
        self.addOfferTableView.isHidden = false
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
    }

    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Add Offers".localized()

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
    
    //MARK:- Button Actions
    
 /*   @objc func addnewOffer(sender: UIButton){
        showDefaultAlert(viewController: self, title: "", msg: "Coming soooooon")
    }*/
    
    @IBAction func TappedonAddNewOffer(_ sender:UIButton){
        let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "CreateOfferWeekTypeSelection_VC") as! CreateOfferWeekTypeSelection_VC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

extension addNewOfferVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
            //return self.arryAvailableOfferList.count
        }else{
            return self.arryAvailableOfferList.count
            //return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableOffersTVCell", for: indexPath) as! AvailableOffersTVCell
            cell.setValuesToFields(dict: arryAvailableOfferList[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNewOfferTVCell", for: indexPath) as! addNewOfferTVCell
           // cell.btnAddNewOffer.addTarget(self, action: #selector(addnewOffer(sender:)), for: .touchUpInside)
            return cell
        }
       
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "AddOffertoChaletVC") as! AddOffertoChaletVC
            nextVC.dictOfferData = self.arryAvailableOfferList[indexPath.row]
            nextVC.offerid = "\(self.arryAvailableOfferList[indexPath.row].id!)"
            self.navigationController?.pushViewController(nextVC, animated: true)
        }else{
            print("Clicked on IndexPath 1")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 140
        }else{
            return 65
        }
    }
    
    
}

extension addNewOfferVC {
    func getAvailableOffers() {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/available_offers", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : ""], withHud: true) { (success, response, error) in
            self.checkNotificationCount()
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = AvailableOffersModel(dictionary: response as! NSDictionary)
                    self.arryAvailableOfferList = (responseBase?.offer_list)!
                    self.BtnaddNewOffer.isHidden = true
                    self.lblthereisnoOffer.isHidden = true
                    if self.arryAvailableOfferList.count <= 0{
                        self.addOfferTableView.isHidden = true
                        self.BtnaddNewOffer.isHidden = true
                        self.lblthereisnoOffer.isHidden = false
                        self.lblthereisnoOffer.text = "There are no offer's available."
                    }
                    DispatchQueue.main.async {
                        self.addOfferTableView.reloadData()
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
