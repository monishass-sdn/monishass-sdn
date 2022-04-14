//
//  CreateOfferWeekTypeSelection_VC.swift
//  AbyChaletApp
//
//  Created by Srishti on 14/04/22.
//

import UIKit

class CreateOfferWeekTypeSelection_VC: UIViewController {
    
    @IBOutlet weak var weekType_TV : UITableView!

    lazy var packageBookingChartArray: [PackageBookingChartStruct] = [
        PackageBookingChartStruct(type: "Weekdays".localized(), days: "Sunday - Monday - Tuesday - Wednesday".localized()),
        PackageBookingChartStruct(type: "Weekend".localized(), days: "Thursday - Friday - Saturday".localized()),
        PackageBookingChartStruct(type: "Week (A)".localized(), days: "Sunday to Saturday".localized()),
        PackageBookingChartStruct(type: "Week (B)".localized(), days: "Thursday to Wednesday".localized()),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        // Do any additional setup after loading the view.
    }
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Add Offer".localized()
        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.rightBarButtonItems = [notificationButton]
        self.navigationItem.leftBarButtonItems = [backBarButton]
    }
    @objc func backButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CreateOfferWeekTypeSelection_VC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return packageBookingChartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeekType_TVCell", for: indexPath) as! WeekType_TVCell
            cell.packageListData = packageBookingChartArray[indexPath.row]
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return screenHeight / 6.9
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "SelectPackageVC") as! SelectPackageVC
            
            let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "AddNewOfferCalendarVC") as! AddNewOfferCalendarVC
            
            if indexPath.row == 0 {
                nextVC.selectedIndex = 3
            }else if indexPath.row == 1 {
                nextVC.selectedIndex = 2

            }else if indexPath.row == 2 {
                nextVC.selectedIndex = 1

            }else if indexPath.row == 3 {
                nextVC.selectedIndex = 0

            }


            navigationController?.pushViewController(nextVC, animated: true)
        }


    
    
    func checkNotificationCount() {
        if CAUser.currentUser.id != nil {
            ServiceManager.sharedInstance.postMethodAlamofire("api/notification_count", dictionary: ["userid": CAUser.currentUser.id!], withHud: true) { (success, response, error) in
                if success {
                    if let messageCount = ((response as! NSDictionary)["message_count"] as? Int) {
                        kNotificationCount = messageCount
                        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
                        self.navigationItem.rightBarButtonItems = [notificationButton]
                    }
                }
            }
        }
    }
    
    @objc func didMoveToNotification(){
        
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
}
