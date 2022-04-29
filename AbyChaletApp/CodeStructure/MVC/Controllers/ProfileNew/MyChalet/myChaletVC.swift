//
//  myChaletVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 27/12/21.
//

import UIKit
import SVProgressHUD

class myChaletVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var myChaletTV: UITableView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var statsMenuCollectionView: UICollectionView!
    @IBOutlet weak var statsPopView: UIView!
    @IBOutlet weak var heightConstraintforStatsView: NSLayoutConstraint!
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var lblpopupheader : UILabel!
    @IBOutlet weak var popupheader_image : UIImageView!
    @IBOutlet weak var picker_YearView : UIPickerView!
    @IBOutlet weak var picker_MonthsView : UIPickerView!
    @IBOutlet weak var picker_WeekdaysView : UIPickerView!
    @IBOutlet weak var picker_WeekendView : UIPickerView!
    @IBOutlet weak var picker_WeekAView : UIPickerView!
    @IBOutlet weak var picker_WeekBView : UIPickerView!
    @IBOutlet weak var picker_HolidayView : UIPickerView!
    
    @IBOutlet weak var viewFor_yearPV : UIView!
    @IBOutlet weak var viewFor_monthPV : UIView!
    @IBOutlet weak var viewFor_weekendPV : UIView!
    @IBOutlet weak var viewFor_weekedaysPV : UIView!
    @IBOutlet weak var viewFor_weekAPV : UIView!
    @IBOutlet weak var viewFor_weekBPV : UIView!
    @IBOutlet weak var viewFor_holidaysPV : UIView!


    @IBOutlet weak var picker_DoneBtn: UIButton!
    
    var isBottomSheetshown : Bool = false
    var isclicked_Compare : Bool = false
    var isclicked_Stats : Bool = false
    var touched : Bool = false
    var expanded = [Int]()
    var toggledIndexes = [Int:Bool]()
    var topSliderMenuArray:[String] = []
    var topSliderStatsMenuArray:[String] = []
    var selectedIndex:Int?
    var selectedIndexB:Int?
    var selectedIndexPath : IndexPath?
    var selectedIndexPathB : IndexPath?
    var topSelection = ""
    var arrayMyChalets = [ChaletLists]()
    var chaletid = ""
    var chaletstatus : Bool = false
    var isfrommainchalet : Bool = false
    var chaletId = 0
    var year_pickerData: [String] = [String]()
    var months_PickerData: [String] = [String]()
    var weekend_PickerData: [String] = [String]()
    var weekdays_PickerData: [String] = [String]()
    var weekA_PickerData: [String] = [String]()
    var weekB_PickerData: [String] = [String]()
    var holiday_PickerData: [String] = [String]()
    var year_Comparison_pickerData : [[String]] = [[String]]()

    var pickedItemName = ""
    var middleOfPicker = 0
    var isCompareClicked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 2
        selectedIndexB = 6
        view.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)
        myChaletTV.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)
        setupForCustomNavigationTitle1()
        self.setUpNavigationBar()
        getmyChalets()
        picker_DoneBtn.isUserInteractionEnabled = false
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
        topSliderMenuArray = ["Holidays prices","Season prices","Stats"]
        topSliderStatsMenuArray = ["Holidays","Week (B)","Week (A)","Weekend","Weekdays","Months","Years"]
        year_pickerData = ["2010", "2011", "2012", "2013", "2014", "2015","2016", "2017", "2018", "2019", "2020", "2021","2022"]
        months_PickerData = ["January","February","March","April","May","June","July","Auguest","Septemper","October","November","December"]
        weekend_PickerData = ["weekend","weekend","weekend","weekend","May","June","July","Auguest","Septemper","October","November","December"]
        weekdays_PickerData = ["weekdays","weekdays","weekdays","weekdays","May","June","July","Auguest","Septemper","October","November","December"]
        weekA_PickerData = ["weekA","weekA","weekA","weekA","May","June","July","Auguest","Septemper","October","November","December"]
        weekB_PickerData = ["weekB","weekB","weekB","weekB","May","June","July","Auguest","Septemper","October","November","December"]
        holiday_PickerData = ["holiday","holiday","holiday","April","May","June","July","Auguest","Septemper","October","November","December"]
        
        year_Comparison_pickerData = [["2010", "2011", "2012", "2013", "2014", "2015","2016", "2017", "2018", "2019", "2020", "2021","2022"],["2010", "2011", "2012", "2013", "2014", "2015","2016", "2017", "2018", "2019", "2020", "2021","2022"]]


        middleOfPicker = year_pickerData.count / 2
        picker_YearView.selectRow(middleOfPicker, inComponent: 0, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedIndex = 2
        selectedIndexB = 6
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
    
    //MARK:- SetUp Picker View
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if isCompareClicked == false{
            return 1
        }else{
            return 2
        }
    }
  
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            if isCompareClicked{
                if component == 0{
                    return year_pickerData.count
                }else{
                    return year_pickerData.count
                }
            }
            return year_pickerData.count
        }else if pickerView.tag == 1 {
            return months_PickerData.count
        }else if pickerView.tag == 2 {
            return weekend_PickerData.count
        }else if pickerView.tag == 3 {
            return weekdays_PickerData.count
        }else if pickerView.tag == 4 {
            return weekA_PickerData.count
        }else if pickerView.tag == 5 {
            return weekB_PickerData.count
        }else{
            return holiday_PickerData.count
        }
        
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            viewFor_yearPV.isHidden = false
            viewFor_monthPV.isHidden = true
            viewFor_weekAPV.isHidden = true
            viewFor_weekendPV.isHidden = true
            viewFor_weekBPV.isHidden = true
            viewFor_holidaysPV.isHidden = true
            viewFor_weekedaysPV.isHidden = true
            if isCompareClicked{
                if component == 0{
                    return year_pickerData[row]
                }else{
                    return year_pickerData[row]
                }
            }else{
                return year_pickerData[row]
            }
            
        } else if pickerView.tag == 1 {

            viewFor_monthPV.isHidden = false
            viewFor_yearPV.isHidden = true
            viewFor_weekAPV.isHidden = true
            viewFor_weekendPV.isHidden = true
            viewFor_weekBPV.isHidden = true
            viewFor_holidaysPV.isHidden = true
            viewFor_weekedaysPV.isHidden = true
            if isCompareClicked{
                if component == 0{
                    return months_PickerData[row]
                }else{
                    return months_PickerData[row]
                }
            }else{
                return months_PickerData[row]
            }
        } else if pickerView.tag == 2 {
            viewFor_weekendPV.isHidden = false
            viewFor_yearPV.isHidden = true
            viewFor_monthPV.isHidden = true
            viewFor_weekAPV.isHidden = true
            viewFor_weekBPV.isHidden = true
            viewFor_holidaysPV.isHidden = true
            viewFor_weekedaysPV.isHidden = true
            return weekA_PickerData[row]
        } else if pickerView.tag == 3 {
            viewFor_weekedaysPV.isHidden = false
            viewFor_yearPV.isHidden = true
            viewFor_monthPV.isHidden = true
            viewFor_weekAPV.isHidden = true
            viewFor_weekendPV.isHidden = true
            viewFor_weekBPV.isHidden = true
            viewFor_holidaysPV.isHidden = true
            return weekdays_PickerData[row]
        } else if pickerView.tag == 4 {

            viewFor_weekAPV.isHidden = false
            viewFor_yearPV.isHidden = true
            viewFor_monthPV.isHidden = true
            viewFor_weekendPV.isHidden = true
            viewFor_weekBPV.isHidden = true
            viewFor_holidaysPV.isHidden = true
            viewFor_weekedaysPV.isHidden = true
            return weekA_PickerData[row]
        } else if pickerView.tag == 5 {

            viewFor_weekBPV.isHidden = false
            viewFor_yearPV.isHidden = true
            viewFor_monthPV.isHidden = true
            viewFor_weekAPV.isHidden = true
            viewFor_weekendPV.isHidden = true
            viewFor_holidaysPV.isHidden = true
            viewFor_weekedaysPV.isHidden = true
            return weekB_PickerData[row]
        }else{
            viewFor_holidaysPV.isHidden = false
            viewFor_yearPV.isHidden = true
            viewFor_monthPV.isHidden = true
            viewFor_weekAPV.isHidden = true
            viewFor_weekendPV.isHidden = true
            viewFor_weekBPV.isHidden = true
            viewFor_weekedaysPV.isHidden = true
            return months_PickerData[row]
        }

    }
    
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    if pickerView.tag == 0 {
        let attributedString = NSAttributedString(string: year_pickerData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 24)!])
            return attributedString
    }else if pickerView.tag == 1 {
        let attributedString = NSAttributedString(string: months_PickerData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 24)!])
            return attributedString
    }else if pickerView.tag == 2 {
        let attributedString = NSAttributedString(string: weekend_PickerData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 24)!])
            return attributedString
    }else if pickerView.tag == 3 {
        let attributedString = NSAttributedString(string: weekdays_PickerData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 24)!])
            return attributedString
    }else if pickerView.tag == 4 {
        let attributedString = NSAttributedString(string: weekA_PickerData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 24)!])
            return attributedString
    }else if pickerView.tag == 5 {
        let attributedString = NSAttributedString(string: weekB_PickerData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 24)!])
            return attributedString
    }else{
        let attributedString = NSAttributedString(string: holiday_PickerData[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 24)!])
            return attributedString
    }

    }
 

    /*
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let pickerLabel = UILabel()

        if row == middleOfPicker
        {
            pickerLabel.textColor = UIColor.white
            pickerLabel.font = UIFont(name: "Roboto-Bold", size: 24)!
        }
        else
        {
            pickerLabel.textColor = UIColor.white
            pickerLabel.font = UIFont(name: "Roboto-Regular", size: 20)!
        }

        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
     */
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            if isCompareClicked{
                picker_DoneBtn.isUserInteractionEnabled = true
                picker_YearView.resignFirstResponder()
                let selectedItem1 = year_pickerData[pickerView.selectedRow(inComponent: 0)]
                let selectedItem2 = year_pickerData[pickerView.selectedRow(inComponent: 1)]
                print("selected Item 1 = \(selectedItem1)")
                print("selected Item 2 = \(selectedItem2)")
            }else{
                pickedItemName = year_pickerData[row]
                print("selected item = \(pickedItemName)")
                picker_YearView.resignFirstResponder()
                picker_DoneBtn.isUserInteractionEnabled = true
            }

        }else if pickerView.tag == 1{
            pickedItemName = months_PickerData[row]
            print("selected item = \(pickedItemName)")
            picker_MonthsView.resignFirstResponder()
            picker_DoneBtn.isUserInteractionEnabled = true
        }else if pickerView.tag == 2{
            pickedItemName = weekend_PickerData[row]
            print("selected item = \(pickedItemName)")
            picker_WeekendView.resignFirstResponder()
            picker_DoneBtn.isUserInteractionEnabled = true
        }else if pickerView.tag == 3{
            pickedItemName = weekdays_PickerData[row]
            print("selected item = \(pickedItemName)")
            picker_WeekdaysView.resignFirstResponder()
            picker_DoneBtn.isUserInteractionEnabled = true
        }else if pickerView.tag == 4{
            pickedItemName = weekA_PickerData[row]
            print("selected item = \(pickedItemName)")
            picker_WeekAView.resignFirstResponder()
            picker_DoneBtn.isUserInteractionEnabled = true
        }else if pickerView.tag == 5{
            pickedItemName = weekB_PickerData[row]
            print("selected item = \(pickedItemName)")
            picker_WeekBView.resignFirstResponder()
            picker_DoneBtn.isUserInteractionEnabled = true
        }else{
            pickedItemName = holiday_PickerData[row]
            print("selected item = \(pickedItemName)")
            picker_HolidayView.resignFirstResponder()
            picker_DoneBtn.isUserInteractionEnabled = true
        }


    }


}

extension myChaletVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMyChalets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myChaletTVCell", for: indexPath) as! myChaletTVCell
        cell.setValuesToFields(dict: arrayMyChalets[indexPath.row])
        cell.BtnViewDetails.addTarget(self, action: #selector(viewDetails), for: .touchUpInside)
        cell.toggleBtn.addTarget(self, action: #selector(toggleAction), for: .touchUpInside)
        cell.BtnStat.addTarget(self, action: #selector(statsTapped), for: .touchUpInside)
        cell.BtnCompare.addTarget(self, action: #selector(compareTapped), for: .touchUpInside)
        cell.btnClosedDate.addTarget(self, action: #selector(show_Subchalets), for: .touchUpInside)
        cell.bttonView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
        cell.toggleBtn.tag = indexPath.row
        cell.btnClosedDate.tag = indexPath.row
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
           // cell.bttonView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
            cell.topView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 0)
            toggledIndexes[sender.tag] = true
          //  ArrayselectedItem.append(item)
          //  self.selectedIndex = sender.tag
          //  self.isToggled = true
         //   cell.DetailViewHeight.constant = 375
        }else{
            toggledIndexes[sender.tag] = false
            cell.downUpArrow.setImage(#imageLiteral(resourceName: "arrow-Down"), for: .normal)
            cell.topView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
          //  cell.bttonView.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 0)
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
        let tag = sender.tag
        let indexpath = IndexPath(row: tag, section: 0)
        let cell = myChaletTV.cellForRow(at: indexpath) as! myChaletTVCell
        cell.istoggleON = !cell.istoggleON
        
        chaletId = self.arrayMyChalets[indexpath.row].chalet_id!
        isfrommainchalet = true
        chaletstatus = self.arrayMyChalets[indexpath.row].reservation_available!
        print("chalet id = \(chaletId)")
        print("isfrommainchalet = \(isfrommainchalet)")
        print("chaletstatus = \(chaletstatus)")

        updateReservationStatus() // Change Reservation Status
        if cell.istoggleON {
            sender.setImage(UIImage(named: "toggleONReservation"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "toggleOFFReservation"), for: .normal)
        }
        
        
    }
    
    @objc func statsTapped(_ sender: UIButton!){
        self.statsMenuCollectionView.scrollToItem(at:IndexPath(item: 6 , section: 0), at: .right, animated: true)
        self.isCompareClicked = false
        self.lblpopupheader.text = "Stats"
        let imagefile: UIImage = UIImage(named: "statsWhite")!
        popupheader_image.image = imagefile
        if (isBottomSheetshown){
            UIView.animate(withDuration: 0.3, animations: {
                self.heightConstraintforStatsView.constant = 0
                self.view.layoutIfNeeded()
            }){(status) in
                self.isBottomSheetshown = false
                self.maskView.isHidden = true
               // self.maskView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            }
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.heightConstraintforStatsView.constant = 400
                self.view.layoutIfNeeded()
            }){(status) in
                self.isBottomSheetshown = true
                self.isclicked_Stats = true
                self.maskView.isHidden = false
                self.maskView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.heightConstraintforStatsView.constant = 400
                    self.view.layoutIfNeeded()
                }){(status) in
                   // self.isBottomSheetshown = true
                    
                }
            }
        }

    }
    
    @objc func compareTapped(_ sender: UIButton!){
        self.statsMenuCollectionView.scrollToItem(at:IndexPath(item: 6 , section: 0), at: .right, animated: true)
        self.isCompareClicked = true
        self.lblpopupheader.text = "Compare"
        let imagefile: UIImage = UIImage(named: "compareicon")!
        popupheader_image.image = imagefile
        if (isBottomSheetshown){
            UIView.animate(withDuration: 0.3, animations: {
                self.heightConstraintforStatsView.constant = 0
                self.view.layoutIfNeeded()
            }){(status) in
                self.isBottomSheetshown = false
                self.maskView.isHidden = true
               // self.maskView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            }
        }else{
            UIView.animate(withDuration: 0.3, animations: {
                self.heightConstraintforStatsView.constant = 400
                self.view.layoutIfNeeded()
            }){(status) in
                self.isBottomSheetshown = true
                self.isclicked_Compare = true
                self.maskView.isHidden = false
                self.maskView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.heightConstraintforStatsView.constant = 400
                    self.view.layoutIfNeeded()
                }){(status) in
                   // self.isBottomSheetshown = true
                    
                }
            }
        }

    }
    
    @objc func show_Subchalets(_ sender:UIButton!){
        let tag = sender.tag
        let indexpath = IndexPath(row: tag, section: 0)
        print("closed date Tapped")
        let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "OwnerSubChaletsVC") as! OwnerSubChaletsVC
        nextVC.mainchaletid = "\(self.arrayMyChalets[indexpath.row].chalet_id!)"
        nextVC.mainchaletname = self.arrayMyChalets[indexpath.row].chalet_name!
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func closeBtn_Tapped(_ sender:UIButton!){
        UIView.animate(withDuration: 0.3, animations: {
            self.heightConstraintforStatsView.constant = 0
            self.view.layoutIfNeeded()
        }){(status) in
            self.isBottomSheetshown = false
            self.isclicked_Compare = false
            self.isclicked_Stats = false
            self.maskView.isHidden = true
        }
    }
    
    @IBAction func Picker_DoneBtn_Tapped(_ sender: UIButton){
        UIView.animate(withDuration: 0.3, animations: {
            self.heightConstraintforStatsView.constant = 0
            self.view.layoutIfNeeded()
        }){(status) in
            self.isBottomSheetshown = false
            self.isclicked_Compare = false
            self.isclicked_Stats = false
            self.maskView.isHidden = true
        }
        
        print("Call statistics API , selected item = \(pickedItemName)")
        let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "StatsVC") as! StatsVC
        nextVC.selectedData = pickedItemName
        nextVC.chaletType = topSelection
        nextVC.selectedIndex = selectedIndexB
        navigationController?.pushViewController(nextVC, animated: true)
    }
    

}

extension myChaletVC : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCollectionView{
            return self.topSliderMenuArray.count
        }else{
            return self.topSliderStatsMenuArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == menuCollectionView{
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
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selectPricingandStatsMenuCVCell", for: indexPath) as! selectPricingandStatsMenuCVCell
            cell.lblTitle.text = topSliderStatsMenuArray[indexPath.item]
            self.menuCollectionView.scrollToItem(at: IndexPath(row: selectedIndexB ?? 0, section: 0), at: [.centeredVertically, .centeredHorizontally], animated: true)
            if selectedIndexB == indexPath.row {
                cell.imgViewBg.image = UIImage(named: "icn_SelectedPackage")
                cell.lblTitle.font = UIFont(name: "Roboto-Bold", size: 17)
            }else{
                cell.imgViewBg.image = UIImage(named: "icn_DeselectedPackage")
                cell.lblTitle.font = UIFont(name: "Roboto-Regular", size: 17)
            }
            cell.isSelected = (selectedIndexPathB == indexPath)
            
            return cell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == menuCollectionView{
            return CGSize(width: view.frame.size.width / 3 , height: 40.0)

         //   return CGSize(width: 138 , height: 40)
        }else{
            return CGSize(width: view.frame.size.width / 3 , height: 40.0)
          //  return CGSize(width: 138 , height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCollectionView{
            self.selectedIndex = indexPath.row
            self.topSelection = topSliderMenuArray[indexPath.row]
            DispatchQueue.main.async {
                self.menuCollectionView.reloadData()
            }
            if topSelection == "Holidays prices"{
               print("Selected holidays prices")
                let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "AddHolidayPriceMainVC") as! AddHolidayPriceMainVC
                navigationController?.pushViewController(nextVC, animated: false)
            }else if topSelection == "Season prices"{
                print("Selected Season prices")
                let nextVC = UIStoryboard(name: "ProfileNew", bundle: Bundle.main).instantiateViewController(identifier: "AddSeasonPriceMainVC") as! AddSeasonPriceMainVC
                navigationController?.pushViewController(nextVC, animated: false)
            }else{
                print("Selected Stats")
            }
        }else{
            //call the picker
            self.selectedIndexB = indexPath.row
            self.topSelection = topSliderStatsMenuArray[indexPath.row]
            DispatchQueue.main.async {
                self.statsMenuCollectionView.reloadData()
            }
            if topSelection == "Holidays"{
                viewFor_holidaysPV.isHidden = false
                viewFor_weekAPV.isHidden = true
                viewFor_weekBPV.isHidden = true
                viewFor_weekedaysPV.isHidden = true
                viewFor_weekendPV.isHidden = true
                viewFor_yearPV.isHidden = true
                viewFor_monthPV.isHidden = true

            }else if topSelection == "Week (A)"{
                viewFor_weekAPV.isHidden = false
                viewFor_holidaysPV.isHidden = true
                viewFor_weekBPV.isHidden = true
                viewFor_weekedaysPV.isHidden = true
                viewFor_weekendPV.isHidden = true
                viewFor_yearPV.isHidden = true
                viewFor_monthPV.isHidden = true
            }else if topSelection == "Week (B)"{
                viewFor_weekBPV.isHidden = false
                viewFor_holidaysPV.isHidden = true
                viewFor_weekAPV.isHidden = true
                viewFor_weekedaysPV.isHidden = true
                viewFor_weekendPV.isHidden = true
                viewFor_yearPV.isHidden = true
                viewFor_monthPV.isHidden = true

            }else if topSelection == "Weekdays"{
                viewFor_weekedaysPV.isHidden = false
                picker_WeekBView.isHidden = true
                viewFor_holidaysPV.isHidden = true
                viewFor_weekAPV.isHidden = true
                viewFor_weekendPV.isHidden = true
                viewFor_yearPV.isHidden = true
                viewFor_monthPV.isHidden = true
            }else if topSelection == "Weekend"{
                viewFor_weekendPV.isHidden = false
                viewFor_weekedaysPV.isHidden = true
                picker_WeekBView.isHidden = true
                viewFor_holidaysPV.isHidden = true
                viewFor_weekAPV.isHidden = true
                viewFor_yearPV.isHidden = true
                viewFor_monthPV.isHidden = true
            }else if topSelection == "Months"{
                viewFor_monthPV.isHidden = false
                viewFor_weekendPV.isHidden = true
                viewFor_weekedaysPV.isHidden = true
                picker_WeekBView.isHidden = true
                viewFor_holidaysPV.isHidden = true
                viewFor_weekAPV.isHidden = true
                viewFor_yearPV.isHidden = true
            }else{
                viewFor_yearPV.isHidden = false
                viewFor_monthPV.isHidden = true
                viewFor_weekendPV.isHidden = true
                viewFor_weekedaysPV.isHidden = true
                picker_WeekBView.isHidden = true
                viewFor_holidaysPV.isHidden = true
                viewFor_weekAPV.isHidden = true
            }
        }

    }
    
    
}

extension myChaletVC{
    func getmyChalets() {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/owner-chalets", dictionary: ["user_id":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : ""], withHud: true) { (success, response, error) in
            self.checkNotificationCount()
            print("user id = \(CAUser.currentUser.id)")
            print(response)
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = myChaletList_Base(dictionary: response as! NSDictionary)
                    self.arrayMyChalets = (responseBase?.chaletLists)!
                    print("Count = \(self.arrayMyChalets.count)")
                    DispatchQueue.main.async {
                        self.myChaletTV.reloadData()
                        SVProgressHUD.dismiss()
                        self.view.isUserInteractionEnabled = true
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "", msg: response!["message"]! as! String)
                    self.view.isUserInteractionEnabled = true
                }
            }else{
                showDefaultAlert(viewController: self, title: "", msg: "Failed..!")
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
    func updateReservationStatus() {

        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/update-reservation-status", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : "","id":chaletId,"is_from_main_chalet":isfrommainchalet,"status": chaletstatus], withHud: true) { (success, response, error) in
           // print(response)
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                   // let responseBase = myChaletList_Base(dictionary: response as! NSDictionary)
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.getmyChalets()
                        self.myChaletTV.reloadData()
                        self.view.isUserInteractionEnabled = true
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "", msg: response!["message"]! as! String)
                    self.view.isUserInteractionEnabled = true
                }
            }else{
                showDefaultAlert(viewController: self, title: "", msg: "Failed..!")
                self.view.isUserInteractionEnabled = true
            }
        }
    }
}
