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
    var dictOfferData : Available_Offer_list?
    var arryAvailableOfferChaletList = [Offer_Chalet_details]()
   // var arrayDiscountAdded = [String:Int]()
    var arrayDiscountAdded : [Offer_Chalet_details] = []
    var ArrayselectedItem : [Offer_Chalet_details] = []
    var toggledIndexes = [Int:Bool]()
    var offerid : Int = 0
    var isToggled = false
    var selectedIndex = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        getOfferChaletData()
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
        discountValue = Int(cell.tfDiscountAdded.text!)!
        item.discount = discountValue
       // arrayDiscountAdded.append(item)
    }
    

    func DictionaryToJSON(){
        let dictionary = ["aKey": "aValue", "anotherKey": "anotherValue"]
          if let theJSONData = try?  JSONSerialization.data(
            withJSONObject: dictionary,
            options: .prettyPrinted
            ),
            let theJSONText = String(data: theJSONData,
                                     encoding: String.Encoding.ascii) {
                print("JSON string = \n\(theJSONText)")
          }
        
    }
    
    func test(){
        let dic = ArrayselectedItem

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data

            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            // here "decoded" is of type `Any`, decoded from JSON data

            // you can now cast it with the right type
            if decoded is [String:String] {
                // use dictFromJSON
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func Tapped_NextButton(_ sender: UIButton!){
       // test()
       // DictionaryToJSON()
        postOfferChaletData()
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
            return 1
        }else{
            return arryAvailableOfferChaletList.count
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
            let data = arryAvailableOfferChaletList[indexPath.row]
            if data.offerCount != 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChaletListToAddOfferTVCell", for: indexPath) as! ChaletListToAddOfferTVCell
               // cell.setValuesToFields(dict: arryAvailableOfferChaletList[indexPath.row])
                
                
                cell.setValuesToFields(index: indexPath.row, dict: self.arryAvailableOfferChaletList[indexPath.row],isClick: self.isToggled,selectedIndex: self.selectedIndex)
                
                cell.tfDiscountAdded.tag = indexPath.row
                cell.tfDiscountAdded.delegate = self
                cell.btnCheckBox.tag = indexPath.row
                cell.btnCheckBox.addTarget(self, action: #selector(TapCheckbox), for: .touchUpInside)
                cell.tfDiscountAdded.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
                return cell
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0{
            return 120.0
        }else if indexPath.section == 2{
            let data = arryAvailableOfferChaletList[indexPath.row]
            if data.offerCount != 0{
                if toggledIndexes[indexPath.row] == true{
                    return 275.0
                }else{
                    return 184.0
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
       // offerid = (dictOfferData?.id)!
        //"userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : ""
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/Offer_chalet_list", dictionary: ["userid":"187","offerId":offerid], withHud: true) { (success, response, error) in
            self.checkNotificationCount()
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = OfferChaletListModel(dictionary: response as! NSDictionary)
                    self.arryAvailableOfferChaletList = (responseBase?.user_details)!
                    if self.arryAvailableOfferChaletList.count <= 0{
                        showDefaultAlert(viewController: self, title: "Alert", msg: "No Chalets to List for this Offer")
                    }
                    DispatchQueue.main.async {
                        self.AddOfferToChaletTV.reloadData()
                        SVProgressHUD.dismiss()
                        self.view.isUserInteractionEnabled = true
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "Alert", msg: response!["message"]! as! String)
                }
            }else{
                showDefaultAlert(viewController: self, title: "Alert", msg: "Failed..!")
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
        let dataa = ["discount":20,"chalet_id":16]
        offerid = (dictOfferData?.id)!
        //"userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : ""
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/add-offer-to-chalet", dictionary: ["userid":CAUser.currentUser.id!,"offerid":offerid,"_qu_data_qua_":ArrayselectedItem], withHud: true) { (success, response, error) in
            self.checkNotificationCount()
            print(response)
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                 //   let responseBase = OfferChaletListModel(dictionary: response as! NSDictionary)
                 //   self.arryAvailableOfferChaletList = (responseBase?.user_details)!
                 //   if self.arryAvailableOfferChaletList.count <= 0{
                 //       showDefaultAlert(viewController: self, title: "Alert", msg: "No Chalets to List for this Offer")
                 //   }
                    DispatchQueue.main.async {
                      //  self.AddOfferToChaletTV.reloadData()
                        SVProgressHUD.dismiss()
                        self.view.isUserInteractionEnabled = true
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "Alert", msg: response!["message"]! as! String)
                }
            }else{
                showDefaultAlert(viewController: self, title: "Alert", msg: "Failed..!")
            }
        }
    }
}

extension AddOffertoChaletVC{
    func postRequest(_ sender:Any){
        var sURL : String!
        sURL = "https://sicsapp.com/Aby_chalet/api/add-offer-to-chalet"
        var serializer = DataResponseSerializer(emptyResponseCodes: Set([200,204,205]))
        var sampleRequest = URLRequest(url: URL(string: sURL)!)
        sampleRequest.httpMethod = HTTPMethod.post.rawValue
        AF.request(sampleRequest).uploadProgress{Progress
            in }.response(responseSerializer: serializer){response in
                if (response.error == nil){
                    var responseString: String!
                    responseString = ""
                    if response.data != nil{
                        responseString = String(bytes: response.data!, encoding: .utf8)
                    }else{
                        responseString = response.response?.description
                    }
                    print(responseString ?? "***")
                }
        }
        
    }
}
