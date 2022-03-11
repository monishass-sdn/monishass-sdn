//
//  OffersListVC.swift
//  AbyChaletApp
//
//  Created by Visakh Srishti on 27/05/21.
//

import UIKit
import SVProgressHUD

class OffersListVC: UIViewController {

    @IBOutlet weak var tableViewOfferList: UITableView!
    @IBOutlet weak var collectionViewOfferlist: UICollectionView!
    @IBOutlet weak var lblMessageOnScreen: UILabel!
  //  var controller = OfferListTVCell()
    var arryOfferList = [Offer_Chalet_list]()
    var dictAdmin = Admin(dictionary: NSDictionary())
    var isLoad = false
    var activityIndicator = UIActivityIndicatorView()
    var myTimer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
     //   controller.delegate = self
        self.setUpNavigationBar()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        self.view.addSubview(activityIndicator)
       // setUpAddOfferButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  if CAUser.currentUser.id != nil{
            self.getRewardsData()
      //  }else {
            self.isLoad = true
      //  }
        
       // self.getRewardsData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(logoutUser), name: NSNotification.Name(rawValue: NotificationNames.kBlockedUser), object: nil)
        appDelegate.checkBlockStatus()
    }
    @objc func logoutUser() {
        appDelegate.logOut()
    }
    
    @objc func addOfferTapped(){
        let addOfferVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "addNewOfferVC") as! addNewOfferVC
        navigationController?.pushViewController(addOfferVC, animated: true)
    }
    
    func setUpAddOfferButton(){
        if CAUser.currentUser.userstatus == "owner"{
            let menuBtn = UIButton(type: .custom)
            menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 75, height: 75)
            menuBtn.setImage(UIImage(named:"addicon"), for: .normal)
            menuBtn.addTarget(self, action: #selector(addOfferTapped), for: UIControl.Event.touchUpInside)

            let menuBarItem = UIBarButtonItem(customView: menuBtn)
            let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
            currWidth?.isActive = true
            let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
            currHeight?.isActive = true
            self.navigationItem.leftBarButtonItem = menuBarItem
        }else{
            // No need to show Add Offer
        }

    }
    

    //MARK:- SetUp NavigationBar
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        //let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        //self.navigationItem.leftBarButtonItems = [backBarButton]
        let notificationButton = UIBarButtonItem(image: Images.kIconNotification, style: .plain, target: self, action: #selector(notificationButtonTouched))
       // self.navigationItem.rightBarButtonItems = [notificationButton]
        self.navigationItem.title = "Offers".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        if CAUser.currentUser.userstatus == "owner"{
            let addOfferBtn = UIBarButtonItem(image: Images.kIconAdd, style: .plain, target: self, action: #selector(addOfferTapped))
            self.navigationItem.leftBarButtonItems = [addOfferBtn]
        }else{
            
        }

        
    }
    //MARK:- ButtonActions
    //MARK:- Done button action keyboard
    @objc func doneButtonClicked() {
        self.view.endEditing(true)
    }
    @objc func notificationButtonTouched()  {
        
        
    }
    

}
extension OffersListVC : OfferListTVCellDelegate {

    func reloadOffers() {
        print("Table Reload From End Timer")
        //tableViewOfferList.reloadData()
      //  getRewardsData()
    }
    
    
 /*   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoad == true{
            return  arryOfferList.count != 0 ? arryOfferList.count : 1
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.arryOfferList.count > 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "OfferListTVCell", for: indexPath) as! OfferListTVCell
            cell.delegate = self
            cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row, loaded: false)
            cell.setValuesToFields(dictAdmin: dictAdmin!, dict: self.arryOfferList[indexPath.row])
            cell.tag = indexPath.row
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoBookingTVCell", for: indexPath) as! NoBookingTVCell
            cell.labelText.text = "You don't have any Offers yet".localized()
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.arryOfferList.count > 0{
            let count = arryOfferList[indexPath.row].offerUser_details!.count
            return CGFloat((count * 155) + 60)
        }else{
            return 174
        }
    }
  */
}
extension OffersListVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arryOfferList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardsChaletListCollectionViewCell", for: indexPath) as! RewardsChaletListCollectionViewCell
        cell.setValuesToFields(dict: arryOfferList[indexPath.row])
        if kCurrentLanguageCode == "ar"{
            cell.lblCheckIn.font = UIFont(name: kFontAlmaraiBold, size: 16)
            cell.lblCheckOut.font = UIFont(name: kFontAlmaraiBold, size: 16)
            cell.lblDiscountname.font = UIFont(name: kFontAlmaraiBold, size: 15)

        }else{
            cell.lblCheckIn.font = UIFont(name: "Roboto-Bold", size: 16)
            cell.lblCheckOut.font = UIFont(name: "Roboto-Bold", size: 16)
            cell.lblDiscountname.font = UIFont(name: "Roboto-Medium", size: 16)

        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Section\(collectionView.tag)")
        print("Cell\(indexPath.row)")
        
        if arryOfferList[indexPath.row].reservation_status == true{
        //Reservation Available
        let reservationVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ReservationTVC") as! ReservationTVC
            reservationVC.dictOfferUserDetails = self.arryOfferList[indexPath.row]
        reservationVC.isFromOffer = true
        reservationVC.dictAdmin = self.dictAdmin
        reservationVC.dictOfferChaletList = self.arryOfferList[indexPath.row]
        
        //reservationVC.selectedIndex = indexPath.item
            reservationVC.selectedPackage = self.arryOfferList[indexPath.row].package!
        self.navigationController?.pushViewController(reservationVC, animated: true)
                
        }else{
            //Reservation Not Available
            let reservation_Available = arryOfferList[indexPath.row].reservation_available
            let alert = UIAlertController(title: "Message", message: "You Can't book after \(reservation_Available ?? 0) days from Today", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20 , height: 203)
    }
}
extension OffersListVC {
    
    //MARK:- GetMyBookingData
    func getRewardsData() {
       //["userid":CAUser.currentUser.id!]
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/offers", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : ""], withHud: true) { (success, response, error) in
            self.checkNotificationCount()
            self.isLoad = true
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = OfferListBase(dictionary: response as! NSDictionary)
                    self.dictAdmin = responseBase?.admin
                    self.arryOfferList = (responseBase?.chalet_list)!
                    if self.arryOfferList.count <= 0{
                        //self.tableViewOfferList.isHidden = true
                        self.collectionViewOfferlist.isHidden = true
                        self.lblMessageOnScreen.isHidden = false
                        if CAUser.currentUser.userstatus == "owner"{
                            self.lblMessageOnScreen.text = "There are no offer's added yet."
                        }else{
                            self.lblMessageOnScreen.text = "There are no offer's available."
                        }
                    }
                    DispatchQueue.main.async {
                        self.isLoad = true
                        self.collectionViewOfferlist.reloadData()
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
    @objc func didMoveToNotification(){
        
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
}
