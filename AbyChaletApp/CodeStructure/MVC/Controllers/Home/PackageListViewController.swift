//
//  HomeViewController.swift
//  AbyChaletApp
//
//  Created by TEJASWINI KADAM on 28/04/21.
//

import UIKit

struct PackageBookingChartStruct {
    var type:String
    var days:String
}

class PackageListViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var popUpTableView: UITableView!
    @IBOutlet weak var viewAcceptOrReject : UIView!
    @IBOutlet weak var btnClosePopUp: UIButton!
    @IBOutlet weak var lblYouCanAcceptRejectLater: UILabel!
  //  @IBOutlet weak var blurEffectView: UIVisualEffectView!
   // var effect:UIVisualEffect!
    var showPopUpStatus: Bool = false
    var isClicked = false
    var selectedIndx = 0
    var arrayReservationList = [Reservation_list]()
    var dictBookingDetails = Booking_details(dictionary: NSDictionary())
    
    lazy var packageBookingChartArray: [PackageBookingChartStruct] = [
        PackageBookingChartStruct(type: "Weekdays".localized(), days: "Sunday - Monday - Tuesday - Wednesday".localized()),
        PackageBookingChartStruct(type: "Weekend".localized(), days: "Thursday - Friday - Saturday".localized()),
        PackageBookingChartStruct(type: "Week (A)".localized(), days: "Sunday to Saturday".localized()),
        PackageBookingChartStruct(type: "Week (B)".localized(), days: "Thursday to Wednesday".localized()),
        PackageBookingChartStruct(type: "Holidays and Events".localized(), days: "Prices vary in these periods".localized())
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.barTintColor = #colorLiteral(red: 0.168627451, green: 0.3294117647, blue: 0.4078431373, alpha: 1)
        appDelegate.updateDeviceToke(deviceToken: DeviceTokenSaver.standard.deviceToken)
        //appDelegate.updateDeviceToke(deviceToken: "\(UserDefaults.standard.string(forKey:"kDeviceToken") ?? "No Device Token Captured")")
//        effect = blurEffectView.effect
   //     blurEffectView.effect = nil
        setupForCustomNavigationTitle(self: self)
        navigationController?.navigationBar.barTintColor = kAppHeaderColor
        navigationController?.navigationBar.isTranslucent = false
        NotificationCenter.default.addObserver(self, selector: #selector(logoutUser), name: NSNotification.Name(rawValue: NotificationNames.kBlockedUser), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToSuccess), name: NSNotification.Name(rawValue: NotificationNames.KgoToSuccessPage), object: nil)
        lblYouCanAcceptRejectLater.text = "You can accepr or reject later".localized()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appDelegate.checkBlockStatus()
        if CAUser.currentUser.id != nil{
            if CAUser.currentUser.userstatus == "user"{
                print("do Nothing")
            }else{
                if CAUser.currentUser.userstatus == "owner" {
                    self.getOwnerInboxDetails(ownerId: "\(CAUser.currentUser.id ?? 0)")
                }
            }
        }else{
            
        }

        //self.checkNotificationCount()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.checkNotificationCount()
    }
    
    @objc func logoutUser() {
        appDelegate.logOut()
    }
    
    @objc func goToSuccess(notification: Notification) {
        DispatchQueue.main.async {
            if let userinfo = notification.userInfo as? [String:Any]{
                guard let dataa = userinfo["bookingData"] as? Booking_details , let labelString = userinfo["datentime"] as? String, let isdeposit = userinfo["isDeposit"] as? Bool else {return}
                
                
                let bookingDetailsTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "BookingDetailsTVC") as! BookingDetailsTVC
                bookingDetailsTVC.dictBookingDetails = dataa
                bookingDetailsTVC.remainingAmtDate = labelString
                bookingDetailsTVC.isDeposit = isdeposit
                  bookingDetailsTVC.remainingAmtDate = "sdsdd"
                  bookingDetailsTVC.isDeposit = false
                
                bookingDetailsTVC.isFrom = "Booked Successfully"
                self.navigationController!.pushViewController(bookingDetailsTVC, animated: true)
 
            }


        }

    }
 
}

extension PackageListViewController {
    func showPopUp(){
        if showPopUpStatus == false{
            self.view.addSubview(viewAcceptOrReject)
            self.viewAcceptOrReject.center.x = self.view.center.x
            self.viewAcceptOrReject.center.y = self.view.center.y - (self.view.frame.height / 6.0)
            viewAcceptOrReject.transform = CGAffineTransform(translationX: 0.2, y: 0.2)
            UIView.animate(withDuration: 0.4){
               // self.blurEffectView.effect = self.effect
                self.viewAcceptOrReject.alpha = 1
                self.viewAcceptOrReject.transform = CGAffineTransform.identity
            }
        }
    }
    
    @IBAction func closePopUp(_ sender: UIButton){
        print("Button Clicked")
        self.viewAcceptOrReject.removeFromSuperview()
        showPopUpStatus = true
       // self.blurEffectView.effect = nil
    }
    
    @IBAction func btnRejectAction(_ sender: UIButton) {
        let dict = self.arrayReservationList[sender.tag]
        self.showAcceptReject(message: "Are you sure you want to reject?".localized(), isFrom: "reject", bookindID: "\(dict.id!)")
    }
    @IBAction func btnAcceptAction(_ sender: UIButton) {
        let dict = self.arrayReservationList[sender.tag]
        self.showAcceptReject(message: "Are you sure you want to accept?".localized(), isFrom: "accept", bookindID: "\(dict.id!)")
    }
    
    func showAcceptReject(message:String,isFrom:String,bookindID:String) {
        let alert = UIAlertController(title: "Message".localized(), message: message.localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: isFrom == "accept" ? "Accept".localized() : "Reject".localized(), style: .default, handler: { action in
                self.acceptReject(status: isFrom, bookingId: bookindID)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
 //MARK:- UITableViewDelegate & DataSource

extension PackageListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblView{
            return packageBookingChartArray.count
        }else{
            return arrayReservationList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblView{
            let cell = tblView.dequeueReusableCell(withIdentifier: "PackageListTableVCell", for: indexPath) as! PackageListTableVCell
            cell.packageListData = packageBookingChartArray[indexPath.row]
            return cell
        }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "popUpViewTVCell", for: indexPath) as! popUpViewTVCell
                cell.setValuesToFields(dict: arrayReservationList[indexPath.row])
                return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblView{
            return screenHeight / 6.9
        }else{
            return 360
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "SelectPackageVC") as! SelectPackageVC
        if tableView == tblView{
            
            let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "SelectPackageTVC") as! SelectPackageTVC
            
            if indexPath.row == 0 {
                nextVC.selectedIndex = 4
            }else if indexPath.row == 1 {
                nextVC.selectedIndex = 3

            }else if indexPath.row == 2 {
                nextVC.selectedIndex = 2

            }else if indexPath.row == 3 {
                nextVC.selectedIndex = 1

            }else if indexPath.row == 4 {
                nextVC.selectedIndex = 0

            }


            navigationController?.pushViewController(nextVC, animated: true)
        }else{
            print("Clicked on Pop Up")

        }

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

//MARK:- API Code for Pop Up

extension PackageListViewController{
    func getOwnerInboxDetails(ownerId:String) {
        ServiceManager.sharedInstance.postMethodAlamofire("api/owner_chalet", dictionary: ["ownerid":ownerId], withHud: true) { [self] (success, response, error) in
           // self.checkBlockStatus()
            if success {
                if response!["status"] as! Bool == true {
                    let jsonBase = OwnerListBase(dictionary: response as! NSDictionary)
                    self.arrayReservationList = (jsonBase?.reservation_list)!
      
                    if arrayReservationList.count == 0{
                        print("Reservation Array Count is nil")
                        self.viewAcceptOrReject.removeFromSuperview()
                        showPopUpStatus = true
                    }else{
                        self.showPopUp()
                    }
                        self.popUpTableView.reloadData()
                }else{
                    showDefaultAlert(viewController: self, title: "Message".localized(), msg: ((response! as! NSDictionary)["message"] as! String))
                }
            }else{
                showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Failed...!".localized())
            }
        }
    }
    
    func checkBlockStatus() {
        if CAUser.currentUser.id != nil {
            ServiceManager.sharedInstance.postMethodAlamofire("api/block_user", dictionary: ["userid": CAUser.currentUser.id!], withHud: true) { (success, response, error) in
                if success {
                    let status = ((response as! NSDictionary)["status"] as! Bool)
                    if status == false{
                        DispatchQueue.main.async {
                            appDelegate.logOut()
                        }
                    }
                }
            }
        }
    }
    
    func acceptReject(status:String,bookingId:String)  {
        ServiceManager.sharedInstance.postMethodAlamofire("api/accept_reject", dictionary: ["status":status,"booking_id":bookingId], withHud: true) { [self] (success, response, error) in
            if success {
                if response!["status"] as! Bool == true {
                    self.isClicked = false
                    self.selectedIndx = 0
                    DispatchQueue.main.async {
                        if CAUser.currentUser.userstatus == "owner" {
                            self.getOwnerInboxDetails(ownerId: "\(CAUser.currentUser.id!)")
                        }
                        self.popUpTableView.reloadData()
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Failed...!".localized())
                }
            }else{
                showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Failed...!".localized())
            }
        }
        
    }
}
