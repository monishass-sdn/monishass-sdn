//
//  ConfirmSeasonPriceVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 09/03/22.
//

import UIKit
import SVProgressHUD

class ConfirmSeasonPriceVC: UIViewController {

    var seasonStartDate = ""
    var seasonEndDate = ""
    var confirmedToken = ""
    var arrayconfirmedChalets = [SeasonPriceAdded_Chalet_details]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        // Do any additional setup after loading the view.
    }
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Add Season price to chalet"
        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    @objc func backButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didMoveToNotification(){
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }

}

extension ConfirmSeasonPriceVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else{
            return arrayconfirmedChalets.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonDateTVCell", for: indexPath) as! SeasonDateTVCell
            cell.lblEnd_season.text = seasonEndDate
            cell.lblStart_season.text = seasonStartDate
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonPriceAddedChaletListTVCell", for: indexPath) as! SeasonPriceAddedChaletListTVCell
            cell.setValuesToFields(dict: arrayconfirmedChalets[indexPath.row])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "confirmseasonPriceMiddleCell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 120
        }else if indexPath.section == 1{
            return 65
        }else{
            return 400
        }
    }
    
    @IBAction func tapped_ConfirmBtn(_ sender: UIButton!){
        confirmSeasonPriceForChalets()
    }
    
    
}

extension ConfirmSeasonPriceVC{
  
    func confirmSeasonPriceForChalets() {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/confirm-season-price", dictionary: ["token":confirmedToken], withHud: true) { (success, response, error) in
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    
                    let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "ConfirmSeasonPriceSuccessVC") as! ConfirmSeasonPriceSuccessVC
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
