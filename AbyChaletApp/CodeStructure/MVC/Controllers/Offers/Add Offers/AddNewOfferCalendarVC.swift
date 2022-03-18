//
//  AddNewOfferCalendarVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 16/03/22.
//

import UIKit
import SVProgressHUD

class AddNewOfferCalendarVC: UIViewController, CalenderDelegate2 {
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var lblForSelectedPackageInfo: UILabel!
    @IBOutlet weak var viewForCalendarContainerView: UIView!
    @IBOutlet weak var calendarContainerView: UIView!
    @IBOutlet weak var btnCreateOffer: UIButton!

    var selectedIndex:Int?
    var topSliderMenuArray:[String] = []
    var topSliderMenuValArray:[String] = []
    var selectedIndexPath : IndexPath?
    var topSelection = ""
    var startDate = ""
    var endDate = ""
    var arrayCalendarLists = [CalendarData]()
    var arrayListsCalender  = [JobsPerDate]()
    var isSearchEnable = false
    var arrayValuesToBackEnd = ["weekB","weekA","weekend","weekdays"]
    var selectedDate: String = ""
    var fromdate = ""
    var todate = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        selectedIndex = 0
        topSliderMenuArray = ["Week (B)","Week (A)","Weekend","Weekdays"]
        topSliderMenuValArray =  ["Thursday - Wednesday", "Sunday to Saturday", "Thursday - Friday - Saturday","Sunday - Monday - Tuesday - Wednesday"]
        setupUI()
        self.setupCalenderView()
        self.topSelection = arrayValuesToBackEnd[selectedIndex ?? 0]
        print("TOP SELECTION = \(topSelection)")
        print("Month = \(calenderView.currentMonthIndex)")
        print("Year = \(calenderView.currentYear)")
        self.getCalendarList(month: "\(calenderView.currentMonthIndex)", year: "\(calenderView.currentYear)", package: topSelection)

        // Do any additional setup after loading the view.
    }
    func setupUI(){
        self.lblForSelectedPackageInfo.text = topSliderMenuValArray[selectedIndex ?? 0]
        self.viewForCalendarContainerView.addCornerForView(cornerRadius: 10.0)

    }
    
    lazy var  calenderView: CalendarViewCreateOffer = {
        let calenderView = CalendarViewCreateOffer.init(theme: MyThemeNew.light, isSelectionEnabled: true)
        calenderView.translatesAutoresizingMaskIntoConstraints=false
        
        return calenderView
    }()
    
    func setupCalenderView() {
        
        calendarContainerView.layer.masksToBounds = true
        calendarContainerView.layer.cornerRadius = 0.0
        calendarContainerView.layer.borderWidth = 0.5
        calendarContainerView.layer.borderColor = UIColor.clear.cgColor
        
        calendarContainerView.addSubview(calenderView)
        calenderView.delegate = self
        calenderView.topAnchor.constraint(equalTo: calendarContainerView.topAnchor, constant: 0).isActive=true
        calenderView.rightAnchor.constraint(equalTo: calendarContainerView.rightAnchor, constant: 0).isActive=true
        calenderView.leftAnchor.constraint(equalTo: calendarContainerView.leftAnchor, constant: 0).isActive=true
        calenderView.heightAnchor.constraint(equalToConstant: 425).isActive=true
        
        calenderView.topSelection = self.topSelection
        calenderView.myCollectionView.reloadData()
      /*  if topSelection != ""{
            self.getCalendarList(month: "\(calenderView.currentMonthIndex)", year: "\(calenderView.currentYear)", package: topSelection)
        }else{
            print("top selection is null")
        }*/
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Add New Offer".localized()

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
    
    @IBAction func createOffer(_ sender: UIButton!){
        if self.isSearchEnable == true {
            print("Check in \(startDate)")
            print("Check out = \(endDate)")
            let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "AddOffertoChaletVC") as! AddOffertoChaletVC
            nextVC.isFromCreateOffer = true
            nextVC.createdOfferCheck_in = startDate
            nextVC.createdOfferCheck_out = endDate
            self.navigationController?.pushViewController(nextVC, animated: true)

        }

    }

}

extension AddNewOfferCalendarVC : UICollectionViewDelegate,UICollectionViewDataSource{
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
            self.lblForSelectedPackageInfo.text = topSliderMenuValArray[indexPath.row]
            self.topSelection = topSliderMenuArray[indexPath.row]
            calenderView.topSelection = self.topSelection
            calenderView.selectedArray.removeAll()
            calenderView.myCollectionView.reloadData()
            DispatchQueue.main.async {
                self.menuCollectionView.reloadData()
            }
            if topSelection == "Week (B)"{
               print("Selected Week B")
            }else if topSelection == "Week (A)"{
                print("Selected Week A")
            }else if topSelection == "Weekend"{
                print("Selected Weekend")
            }else{
                print("Selected Weekdays")
            }
        }
    
    
}

extension AddNewOfferCalendarVC{
    func getCalendarList(month:String,year:String,package:String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M"
        let formattedMonth = dateFormatter.date(from: month)
        dateFormatter.dateFormat = "MM"
        let mont = dateFormatter.string(from: formattedMonth!)
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/calendarlist", dictionary: ["month":mont,"year":year,"package":package], withHud: true) { (success, response, error) in
            self.arrayCalendarLists.removeAll()
            if success {
                if response!["status"] as! Bool == true {
                    let responseBase = CalendarListBase(dictionary: response as! NSDictionary)
                    self.arrayCalendarLists = (responseBase?.calendarData)!
                    self.arrayListsCalender.removeAll()
                    for dict in self.arrayCalendarLists {
                        if dict.available_status == true {
                            let dateFormatter = DateFormatter()
                            var jobDatesBetweenArray = [String]()
                            jobDatesBetweenArray = self.betWeenDates(fromDate: dict.start_date!, toDate: dict.end_date!)
                            for jobDatesF in jobDatesBetweenArray {
                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                let dateJob = dateFormatter.date(from: jobDatesF)
                                dateFormatter.dateFormat = "yyyy"
                                let year: String = dateFormatter.string(from: dateJob!)
                                dateFormatter.dateFormat = "MM"
                                let month: String = dateFormatter.string(from: dateJob!)
                                dateFormatter.dateFormat = "dd"
                                let day: String = dateFormatter.string(from: dateJob!)
                                let jobDictPerDate = JobsPerDate(Int(day)!, jobMonth: Int(month)!, jobYear: Int(year)!, jobCount: Int(day)!, jobFormatYear: jobDatesF, jobID: "")
                                self.arrayListsCalender.append(jobDictPerDate)
                            }
                        }
                    }
                    self.calenderView.arrayListToCalender = self.arrayListsCalender
                    self.calenderView.reload()
                    self.view.isUserInteractionEnabled = true
                }else{
                    
                }
            }else{
                showDefaultAlert(viewController: self, title: "", msg: "Failed..!")
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
    func betWeenDates(fromDate:String,toDate:String) -> [String] {
        var mydates : [String] = []
        let startDate = fromDate
        let endDate   = toDate
        var dateFrom =  Date()
        var dateTo = Date()
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        dateFrom = fmt.date(from: startDate)!
        dateTo = fmt.date(from: endDate)!
        while dateFrom <= dateTo {
            mydates.append(fmt.string(from: dateFrom))
            dateFrom = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
        }
        return mydates
    }
    
    func numberOfWeeksInMonth(_ date: Date) -> Int {
         var calendar = Calendar(identifier: .gregorian)
         calendar.firstWeekday = 1
         let weekRange = calendar.range(of: .weekOfMonth,
                                        in: .month,
                                        for: date)
         return weekRange!.count
    }
    
    func getNumberOfWeekes(year:Int,month:Int) -> Int {
        let dateComponents = DateComponents.init(year: year, month: month)
        let monthCurrentDayFirst = Calendar.current.date(from: dateComponents)!
        let monthNextDayFirst = Calendar.current.date(byAdding: .month, value: 1, to: monthCurrentDayFirst)!
        let monthCurrentDayLast = Calendar.current.date(byAdding: .day, value: -1, to: monthNextDayFirst)!
        return Calendar.current.component(.weekOfMonth, from: monthCurrentDayLast)
    }
    
    //MARK:- Convert Dateformat
    func convertDateFormat(dateString:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dat = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: dat!)
    }
    
    func getDayName(selectedDate:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let date = dateFormatter.date(from: selectedDate)
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date!)
        return dayInWeek
    }
}

extension AddNewOfferCalendarVC{
    
    func didTapDate(day: Int, date: String, available: Bool, selectedDates: [String]) {
        
     //   self.arrayUserDetails.removeAll()
     //   self.collectionChalletList.reloadData()
        
        print(selectedDates)
        
        if topSelection == "Week (B)"{
            if selectedDates.count > 6 {
                self.isSearchEnable = true
                self.btnCreateOffer.backgroundColor = UIColor("#6FDA44")
                self.startDate = convertDateFormat(dateString: selectedDates.first!)
                self.endDate = convertDateFormat(dateString: selectedDates.last!)
            }else{
                self.isSearchEnable = false
                self.btnCreateOffer.backgroundColor = UIColor("#C2C2C2")
                showDefaultAlert(viewController: self, title: "Message".localized(), msg: "You can't select this date".localized())
            }
        }else if topSelection == "Week (A)"{
            if selectedDates.count > 6 {
                self.isSearchEnable = true
                self.btnCreateOffer.backgroundColor = UIColor("#6FDA44")
                self.startDate = convertDateFormat(dateString: selectedDates.first!)
                self.endDate = convertDateFormat(dateString: selectedDates.last!)
            }else{
                self.isSearchEnable = false
                self.btnCreateOffer.backgroundColor = UIColor("#C2C2C2")
                showDefaultAlert(viewController: self, title: "Message".localized(), msg: "You can't select this date".localized())
            }
        }else if topSelection == "Weekend"{
            if selectedDates.count > 2 {
                self.isSearchEnable = true
                self.btnCreateOffer.backgroundColor = UIColor("#6FDA44")
                self.startDate = convertDateFormat(dateString: selectedDates.first!)
                self.endDate = convertDateFormat(dateString: selectedDates.last!)
            }else{
                self.isSearchEnable = false
                self.btnCreateOffer.backgroundColor = UIColor("#C2C2C2")
                showDefaultAlert(viewController: self, title: "Message".localized(), msg: "You can't select this date".localized())
            }
        }else if topSelection == "Weekdays"{
            if selectedDates.count > 3 {
                self.isSearchEnable = true
                self.btnCreateOffer.backgroundColor = UIColor("#6FDA44")
                self.startDate = convertDateFormat(dateString: selectedDates.first!)
                self.endDate = convertDateFormat(dateString: selectedDates.last!)
            }else{
                self.isSearchEnable = false
                self.btnCreateOffer.backgroundColor = UIColor("#C2C2C2")
                showDefaultAlert(viewController: self, title: "Message".localized(), msg: "You can't select this date".localized())
            }
        }
    }
    
    func didChangeMonth(monthIndex: Int, year: Int) {
        
        self.getCalendarList(month: "\(monthIndex)", year: "\(year)", package: topSelection)
        self.isSearchEnable = false
        self.btnCreateOffer.backgroundColor = UIColor("#C2C2C2")

    }
    
    func showPopupMaxLimit() {
        print("Maximum 30 dates can be selected")
    }
    
    func noChaletAvailable() {
        showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Package is not available".localized())
    }
    
    func delegateChaletReserved() {
        showDefaultAlert(viewController: self, title: "Message".localized(), msg: "All the chalets are booked for this period".localized())
    }
}
