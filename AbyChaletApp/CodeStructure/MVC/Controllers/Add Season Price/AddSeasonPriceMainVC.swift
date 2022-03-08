//
//  AddSeasonPriceMainVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 07/03/22.
//

import UIKit
import SVProgressHUD

class AddSeasonPriceMainVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var AddSeasonPricetoChaletTV: UITableView!
    
    var topSliderMenuArray:[String] = []
    var selectedIndex:Int?
    var selectedIndexPath : IndexPath?
    var topSelection = ""
    var toggledIndexes = [Int:Bool]()
    var isToggled = false
    var selectedIndexx = -1
    var arraySeasonPrice_Chalet_List = [SeasonPrice_Chalet_details]()
    var ArrayselectedItem : [SeasonPrice_Chalet_details] = []
    var arraySeason_Date = [SeasonDate]()
    var seasonEnd = ""
    var seasonStart = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        topSliderMenuArray = ["holidays prices","Season prices","Stats"]
        selectedIndex = 1
        getSeasonDateAndChalets()
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Add season price to chalet".localized()
        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    @objc func backButtonTouched()  {
       // self.navigationController?.popViewController(animated: true)
        let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "myChaletVC") as! myChaletVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func didMoveToNotification(){
        
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
    
    func DictionaryToJSON() -> Data{

        let dictionary = ["data":ArrayselectedItem]
        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(dictionary){
            let json = String(data: jsonData, encoding: .ascii)
            print("JSON string = \n\(json ?? "")")
            return jsonData as Data
        }
        return Data()
        
    }
    
    @IBAction func tapped_SubmitBtn(_ sender:UIButton!){
        DictionaryToJSON()
    }
    

}

extension AddSeasonPriceMainVC : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topSliderMenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectPricingandStatsMenuCVCell", for: indexPath) as! selectPricingandStatsMenuCVCell
        cell.lblTitle.text = topSliderMenuArray[indexPath.item]
        self.menuCollectionView.scrollToItem(at: IndexPath(row: selectedIndex ?? 0, section: 0), at: [.centeredVertically, .centeredHorizontally], animated: true)
        if selectedIndex == indexPath.row {
            cell.imgViewBg.image = UIImage(named: "icn_SelectedPackage")
            cell.lblTitle.font = UIFont(name: "Roboto-Bold", size: 17)
        }else{
            cell.imgViewBg.image = UIImage(named: "icn_DeselectedPackage")
            cell.lblTitle.font = UIFont(name: "Roboto-Regular", size: 17)
        }
        cell.isSelected = (selectedIndexPath == indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 138 , height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.topSelection = topSliderMenuArray[indexPath.row]
        DispatchQueue.main.async {
            self.menuCollectionView.reloadData()
        }
        if topSelection == "holidays prices"{
           print("Selected holidays prices")
            let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "AddHolidayPriceMainVC") as! AddHolidayPriceMainVC
            navigationController?.pushViewController(nextVC, animated: true)
        }else if topSelection == "Season prices"{
            print("Selected Season prices")
        }else{
            print("Selected Stats")
            let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "myChaletVC") as! myChaletVC
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
}

extension AddSeasonPriceMainVC:UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 1
        }else{
            return self.arraySeasonPrice_Chalet_List.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonDateTVCell", for: indexPath) as! SeasonDateTVCell
            cell.lblEnd_season.text = seasonEnd
            cell.lblStart_season.text = seasonStart
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonPriceChaletListTVCell", for: indexPath) as! SeasonPriceChaletListTVCell
            cell.setValuesToFields(dict: arraySeasonPrice_Chalet_List[indexPath.row])
            cell.btnCheckBox.tag = indexPath.row
            cell.btnCheckBox.addTarget(self, action: #selector(TapCheckbox), for: .touchUpInside)
            cell.tf_Weekend_Price.tag = indexPath.row
            cell.tf_Weekdays_Price.tag = indexPath.row
            cell.tf_WeekAB_Price.tag = indexPath.row
            cell.tf_Weekend_Price.delegate = self
            cell.tf_Weekdays_Price.delegate = self
            cell.tf_WeekAB_Price.delegate = self
            cell.tf_Weekend_Price.addTarget(self, action: #selector(WeekendvalueChanged), for: .editingChanged)
            cell.tf_Weekdays_Price.addTarget(self, action: #selector(WeekdaysvalueChanged), for: .editingChanged)
            cell.tf_WeekAB_Price.addTarget(self, action: #selector(WeekABvalueChanged), for: .editingChanged)

            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "seasonpricemiddlecell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 120
        }else if indexPath.section == 1{
            return 65
        }else{
            if toggledIndexes[indexPath.row] == true{
                return 400.0
            }else{
                return 184.0
            }
        }
    }
    
    @objc func TapCheckbox(_ sender: UIButton!){
        let indexpath = IndexPath(row: sender.tag, section: 2)
        sender.isSelected = !sender.isSelected
        let cell = AddSeasonPricetoChaletTV.cellForRow(at: indexpath) as! SeasonPriceChaletListTVCell
        let item = arraySeasonPrice_Chalet_List[sender.tag]
        if sender.isSelected == true{
            toggledIndexes[sender.tag] = true
            ArrayselectedItem.append(item)
            self.selectedIndexx = sender.tag
            cell.bottomViewHeightConstrain.constant = 220
        }else{
            toggledIndexes[sender.tag] = false
            for (i,selectedItem) in ArrayselectedItem.enumerated(){
                if selectedItem.chalet_name == item.chalet_name!{
                    ArrayselectedItem.remove(at: i)
                }
            }
            self.selectedIndex = -1
            cell.bottomViewHeightConstrain.constant = 0

        }
        self.AddSeasonPricetoChaletTV.reloadData()
    }
    
    @objc func WeekendvalueChanged(_ textField: UITextField){
        let indexpath = IndexPath(row: textField.tag, section: 2)
        let cell = AddSeasonPricetoChaletTV.cellForRow(at: indexpath) as! SeasonPriceChaletListTVCell
        let item = arraySeasonPrice_Chalet_List[textField.tag]
        item.weekend_seasonprice = cell.tf_Weekend_Price.text
    }
    @objc func WeekdaysvalueChanged(_ textField: UITextField){
        let indexpath = IndexPath(row: textField.tag, section: 2)
        let cell = AddSeasonPricetoChaletTV.cellForRow(at: indexpath) as! SeasonPriceChaletListTVCell
        let item = arraySeasonPrice_Chalet_List[textField.tag]
        item.weekdays_seasonprice = cell.tf_Weekdays_Price.text

    }
    @objc func WeekABvalueChanged(_ textField: UITextField){
        let indexpath = IndexPath(row: textField.tag, section: 2)
        let cell = AddSeasonPricetoChaletTV.cellForRow(at: indexpath) as! SeasonPriceChaletListTVCell
        let item = arraySeasonPrice_Chalet_List[textField.tag]
        item.weekend_seasonprice = cell.tf_WeekAB_Price.text

    }
    
}
extension AddSeasonPriceMainVC{
    func getSeasonDateAndChalets() {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/viewSeasonPrice", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : ""], withHud: true) { (success, response, error) in
            print(response)
            self.checkNotificationCount()
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = AddSeasonPrice_Base(dictionary: response as! NSDictionary)
                    self.arraySeasonPrice_Chalet_List = (responseBase?.chalet_details)!
                    self.seasonEnd = (responseBase?.season_end)!
                    self.seasonStart = (responseBase?.season_start)!
                    DispatchQueue.main.async {
                        self.AddSeasonPricetoChaletTV.reloadData()
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
    
    func postSeasonPriceChaletData() {
        let rawdata = DictionaryToJSON()
        let userid = (CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : "")
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/", dictionary: ["userid":userid], withHud: true,rowData: rawdata) { (success, response, error) in
            self.checkNotificationCount()
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    print("success success success")
                 //   let responseBase = AddedHolidayPriceChaletList_Base(dictionary: response as! NSDictionary)
                 //   self.arrayInsertedChaletList = (responseBase?.chalet_details)!
                    
                 //   let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "ConfirmAddHolidayToChaletVC") as! ConfirmAddHolidayToChaletVC
                 //   nextVC.dictEventData = self.dictEventData
                 //       nextVC.eventAppliedChaletLists = self.arrayInsertedChaletList
                 //   nextVC.eventAppliedToken = (responseBase?.confirm_token)!
                 //   self.navigationController?.pushViewController(nextVC, animated: true)
   
                    DispatchQueue.main.async {
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


