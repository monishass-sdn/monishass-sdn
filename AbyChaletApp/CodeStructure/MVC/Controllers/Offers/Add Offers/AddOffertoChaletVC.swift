//
//  AddOffertoChaletVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 17/01/22.
//

import UIKit
import SVProgressHUD
import Alamofire
import UIKit

class AddOffertoChaletVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var AddOfferToChaletTV: UITableView!
    @IBOutlet weak var warningView : UIView!
    @IBOutlet weak var nextButtonMainView: UIView!
    @IBOutlet weak var goBackView : UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var submitBtnBGView: UIView!
    @IBOutlet weak var lblmaxOfferText : UILabel!
    @IBOutlet weak var lblsubmit : UILabel!
    
    var dictOfferData : Available_Offer_list?
    var arryAvailableOfferChaletList = [Offer_Chalet_details]()
    var arrayDiscountAdded : [Offer_Chalet_details] = []
    var ArrayselectedItem : [Offer_Chalet_details] = []
    var selectedOffersList = [Inserted_offered_chalets]()
    var arrayAddedOfferList = [Offered_Chalet_details]()
    var toggledIndexes = [Int:Bool]()
    var offerid : String = ""
    var isToggled = false
    var selectedIndex = -1
    var isFromCreateOffer : Bool = false
    var createdOfferCheck_in = ""
    var createdOfferCheck_out = ""
    var timeroffercheckin = ""
    var timerOffercreatedAt = ""
    var timerOffexpiry = ""
    var createdOfferid = ""
    var maxOferCount = ""
    var userid = (CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : "")
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        if isFromCreateOffer == true{
            getCreatedOfferChaletData()
        }else{
            getOfferChaletData()
        }
        self.nextBtn.isUserInteractionEnabled = false
        self.submitBtnBGView.backgroundColor = UIColor("#A8A8A8")

        // Do any additional setup after loading the view.
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Add Offer to Chalet".localized()

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
    
    @objc func TapCheckbox(_ sender: UIButton!){
        
        let indexpath = IndexPath(row: sender.tag, section: 2)
        sender.isSelected = !sender.isSelected
        let cell = AddOfferToChaletTV.cellForRow(at: indexpath) as! ChaletListToAddOfferTVCell
        let item = arryAvailableOfferChaletList[sender.tag]
        if sender.isSelected == true{
            toggledIndexes[sender.tag] = true
            ArrayselectedItem.append(item)
            self.selectedIndex = sender.tag
            self.isToggled = true
            cell.heightForDiscountView.constant = 100
            if ArrayselectedItem.isEmpty{
                print("button not accessable")
                self.nextBtn.isUserInteractionEnabled = false
                self.submitBtnBGView.backgroundColor = UIColor("#A8A8A8")
            }else{
                print("Button accessable")
                self.nextBtn.isUserInteractionEnabled = true
                self.submitBtnBGView.backgroundColor = UIColor("#6FDA44")
            }
        }else{
            toggledIndexes[sender.tag] = false
            for (i,selectedItem) in ArrayselectedItem.enumerated(){
                if selectedItem.chalet_id! == item.chalet_id!{
                    ArrayselectedItem.remove(at: i)
                }
            }
            self.selectedIndex = -1
            self.isToggled = false
            cell.heightForDiscountView.constant = 0
            if ArrayselectedItem.isEmpty{
                print("button not accessable")
                self.nextBtn.isUserInteractionEnabled = false
                self.submitBtnBGView.backgroundColor = UIColor("#A8A8A8")
            }else{
                print("Button accessable")
                self.nextBtn.isUserInteractionEnabled = true
                self.submitBtnBGView.backgroundColor = UIColor("#6FDA44")
            }

        }
        self.AddOfferToChaletTV.reloadData()
        /*
        let item = arryAvailableOfferChaletList[sender.tag]
        if sender.isSelected{
            ArrayselectedItem.append(item)
        }else{
            for (i,selectedItem) in ArrayselectedItem.enumerated(){
                if selectedItem.chalet_id! == item.chalet_id!{
                    ArrayselectedItem.remove(at: i)
                }
            }
            
        }
*/
    }
    
    @objc func valueChanged(_ textField: UITextField){
        let indexpath = IndexPath(row: textField.tag, section: 2)
        let cell = AddOfferToChaletTV.cellForRow(at: indexpath) as! ChaletListToAddOfferTVCell
        let item = arryAvailableOfferChaletList[textField.tag]
        var discountValue : Int? = 0
        discountValue = Int(cell.tfDiscountAdded.text ?? "\(Int(0))")
        item.discount = discountValue
        item.userid = Int(userid)
        item.offerid = Int(offerid)
        
       // arrayDiscountAdded.append(item)
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
       // let dictionary = ["aKey": "aValue", "anotherKey": "anotherValue"]
        let dictionary = ["data":ArrayselectedItem]
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(dictionary){
            let json = String(data: jsonData, encoding: .ascii)
           // print("JSON string = \n\(json ?? "")")
            return jsonData as Data
        }
        return Data()
        
    }
    
    
    @IBAction func Tapped_NextButton(_ sender: UIButton!){
        postOfferChaletData()
    }
    
  
    @IBAction func tapOn_GoBack(_ sender: UIButton!){
        print("GO BACK BUTTON CLICKED")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func TapCheckbox2(_ sender: UIButton!){
        
        let item = arryAvailableOfferChaletList[sender.tag]
        sender.isSelected = !sender.isSelected
        if item.disable_status == true{
            self.disableOffer(chalet_id: "\(item.chalet_id!)", offer_id : offerid)
        }else{
            showDefaultAlert(viewController: self, title: "Message", msg: "within 12 hour limit from checkin , Can't disable")
        }
    }
    
}

extension AddOffertoChaletVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            if arryAvailableOfferChaletList.count <= 0{
                return 0
            }else{
                return 1
            }
        }else{
            return arryAvailableOfferChaletList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0{
            if isFromCreateOffer == false{
                let cell = tableView.dequeueReusableCell(withIdentifier: "showSelectedOfferTVCell", for: indexPath) as! showSelectedOfferTVCell
                cell.lblcheckin.text = dictOfferData?.check_in
                cell.lblcheckout.text = dictOfferData?.check_out
                cell.setValuesToFields(dict: dictOfferData!)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "showSelectedOfferTVCell", for: indexPath) as! showSelectedOfferTVCell
                cell.lblcheckin.text = createdOfferCheck_in
                cell.lblcheckout.text = createdOfferCheck_out
                DispatchQueue.main.async {
                    if self.timeroffercheckin != "" && self.timerOffexpiry != "" && self.timerOffercreatedAt != ""{
                        cell.setTimer(offercheckin : self.timeroffercheckin, offercreatedat : self.timerOffercreatedAt,offerexpiry: self.timerOffexpiry)
                    }else{
                        print("no timer data fetched")
                    }
                    
                }
                return cell
            }
        }else if indexPath.section == 2{
            let data = arryAvailableOfferChaletList[indexPath.row]
            if data.offerCount != 0{
                if self.arryAvailableOfferChaletList[indexPath.row].offeredStatus == false{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ChaletListToAddOfferTVCell", for: indexPath) as! ChaletListToAddOfferTVCell
                    cell.setValuesToFields(index: indexPath.row, dict: self.arryAvailableOfferChaletList[indexPath.row],isClick: self.isToggled,selectedIndex: self.selectedIndex)
                    cell.tfDiscountAdded.tag = indexPath.row
                    cell.tfDiscountAdded.delegate = self
                    cell.btnCheckBox.tag = indexPath.row
                    cell.btnCheckBox.addTarget(self, action: #selector(TapCheckbox), for: .touchUpInside)
                    cell.tfDiscountAdded.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
                    return cell
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ChaletListToAddedOfferTVCell", for: indexPath) as! ChaletListToAddedOfferTVCell
                    cell.setValuesToFields(index: indexPath.row, dict: self.arryAvailableOfferChaletList[indexPath.row],isClick: self.isToggled,selectedIndex: self.selectedIndex)
                  //  cell.tfDiscountAdded.tag = indexPath.row
                 //   cell.tfDiscountAdded.delegate = self
                    cell.btnCheckBox.tag = indexPath.row
                    cell.btnCheckBox.addTarget(self, action: #selector(TapCheckbox2), for: .touchUpInside)
                 //   cell.tfDiscountAdded.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
                    return cell
                }

            }else if data.offerCount == 0 && data.isFromHoliday == false{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChaletWithZeroOfferTVCell", for: indexPath) as! ChaletWithZeroOfferTVCell
                cell.setValuesToFields(dict: arryAvailableOfferChaletList[indexPath.row])
                cell.btnCheckBox.tag = indexPath.row
                cell.btnCheckBox.addTarget(self, action: #selector(TapCheckbox), for: .touchUpInside)
                return cell
            }else if data.isFromHoliday == true && data.offerCount == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChaletFromHolidayTVCell", for: indexPath) as! ChaletFromHolidayTVCell
                cell.setValuesToFields(dict: arryAvailableOfferChaletList[indexPath.row])
                return cell
            }

        }
        if arryAvailableOfferChaletList.count <= 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noChaletMessageCell")
            self.warningView.isHidden = true
            self.nextButtonMainView.isHidden = true
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            self.warningView.isHidden = false
            self.nextButtonMainView.isHidden = false
            return cell!
        }

        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0{
            return 140.0
        }else if indexPath.section == 2{
            let data = arryAvailableOfferChaletList[indexPath.row]
            if data.offerCount != 0{
                if self.arryAvailableOfferChaletList[indexPath.row].offeredStatus == false{
                    if toggledIndexes[indexPath.row] == true{
                        return 282.0
                    }else{
                        return 184.0
                    }
                }else{
                    return 282.0
                }

            }else if data.isFromHoliday == true{
                return 185.0
            }else{
                return 185.0
            }
        }else{
            return 64.0
        }
    }
    
    
}

extension AddOffertoChaletVC{
    func getOfferChaletData() {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/Offer_chalet_list", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : "","offerId":offerid], withHud: true) { (success, response, error) in
            self.checkNotificationCount()
            print(response)
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = OfferChaletListModel(dictionary: response as! NSDictionary)
                    self.maxOferCount = (responseBase?.max_offer_count)!
                    self.lblmaxOfferText.text = "Maximum (\(self.maxOferCount)) Offers per chalet each month"
                    self.arryAvailableOfferChaletList = (responseBase?.user_details)!
                    if self.arryAvailableOfferChaletList.count <= 0{
                       // showDefaultAlert(viewController: self, title: "Alert", msg: "No Chalets to List for this Offer")
                    }
                    DispatchQueue.main.async {
                        self.AddOfferToChaletTV.reloadData()
                        SVProgressHUD.dismiss()
                        self.view.isUserInteractionEnabled = true
                    }
                }else{
                    self.view.isUserInteractionEnabled = true
                   // showDefaultAlert(viewController: self, title: "Alert", msg: response!["message"]! as! String)
                }
            }else{
                showDefaultAlert(viewController: self, title: "Alert", msg: "Failed..!")
            }
        }
    }
    
    func getCreatedOfferChaletData() {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/add-offer", dictionary: ["user_id":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : "","check_in":createdOfferCheck_in,"check_out":createdOfferCheck_out
        ], withHud: true) { (success, response, error) in
            self.checkNotificationCount()
            print(response)
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = OfferChaletListModel(dictionary: response as! NSDictionary)
                    self.arryAvailableOfferChaletList = (responseBase?.user_details)!
                    self.timeroffercheckin = (responseBase?.offer_checkin)!
                    self.timerOffercreatedAt = (responseBase?.offercreated_at)!
                    self.timerOffexpiry = (responseBase?.offer_expiry)!
                    self.createdOfferid = (responseBase?.offer_id)!
                    if self.arryAvailableOfferChaletList.count <= 0{
                        showDefaultAlert(viewController: self, title: "Alert", msg: "No Chalets to List for this Offer")
                    }
                    DispatchQueue.main.async {
                        self.AddOfferToChaletTV.reloadData()
                        SVProgressHUD.dismiss()
                        self.view.isUserInteractionEnabled = true
                    }
                }else{
                    self.view.isUserInteractionEnabled = true
                    showDefaultAlert(viewController: self, title: "Alert", msg: response!["message"]! as! String)
                }
            }else{
                showDefaultAlert(viewController: self, title: "Alert", msg: "Failed..!")
            }
        }
    }
    
    func disableOffer(chalet_id: String, offer_id : String) {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/disable-offered-status", dictionary: ["chaletid":chalet_id,"offerid":offer_id], withHud: true) { (success, response, error) in
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    self.getOfferChaletData()
                    self.view.isUserInteractionEnabled = true
            }else{
                showDefaultAlert(viewController: self, title: "", msg: " Response Failed..!")
                self.view.isUserInteractionEnabled = true
            }
            }else{
                showDefaultAlert(viewController: self, title: "Alert", msg: "Failed..!")
                self.view.isUserInteractionEnabled = true
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
    
    //MARK:- Add Offer to Chalet API
    
    func postOfferChaletData() {
        let rawdata = DictionaryToJSON()
        if isFromCreateOffer == false{
            offerid = "\(dictOfferData?.id)"
        }else{
            offerid = "\(self.createdOfferid)"
        }
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/add-offer-to-chalet", dictionary: ["userid":userid,"offerid":offerid], withHud: true,rowData: rawdata) { (success, response, error) in
            self.checkNotificationCount()
            print(response)
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = AddedOfferChaletListModel(dictionary: response as! NSDictionary)
                    self.selectedOffersList = (responseBase?.inserted_offered_chalets)!
                    self.arrayAddedOfferList = (responseBase?.chalet_details)!
                    
                    let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ConfirmAddedOfferVC") as! ConfirmAddedOfferVC
                    nextVC.dictOfferData = self.dictOfferData
                    nextVC.selectedOfferedChaletData = self.selectedOffersList
                    nextVC.offerAppliedChaletLists = self.arrayAddedOfferList
                    nextVC.token_id = (responseBase?.confirm_token)!
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

