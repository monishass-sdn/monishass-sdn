//
//  myChaletVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 27/12/21.
//

import UIKit

class myChaletVC: UIViewController {
    
    @IBOutlet weak var myChaletTV: UITableView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    var touched : Bool = false
    var expanded = [Int]()
    var toggledIndexes = [Int:Bool]()
    var topSliderMenuArray:[String] = []
    var selectedIndex:Int?
    var selectedIndexPath : IndexPath?
    var topSelection = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 2
        view.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)
        myChaletTV.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)
        setupForCustomNavigationTitle1()
        self.setUpNavigationBar()
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
        topSliderMenuArray = ["holidays prices","Season prices","Stats"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedIndex = 2
        menuCollectionView.reloadData()
    }
    
    //MARK:- SetUp NavigationBar
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
        let notificationButton = UIBarButtonItem(image: Images.kIconNotification, style: .plain, target: self, action: #selector(notificationButtonTouched))
        //self.navigationItem.rightBarButtonItems = [notificationButton]
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    
    @objc func backButtonTouched()  {
        self.navigationController?.popToRootViewController(animated: true)
      //  self.navigationController?.popViewController(animated: true)
       // let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "MyProfileTableVC") as! MyProfileTableVC
      //  navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func notificationButtonTouched()  {
        
        
    }
    
    func setupForCustomNavigationTitle1(){

        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "My", attributes:[
                                                    NSAttributedString.Key.foregroundColor: UIColor.green,
                                                    NSAttributedString.Key.font: UIFont(name: "Roboto-BoldItalic", size: 25)! ])

        navTitle.append(NSMutableAttributedString(string: " Chalet", attributes:[
                                                    NSAttributedString.Key.font: UIFont(name: "Roboto-BoldItalic", size: 25)! ,
                                                    NSAttributedString.Key.foregroundColor: UIColor.white]))

        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
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

extension myChaletVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myChaletTVCell", for: indexPath) as! myChaletTVCell
        cell.BtnViewDetails.addTarget(self, action: #selector(viewDetails), for: .touchUpInside)
        cell.toggleBtn.addTarget(self, action: #selector(toggleAction), for: .touchUpInside)
        cell.bttonView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
        cell.BtnViewDetails.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if toggledIndexes[indexPath.row] == true{
            return 660.0
        }else{
            return 220.0
        }
    }
    
    @objc func viewDetails(_ sender: UIButton!){
        let indexpath = IndexPath(row: sender.tag, section: 0)
        sender.isSelected = !sender.isSelected
        let cell = myChaletTV.cellForRow(at: indexpath) as! myChaletTVCell
       // let item = arryAvailableOfferChaletList[sender.tag]
        if sender.isSelected == true{
            cell.downUpArrow.setImage(#imageLiteral(resourceName: "arrow-Up"), for: .normal)
            cell.bttonView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
            toggledIndexes[sender.tag] = true
          //  ArrayselectedItem.append(item)
          //  self.selectedIndex = sender.tag
          //  self.isToggled = true
         //   cell.DetailViewHeight.constant = 375
        }else{
            toggledIndexes[sender.tag] = false
            cell.downUpArrow.setImage(#imageLiteral(resourceName: "arrow-Down"), for: .normal)
            cell.bttonView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 0)
          /*  for (i,selectedItem) in ArrayselectedItem.enumerated(){
                if selectedItem.chalet_id! == item.chalet_id!{
                    ArrayselectedItem.remove(at: i)
                }
            }*/
          //  self.selectedIndex = -1
          //  self.isToggled = false
          //  cell.DetailViewHeight.constant = 0

        }
        self.myChaletTV.reloadData()
   /*     let indexpath = IndexPath(row: sender.tag, section: 0)
        let cell = myChaletTV.cellForRow(at: indexpath) as! myChaletTVCell
        if cell.isExpanded == true{
            cell.DetailViewHeight.constant = 0
            cell.isExpanded = false
        }else{
            cell.DetailViewHeight.constant = 375
            cell.isExpanded = true
        }
        myChaletTV.reloadData()
        print("Sender tag = \(sender.tag)")
*/

    }
    
    @objc func toggleAction(_ sender: UIButton!){
        let indexpath = IndexPath(row: sender.tag, section: 0)
        let cell = myChaletTV.cellForRow(at: indexpath) as! myChaletTVCell
        cell.istoggleON = !cell.istoggleON
        if cell.istoggleON {
            sender.setImage(UIImage(named: "toggleONReservation"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "toggleOFFReservation"), for: .normal)
        }
        
        
    }
    

}

extension myChaletVC : UICollectionViewDelegate,UICollectionViewDataSource{
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
            let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "AddSeasonPriceMainVC") as! AddSeasonPriceMainVC
            navigationController?.pushViewController(nextVC, animated: true)
        }else{
            print("Selected Stats")
        }
    }
    
    
}
