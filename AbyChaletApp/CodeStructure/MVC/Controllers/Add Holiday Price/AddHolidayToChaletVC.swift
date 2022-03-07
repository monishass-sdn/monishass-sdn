//
//  AddHolidayToChaletVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 07/03/22.
//

import UIKit
import SVProgressHUD

class AddHolidayToChaletVC: UIViewController {
    @IBOutlet weak var addholidaytoChaletTV : UITableView!
    var dictEventData : Holi_event_list?
    var arrayHolidayChalet_List = [HolidayEventChaletList]()
    
    var toggledIndexes = [Int:Bool]()
    var isToggled = false
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        getHolidayAndEvent_Chalets()
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Add holiday price to chalet".localized()
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

extension AddHolidayToChaletVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 2{
            return arrayHolidayChalet_List.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HolidayEventListTVCell", for: indexPath) as! HolidayEventListTVCell
            cell.lblEvent_name.text = self.dictEventData?.event_name
            cell.lblcheck_in.text = self.dictEventData?.check_in
            cell.lblcheck_out.text = self.dictEventData?.check_out
            return cell
        }else if indexPath.section == 2{
            if arrayHolidayChalet_List[indexPath.row].isOffer == false{
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddHolidayToChaletTVCell", for: indexPath) as! AddHolidayToChaletTVCell
                cell.setValuesToFields(dict: arrayHolidayChalet_List[indexPath.row])
                cell.btnCheckBox.tag = indexPath.row
                cell.btnCheckBox.addTarget(self, action: #selector(TapCheckbox), for: .touchUpInside)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddHolidayToChaletOfferAlreadyAppliedTVCell", for: indexPath) as! AddHolidayToChaletOfferAlreadyAppliedTVCell
                return cell
            }

        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 120
        }else if indexPath.section == 2{
            if arrayHolidayChalet_List[indexPath.row].isOffer == false{
                if toggledIndexes[indexPath.row] == true{
                    return 275.0
                }else{
                    return 184.0
                }
            }else{
                return 184
            }

        }else{
            return 65
        }
    }
    
    @objc func TapCheckbox(_ sender: UIButton!){
        let indexpath = IndexPath(row: sender.tag, section: 2)
        sender.isSelected = !sender.isSelected
        let cell = addholidaytoChaletTV.cellForRow(at: indexpath) as! AddHolidayToChaletTVCell
        if sender.isSelected == true{
            toggledIndexes[sender.tag] = true
           // ArrayselectedItem.append(item)
          //  self.selectedIndex = sender.tag
          //  self.isToggled = true
            cell.heightForHolidayPriceView.constant = 100
        }else{
            toggledIndexes[sender.tag] = false
           /* for (i,selectedItem) in ArrayselectedItem.enumerated(){
                if selectedItem.chalet_id! == item.chalet_id!{
                    ArrayselectedItem.remove(at: i)
                }
            }*/
            self.selectedIndex = -1
           // self.isToggled = false
            cell.heightForHolidayPriceView.constant = 0

        }
        self.addholidaytoChaletTV.reloadData()
    }
    
    
}

extension AddHolidayToChaletVC{
    func getHolidayAndEvent_Chalets() {
        let event_id = dictEventData?.id
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/HoliEvent_chalet_list", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : "","eventid":event_id!], withHud: true) { (success, response, error) in
            print(response)
            self.checkNotificationCount()
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = HolidayEventChaletList_Base(dictionary: response as! NSDictionary)
                    if responseBase?.user_details != nil && (responseBase?.user_details!.count)! > 0 {
                        self.arrayHolidayChalet_List = (responseBase?.user_details)!
                    } else {
                        print("Arry is empty")
                      //  self.arryAvailableEventList = []
                    }
                    DispatchQueue.main.async {
                        self.addholidaytoChaletTV.reloadData()
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
