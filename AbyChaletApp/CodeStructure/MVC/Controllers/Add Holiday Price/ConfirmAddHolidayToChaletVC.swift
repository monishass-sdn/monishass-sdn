//
//  ConfirmAddHolidayToChaletVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 08/03/22.
//

import UIKit
import SVProgressHUD

class ConfirmAddHolidayToChaletVC: UIViewController {
    
    var eventAppliedChaletLists = [Inserted_Holiday_chalets]()
    var dictEventData : Holi_event_list?
    var eventAppliedToken = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        print("event check in = \(dictEventData?.check_in)")
        print("Token = \(eventAppliedToken)")
    }
    

    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Confirm holiday prices".localized()
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
    
    @IBAction func tapped_ConfirmBtn(_ sender: UIButton!){
        confirmHolidayPriceForChalets()
    }

}

extension ConfirmAddHolidayToChaletVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else{
            return self.eventAppliedChaletLists.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HolidayEventListTVCell", for: indexPath) as! HolidayEventListTVCell
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmedHolidayPriceChaletListTVCell", for: indexPath) as! ConfirmedHolidayPriceChaletListTVCell
            cell.setValuesToFields(dict: eventAppliedChaletLists[indexPath.row])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "confirmHolidayMiddleCell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        }else if indexPath.section == 1{
            return 65
        }else{
            return 280
        }
    }
    
    
}

extension ConfirmAddHolidayToChaletVC{
  
    func confirmHolidayPriceForChalets() {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/confirmHolidays", dictionary: ["token":eventAppliedToken], withHud: true) { (success, response, error) in
            if success {
                print(response)
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    
                    let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "ConfirmHolidayPriceChaletSuccessVC") as! ConfirmHolidayPriceChaletSuccessVC
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
