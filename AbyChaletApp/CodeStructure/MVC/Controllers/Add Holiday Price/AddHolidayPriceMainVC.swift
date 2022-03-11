//
//  AddHolidayPriceMainVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 07/03/22.
//

import UIKit
import SVProgressHUD

class AddHolidayPriceMainVC: UIViewController {
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var holidayEventTV : UITableView!
    
    var topSliderMenuArray:[String] = []
    var selectedIndex:Int?
    var selectedIndexPath : IndexPath?
    var topSelection = ""
    var arryAvailableEventList = [Holi_event_list]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        getAvailableEvents()
        topSliderMenuArray = ["Holidays prices","Season prices","Stats"]
        selectedIndex = 0

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
        let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "myChaletVC") as! myChaletVC
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func didMoveToNotification(){
        
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
    

}
extension AddHolidayPriceMainVC : UICollectionViewDelegate,UICollectionViewDataSource{
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
        if topSelection == "Holidays prices"{
           print("Selected holidays prices")
        }else if topSelection == "Season prices"{
            print("Selected Season prices")
            let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "AddSeasonPriceMainVC") as! AddSeasonPriceMainVC
            navigationController?.pushViewController(nextVC, animated: true)
        }else{
            print("Selected Stats")
            let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "myChaletVC") as! myChaletVC
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    
}

extension AddHolidayPriceMainVC: UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return arryAvailableEventList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HolidayEventListTVCell", for: indexPath) as! HolidayEventListTVCell
            cell.setValuesToFields(dict: arryAvailableEventList[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventlistcell")
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 120
        }else{
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "AddHolidayToChaletVC") as! AddHolidayToChaletVC
            nextVC.dictEventData = self.arryAvailableEventList[indexPath.row]
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
}


extension AddHolidayPriceMainVC {
    func getAvailableEvents() {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/available-holidays-and-events", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : ""], withHud: true) { (success, response, error) in
            self.checkNotificationCount()
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = HolidayEventListBase(dictionary: response as! NSDictionary)
                    if responseBase?.holi_event_list != nil && (responseBase?.holi_event_list!.count)! > 0 {
                        self.arryAvailableEventList = (responseBase?.holi_event_list)!
                    } else {
                        print("Arry is empty")
                        self.arryAvailableEventList = []
                    }
                    DispatchQueue.main.async {
                        self.holidayEventTV.reloadData()
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

