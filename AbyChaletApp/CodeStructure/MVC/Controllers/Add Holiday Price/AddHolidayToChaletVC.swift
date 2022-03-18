//
//  AddHolidayToChaletVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 07/03/22.
//

import UIKit
import SVProgressHUD

class AddHolidayToChaletVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var addholidaytoChaletTV : UITableView!
    @IBOutlet weak var submitBtn : UIButton!
    
    var dictEventData : Holi_event_list?
    var arrayHolidayChalet_List = [HolidayEventChaletList]()
    var ArrayselectedItem : [HolidayEventChaletList] = []
    var arrayInsertedChaletList = [Inserted_Holiday_chalets]()
    var toggledIndexes = [Int:Bool]()
    var isToggled = false
    var selectedIndex = -1
    var userid = (CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        getHolidayAndEvent_Chalets()
        self.submitBtn.isUserInteractionEnabled = false
        self.submitBtn.backgroundColor = UIColor("#A8A8A8")
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
    
    @IBAction func Tapped_SubmitBtn(_ sender: UIButton!){
        postHolidayChaletData()
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
                cell.tf_holidayPrice.tag = indexPath.row
                cell.tf_holidayPrice.delegate = self
                cell.tf_holidayPrice.addTarget(self, action: #selector(valueChanged), for: .editingChanged)

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
            return 140
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
        let item = arrayHolidayChalet_List[sender.tag]
        if sender.isSelected == true{
            toggledIndexes[sender.tag] = true
            ArrayselectedItem.append(item)
            self.selectedIndex = sender.tag
            cell.heightForHolidayPriceView.constant = 100
            if ArrayselectedItem.isEmpty{
                self.submitBtn.isUserInteractionEnabled = false
                self.submitBtn.backgroundColor = UIColor("#C2C2C2")
            }else{
                self.submitBtn.isUserInteractionEnabled = true
                self.submitBtn.backgroundColor = UIColor("#6FDA44")
            }
        }else{
            toggledIndexes[sender.tag] = false
            for (i,selectedItem) in ArrayselectedItem.enumerated(){
                if selectedItem.chalet_id == item.chalet_id!{
                    ArrayselectedItem.remove(at: i)
                }
            }
            self.selectedIndex = -1
            cell.heightForHolidayPriceView.constant = 0
            if ArrayselectedItem.isEmpty{
                self.submitBtn.isUserInteractionEnabled = false
                self.submitBtn.backgroundColor = UIColor("#C2C2C2")
            }else{
                self.submitBtn.isUserInteractionEnabled = true
                self.submitBtn.backgroundColor = UIColor("#6FDA44")
            }

        }
        self.addholidaytoChaletTV.reloadData()
    }
    
    @objc func valueChanged(_ textField: UITextField){
        let indexpath = IndexPath(row: textField.tag, section: 2)
        let cell = addholidaytoChaletTV.cellForRow(at: indexpath) as! AddHolidayToChaletTVCell
        let item = arrayHolidayChalet_List[textField.tag]
        var holiPrice : Int? = 0
        holiPrice = Int(cell.tf_holidayPrice.text!) ?? 0
        item.price = holiPrice
        item.userid = Int(userid)
        item.holieventId = dictEventData?.id
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                print("Backspace was pressed")
            }
        }
        return true
    }
    
    func DictionaryToJSON() -> Data{

        let dictionary = ["data":ArrayselectedItem]
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(dictionary){
            let json = String(data: jsonData, encoding: .ascii)
            //print("JSON string = \n\(json ?? "")")
            return jsonData as Data
        }
        return Data()
        
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
                        print("Array is empty")
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
    
    
    func postHolidayChaletData() {
        let rawdata = DictionaryToJSON()
        SVProgressHUD.show()
        let event_id = (dictEventData?.id)!
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/add-holi-events-to-chalets", dictionary: ["userid":userid,"holieventId":event_id], withHud: true,rowData: rawdata) { (success, response, error) in
            self.checkNotificationCount()
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    print("success success success")
                    let responseBase = AddedHolidayPriceChaletList_Base(dictionary: response as! NSDictionary)
                    self.arrayInsertedChaletList = (responseBase?.chalet_details)!
                    
                    let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "ConfirmAddHolidayToChaletVC") as! ConfirmAddHolidayToChaletVC
                    nextVC.dictEventData = self.dictEventData
                        nextVC.eventAppliedChaletLists = self.arrayInsertedChaletList
                    nextVC.eventAppliedToken = (responseBase?.confirm_token)!
                    self.navigationController?.pushViewController(nextVC, animated: true)
   
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.view.isUserInteractionEnabled = true
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "Alert", msg: response!["message"]! as! String)
                    self.view.isUserInteractionEnabled = true
                }
            }else{
                showDefaultAlert(viewController: self, title: "Alert", msg: "Failed..!")
                self.view.isUserInteractionEnabled = true
            }
        }
    }
}
