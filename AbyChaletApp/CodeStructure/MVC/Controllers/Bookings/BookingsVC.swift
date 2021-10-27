//
//  BookingsVC.swift
//  AbyChaletApp
//
//  Created by Visakh Srishti on 24/05/21.
//

import UIKit
import KDCircularProgress
import MFSDK
import SVProgressHUD
import CoreLocation

class BookingsVC: UIViewController {

    
    @IBOutlet weak var tableViewBooking: UITableView!

    var noRsrvtnmessage: String = ""
    var status = "Active"
    let status1 = "NotActive"
    var arrayMyBooking = [MyBooking_details]()
    var arrayRewards = [Reward_details]()
    var paymentMethods: [MFPaymentMethod]?
    var selectedPaymentMethodIndex = 4
    var selectedIndex = 0
    let productList = NSMutableArray()
    var isLoad = false
    var isUSerIsBlocked = false
    var dictRewardDetails = NSDictionary()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        appDelegate.checkBlockStatus()
      //  self.tableViewBooking.register(NoBookingTVCell.self, forCellReuseIdentifier: "NoBookingTVCell")

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CAUser.currentUser.id != nil{
            self.getMyBookigData()
        }else{
            self.isLoad = true
        }
        initiatePayment()
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
        self.navigationItem.title = "My Booking".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        
    }
    
    
    //MARK:- ButtonActions
    //MARK:- Done button action keyboard
    @objc func doneButtonClicked() {
        self.view.endEditing(true)
    }
    @objc func notificationButtonTouched()  {
        
        
    }
    
    @IBAction func btnCopyAction(_ sender: UIButton) {
        
        let arr = self.arrayMyBooking[sender.tag].myBookingChalet_details?.first
        UIPasteboard.general.string = arr!.location!
        self.tableViewBooking.reloadRows(at: [IndexPath(row: sender.tag, section: 1)], with: .none)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 10)) {
            sender.setTitle("Copied".localized(), for: .normal)
            self.tableViewBooking.reloadRows(at: [IndexPath(row: sender.tag, section: 1)], with: .none)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            sender.setTitle("Copy".localized(), for: .normal)
            self.tableViewBooking.reloadRows(at: [IndexPath(row: sender.tag, section: 1)], with: .none)
        }
    }
    @IBAction func buttonPaymentNowAction(_ sender: UIButton) {
        
        if isUSerIsBlocked == false {
            self.selectedIndex = sender.tag
            if CAUser.currentUser.id != nil {
                self.intialisePaymentWithType()
            }else{
                let alert = UIAlertController(title: "Message", message: "Please Login for booking. Do you want to continue?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    let loginSignUpViewController = UIStoryboard(name: "Profile", bundle: Bundle.main).instantiateViewController(identifier: "LoginSignUpViewController") as! LoginSignUpViewController
                    loginSignUpViewController.isFromNoLogin = true
                    self.navigationController?.pushViewController(loginSignUpViewController, animated: true)
                }))
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Your Account has been Blocked. Please contact Administrator.")
            appDelegate.checkBlockStatus()
        }
        
    }
    @IBAction func btnClickMapAction(_ sender: UIButton) {
        let dict = self.arrayMyBooking[sender.tag]
        let arrayBookingDetails = dict.myBookingChalet_details?.first
        let long = Double(arrayBookingDetails!.latitude!)
        let round = long?.rounded(toPlaces: 6)
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(arrayBookingDetails!.longitude!),\(arrayBookingDetails!.latitude!)&zoom=14&views=traffic&q=\(arrayBookingDetails!.longitude!),\(arrayBookingDetails!.latitude!)")!, options: [:], completionHandler: nil)
        } else {
            print("Can't use comgooglemaps://")
        }
    }
    @IBAction func btnCallusWhatsapAction(_ sender: UIButton) {
        let dict = self.arrayMyBooking[sender.tag]
        let arrayBookingDetails = dict.myBookingChalet_details?.first
        if let phone = arrayBookingDetails?.default_callus {
            if phone != "" {
                let urlWhats = "whatsapp://app"
                if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed) {
                    if let whatsappURL = URL(string: urlString) {
                        if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                            UIApplication.shared.open(NSURL(string: "whatsapp://send?phone=\(phone)")! as URL)
                        }else{
                            showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Please install Whatsapp")
                        }
                    }
                }
            }
        }
    }
    
    
}
extension BookingsVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0  {
            return self.arrayRewards.count
        }else{
            if isLoad == true {
                return self.arrayMyBooking.count != 0 ? self.arrayMyBooking.count : 1
            }else{
                return 0
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingRewardsTVCell", for: indexPath) as! BookingRewardsTVCell
            cell.setValuesToFields(dictReward: arrayRewards[indexPath.row])
            cell.setupProgressBar(dictReward: arrayRewards[indexPath.row])
            return cell
        }else{
            if arrayMyBooking.count > 0 {
                let dict = self.arrayMyBooking[indexPath.row]
                
                if dict.active_status == "not_active"{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "InActiveBookingTVCell", for: indexPath) as! InActiveBookingTVCell
                    cell.setValuesToFields(dict: self.arrayMyBooking[indexPath.row])
                    return cell
                    
                }else if dict.active_status == "not_available"{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NotAvailableBookingTVCell", for: indexPath) as! NotAvailableBookingTVCell
                    cell.setValuesToFields(dict: self.arrayMyBooking[indexPath.row])
                    return cell
                    
                }else if dict.active_status == "active"{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ActiveBookingTVCell", for: indexPath) as! ActiveBookingTVCell
                    cell.setValuesToFields(dict: self.arrayMyBooking[indexPath.row])
                    cell.btnCopy.tag = indexPath.row
                    cell.btnClickMap.tag = indexPath.row
                    cell.btnCallUs.tag = indexPath.row
                    return cell
                    
                }else if dict.active_status == "awaiting_payment"{
                    
                    if dict.booking_status == "booked"{
                        let cell = tableView.dequeueReusableCell(withIdentifier: "AwaitingBookingTVCell", for: indexPath) as! AwaitingBookingTVCell
                        cell.btnPay.tag = indexPath.row
                        cell.setValuesToFields(dict: self.arrayMyBooking[indexPath.row])
                        return cell
                    }else{
                        let cell = tableView.dequeueReusableCell(withIdentifier: "CancelledBookingTVCell", for: indexPath) as! CancelledBookingTVCell
                        cell.setValuesToFields(dict: self.arrayMyBooking[indexPath.row])
                        return cell
                    }
                    
                }else{
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NoBookingTVCell", for: indexPath) as! NoBookingTVCell
                    return cell
                }
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "NoBookingTVCell", for: indexPath) as! NoBookingTVCell
                return cell
                
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            if self.arrayMyBooking.count > 0 {
                let dict = self.arrayMyBooking[indexPath.row]
                if dict.active_status == "not_available"{
                    showDefaultAlert(viewController: self, title: "", msg: "This chalet is not currently available in the application")
                }else{
                    let bookingDetailTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "BookingDetailTVC") as! BookingDetailTVC
                    bookingDetailTVC.dictMyBooking = self.arrayMyBooking[indexPath.row]
                    self.navigationController?.pushViewController(bookingDetailTVC, animated: true)
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 190
        }else {
            
            if arrayMyBooking.count > 0 {
                let dict = self.arrayMyBooking[indexPath.row]
                if dict.active_status == "not_active"{
                    return 171
                }else if dict.active_status == "not_available"{
                    return 171
                }else if dict.active_status == "active"{
                    return 321
                        //286
                }else if dict.active_status == "awaiting_payment"{
                    if dict.booking_status == "booked"{
                        return 311
                    }else{
                        return 171
                    }
                }else if dict.active_status == ""{
                    return 0
                }else{
                    return 174
                }
            }else{
                return 174
            }
        }
    }
}
extension BookingsVC {
    
    //MARK:- GetMyBookingData
    func getMyBookigData() {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/mybooking", dictionary: ["userid":CAUser.currentUser.id!], withHud: true) { (success, response, error) in
            self.isLoad = true
            DispatchQueue.main.async {
                self.checkBlockStatus()
            }
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = MyBookingBase(dictionary: response as! NSDictionary)
                    self.arrayRewards = (responseBase?.reward_details)!
                    self.arrayMyBooking = (responseBase?.myBooking_details)!
                    DispatchQueue.main.async {
                        self.isLoad = true
                        if self.arrayRewards.count > 0{
                           // self.getRewardDetails(rewardAmount: (self.arrayRewards.first?.reward_earn!)!, reservationAmount: (self.arrayRewards.first?.total!)!)
                        }
                        self.tableViewBooking.reloadData()
                        self.view.isUserInteractionEnabled = true
                    }
                }else{
                    self.tableViewBooking.reloadData()
                    self.view.isUserInteractionEnabled = true
                    //showDefaultAlert(viewController: self, title: "", msg: response!["message"]!)
                }
            }else{
                showDefaultAlert(viewController: self, title: "", msg: "Failed..!".localized())
                self.view.isUserInteractionEnabled = true
            }
        }
    }
}

extension BookingsVC {
    //MARK:- Payment Integration
    func initiatePayment() {
        let request = generateInitiatePaymentModel()
        SVProgressHUD.show()
        MFPaymentRequest.shared.initiatePayment(request: request, apiLanguage: .english, completion: { [weak self] (result) in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let initiatePaymentResponse):
                self?.paymentMethods = initiatePaymentResponse.paymentMethods
            case .failure(let failError):
                showDefaultAlert(viewController: self!, title: "Failed..!", msg: "result: \(failError)")
            }
        })
    }
    func intialisePaymentWithType() {
        if let paymentMethods = paymentMethods, !paymentMethods.isEmpty {
            let selectedIndex = selectedPaymentMethodIndex
            executePayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
        }
    }
    func executePayment(paymentMethodId: Int) {
        let request = getExecutePaymentRequest(paymentMethodId: paymentMethodId)
        SVProgressHUD.show()
        MFPaymentRequest.shared.executePayment(request: request, apiLanguage: .english) { [weak self] response, invoiceId  in
            SVProgressHUD.dismiss()
            switch response {
            case .success(let executePaymentResponse):
                if let invoiceStatus = executePaymentResponse.invoiceStatus {
                   // showDefaultAlert(viewController: self!, title: "Success..!", msg: "result: \(invoiceStatus)")
                    let dict = self?.arrayMyBooking[(self?.selectedIndex)!]
                    let dataDict = executePaymentResponse.invoiceTransactions?.first!
                    let renta = Int(dict!.rent!)
                    let totalPaid = Int(dict!.total_paid!)
                    let remainingAmt : Int = Int(renta! - totalPaid!)
                    DispatchQueue.main.async {
                        self?.payRemainingAmount(reservationId: "\((dict?.id!)!)", totalPaid: "\(remainingAmt)", paymentGateway: (dataDict?.paymentGateway!)!,paymentId: (dataDict?.paymentID!)!,authId: (dataDict?.authorizationID!)!,trackId: (dataDict?.trackID!)!,transcationId: (dataDict?.transactionID)!,invoiceReference: executePaymentResponse.invoiceReference!,referenceId: (dataDict?.referenceID)!)
                    }
                }
            case .failure(let failError):
                showDefaultAlert(viewController: self!, title: "Failed..!", msg: "result: \(failError)")
            }
        }
    }
     func getExecutePaymentRequest(paymentMethodId: Int) -> MFExecutePaymentRequest {
        
        let amountDict = self.arrayMyBooking[(self.selectedIndex)]
        
        let renta = Int(amountDict.rent!)
        let totalPaid = Int(amountDict.total_paid!)
        let rewardsUsed = Int(amountDict.reward_discount!) ?? 0
        let remainingAmt : Int = Int(renta! - totalPaid! - rewardsUsed)
        let rent = "\(remainingAmt)"
        
        let dict = self.arrayMyBooking[(self.selectedIndex)].myBookingChalet_details!.first!
        
        
        let invoiceValue = Decimal(string: rent ) ?? 0
        let request = MFExecutePaymentRequest(invoiceValue: invoiceValue , paymentMethod: paymentMethodId)
        //request.userDefinedField = ""
        request.customerEmail = dict.email!// must be email
        request.customerMobile = dict.phone!
        request.customerCivilId = dict.civil_id!
        request.customerName = dict.firstname!
        let address = MFCustomerAddress(block: "ddd", street: "sss", houseBuildingNo: "sss", address: "sss", addressInstructions: "sss")
        request.customerAddress = address
        request.customerReference = "Test MyFatoorah Reference"
        request.language = .english
        request.mobileCountryCode = MFMobileCountryCodeISO.kuwait.rawValue
        request.displayCurrencyIso = .kuwait_KWD
//        request.supplierValue = 1
//        request.supplierCode = 2
//        request.suppliers.append(MFSupplier(supplierCode: 1, proposedShare: 2, invoiceShare: invoiceValue))
        
        // Uncomment this to add products for your invoice
//         var productList = [MFProduct]()
//        let product = MFProduct(name: "ABC", unitPrice: 1.887, quantity: 1)
//         productList.append(product)
//         request.invoiceItems = productList
        return request
    }
    
    private func generateInitiatePaymentModel() -> MFInitiatePaymentRequest {
        // you can create initiate payment request with invoice value and currency
        // let invoiceValue = Double(amountTextField.text ?? "") ?? 0
        // let request = MFInitiatePaymentRequest(invoiceAmount: invoiceValue, currencyIso: .kuwait_KWD)
        // return request
        
        let request = MFInitiatePaymentRequest()
        return request
    }
}
extension BookingsVC {
    
    func payRemainingAmount(reservationId:String,totalPaid:String,paymentGateway:String,paymentId:String,authId:String,trackId:String,transcationId:String,invoiceReference:String,referenceId:String)  {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/remainingpay", dictionary: ["reservation_id":reservationId,"total_paid":totalPaid,"payment_gateway":paymentGateway,"payment_id":paymentId,"authorization_id":authId,"track_id":trackId,"transaction_id":transcationId,"invoice_reference":invoiceReference,"reference_id":referenceId], withHud: true) { (success, response, error) in
            self.view.isUserInteractionEnabled = true
            if success {
                if ((response as! NSDictionary)["status"] as! Bool) == true {
                    DispatchQueue.main.async {
                        showDefaultAlert(viewController: self, title: "Message", msg: "Payment Successfull")
                        self.getMyBookigData()
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "Message", msg: "Something went wrong")
                    self.view.isUserInteractionEnabled = true
                }
            }else{
                showDefaultAlert(viewController: self, title: "Message", msg: error!.localizedDescription)
                self.view.isUserInteractionEnabled = true
            }
        }
        
    }
    
    func checkBlockStatus() {
        if CAUser.currentUser.id != nil {
            ServiceManager.sharedInstance.postMethodAlamofire("api/block_user", dictionary: ["userid": CAUser.currentUser.id!], withHud: true) { [self] (success, response, error) in
                self.checkNotificationCount()
                if success {
                    let status = ((response as! NSDictionary)["status"] as! Bool)
                    if status{
                        self.isUSerIsBlocked = false
                    }else{
                        self.isUSerIsBlocked = true
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "Message".localized(), msg: error!.localizedDescription)
                }
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
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

