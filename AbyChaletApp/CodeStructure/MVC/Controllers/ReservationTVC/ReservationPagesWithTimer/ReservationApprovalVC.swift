//
//  ReservationApprovalVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 02/03/22.
//

import UIKit
import SVProgressHUD
import MFSDK

class ReservationApprovalVC: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var chalet_image : UIImageView!
    @IBOutlet weak var lblchalet_id : UILabel!
    @IBOutlet weak var lblchalet_name : UILabel!
    @IBOutlet weak var lblcheck_out : UILabel!
    @IBOutlet weak var lblchech_in : UILabel!
    @IBOutlet weak var lblrent : UILabel!
    @IBOutlet weak var lbldeposit : UILabel!
    @IBOutlet weak var lblreward_Dis : UILabel!
    @IBOutlet weak var lbloffer_Dis : UILabel!
    @IBOutlet weak var lbltotal_invoice : UILabel!
    @IBOutlet weak var lblremaining_Amt : UILabel!
    @IBOutlet weak var lblpayDateBefore : UILabel!
    @IBOutlet weak var view_cancelReservation : UIView!
    @IBOutlet weak var status_Image : UIImageView!
    @IBOutlet weak var status_Label : UILabel!
    @IBOutlet weak var btnPayment : UIButton!
    @IBOutlet weak var height_RemainingAmntPayDateView : NSLayoutConstraint!
    @IBOutlet weak var height_Scrollview : NSLayoutConstraint!

    @IBOutlet weak var lblYouHave30minMsg : UILabel!
    @IBOutlet weak var viewRemainingAmt : UIView!
    @IBOutlet weak var viewBookingDetail : UIView!
    
    var arrayUserDetails : User_details!
    var reservedChaletData : [Reserved_Chalet_details]?
    var dictOfferUserDetail : Offer_Chalet_list!
    var paymentMethods: [MFPaymentMethod]?
    var dictBookingDetails = Booking_details(dictionary: NSDictionary())
    var selectedIndex : Int!
    var selectedPaymentMethodIndex = 4
    var rewards = 0
    var isUnpaidDone = true
    var isClickDeposit = false
    var isClickRewards = false
    var reservation_id = ""
    var timer = Timer()
    var seconds = 36000   // change this value according to the time
    var isTimerRunning : Bool = false
    var isOwnerChangedStatus : Bool = false
    var isUSerIsBlocked = false
    var isFromOffer : Bool = false
    var selectedPackage = ""
    var email = ""
    var phone = ""
    var civilid = ""
    var firstName = ""
    var remainingamt = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if isTimerRunning == false {
              runTimer()
         }
        setUpNavigationBar()
        setValuestotheFields()
        print("Reservation Id = \(reservation_id)")
        print("Remaining AMount = \(remainingamt)")
    /*
        let dict:NSDictionary = NSKeyedUnarchiver.unarchiveObject(with: (UserDefaults.standard.object(forKey: "kCurrentReservationDetails") as! NSData) as Data) as! NSDictionary
        CAReservationRequestModel.reservedDetails.initWithDictionary(userDictionary: dict)
        CAReservationRequestModel.saveReservationDetails(dictDetails: dict)
        UserDefaults.standard.setValue(0, forKey: "ReservationApprovalView")
        print("saved value test = \(CAReservationRequestModel.reservedDetails.chaletName)")
*/
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initiatePayment()
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Approval of the reservation".localized()
        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func setValuestotheFields(){
        self.lblchalet_id.text = String((reservedChaletData?.first?.chalet_id!)!)
        self.lblchalet_name.text = reservedChaletData?.first?.chaletName
        self.lblchech_in.text = reservedChaletData?.first?.check_in
        self.lblcheck_out.text = reservedChaletData?.first?.check_out
        self.lblrent.text = reservedChaletData?.first?.rent
        self.lbldeposit.text = reservedChaletData?.first?.deposit
        self.lblreward_Dis.text = reservedChaletData?.first?.reward_discount
        self.lbloffer_Dis.text = reservedChaletData?.first?.offer_discount
        self.lbltotal_invoice.text = reservedChaletData?.first?.rent
        self.lblremaining_Amt.text = String((reservedChaletData?.first?.remaining)!)
        self.lblpayDateBefore.text = reservedChaletData?.first?.payBytime
        if reservedChaletData?.first?.cover_photo != ""{
            chalet_image.sd_setImage(with: URL(string: (reservedChaletData?.first?.cover_photo)!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
        }else{
            chalet_image.image = kPlaceHolderImage
        }
        
     //   if String((reservedChaletData?.first?.remaining)!) == ""{
        if self.remainingamt == "0"{
            self.viewRemainingAmt.isHidden = true
            self.height_RemainingAmntPayDateView.constant = 0.0
            self.height_Scrollview.constant = 920
        //    self.viewBookingDetail.cornerRadius = 10

        }else{
            self.viewRemainingAmt.isHidden = false
            self.height_RemainingAmntPayDateView.constant = 240.0
          //  self.viewRemainingAmt.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10)
          //  self.viewBookingDetail.roundCorners(corners: [.topLeft,.topRight], radius: 10)
            self.height_Scrollview.constant = 1160

        }
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 18)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 18)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.8352941176, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedString1 = NSMutableAttributedString(string:"If your Reservation is Approved You have ", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string: "30", attributes:attrs2)
        let attributedString3 = NSMutableAttributedString(string: " Minutes to Pay", attributes:attrs1)

        attributedString1.append(attributedString2)
        attributedString1.append(attributedString3)
        self.lblYouHave30minMsg.attributedText = attributedString1


    }
    
    @objc func timerClass(){
        seconds -= 1
        self.timeLabel.text = String(seconds)
    }
    
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(confirmReservationVC.updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if seconds < 1 {
             timer.invalidate()
             //Send alert to indicate "time's up!"
            let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "TimerEndVC") as! TimerEndVC
            self.navigationController?.pushViewController(nextVC, animated: true)

        } else {
             seconds -= 1
             self.timeLabel.text = timeString(time: TimeInterval(seconds))
            if self.isOwnerChangedStatus == false{
                checkReservationStatus()
            }else{
            }
             
        }
    }
    
    func timeString(time:TimeInterval) -> String {
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes,seconds)
    }
    
    //MARK:- Cancel Reservation
    
    @IBAction func tapped_cancelReservation(_ sender: UIButton){
        let alert = UIAlertController(title: "Cancel !!", message: "Are you sure to Cancel this reservation", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.cancelReservationStatus()
            let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ReservationCancelledbyUserVC") as! ReservationCancelledbyUserVC
            self.navigationController?.pushViewController(nextVC, animated: true)
            //self.popBack(3)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    //MARK:- Payment Action
    
    @IBAction func payment_Now(_ sender: UIButton){
        if isUSerIsBlocked == false {
                 if CAUser.currentUser.id != nil {
                     intialisePaymentWithType()
                 }else{
                     let alert = UIAlertController(title: "Message".localized(), message: "Please Login for booking. Do you want to continue?".localized(), preferredStyle: .alert)
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
             showDefaultAlert(viewController: self, title: "Message".localized(), msg: "Your Account has been Blocked. Please contact Administrator.".localized())
             appDelegate.checkBlockStatus()
         }
    }
    
    //MARK:- Payment Integration
    
    func intialisePaymentWithType() {
        if let paymentMethods = paymentMethods {
            let selectedIndex = selectedPaymentMethodIndex
            executePayment(paymentMethodId: paymentMethods[selectedIndex].paymentMethodId)
        }
    }
    
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
    
    
    func executePayment(paymentMethodId: Int) {
        let request = getExecutePaymentRequest(paymentMethodId: paymentMethodId)
        SVProgressHUD.show()
        MFPaymentRequest.shared.executePayment(request: request, apiLanguage: .english) { [weak self] response, invoiceId  in
            SVProgressHUD.dismiss()
            switch response {
            case .success(let executePaymentResponse):
                if let invoiceStatus = executePaymentResponse.invoiceStatus {

                    let dataDict = executePaymentResponse.invoiceTransactions?.first!
                    
                    if self!.isFromOffer == false {
                        let dict = self!.reservedChaletData
                
                        
                        self!.chaletBooking(chaletId: "\((dict?.first?.chalet_id!)!)", selectedPackage: self!.selectedPackage, checkIn: (dict?.first?.check_in!)!, checkOut: (dict?.first?.check_out!)!, deposit: self!.isClickDeposit == false ? "0" : (dict?.first?.deposit!)!, rent: (dict?.first?.rent!)!, totalPaid: self!.isClickDeposit == false ? self!.isClickRewards == true ? "\(Int((dict?.first?.rent!)!)! - self!.rewards)" : (dict?.first?.rent!)! : (dict?.first?.deposit!)!,offerDiscount: "0",paymentGateway: (dataDict?.paymentGateway!)!,paymentId: (dataDict?.paymentID!)!,authId: (dataDict?.authorizationID!)!,trackId: (dataDict?.trackID!)!,transcationId: (dataDict?.transactionID)!,invoiceReference: executePaymentResponse.invoiceReference!,referenceId: (dataDict?.referenceID)!, serverUrl: "api/booking", rewarDiscount: self!.isClickRewards == false ? "0" : String((dict?.first?.reward_discount)!))
                        
                    }else{
                        let dict = self!.dictOfferUserDetail
                        let dis = "\(dict!.min_deposit!)"
                        let ren = "\(dict!.rent!)"
                        let offerdis = "\(dict!.discount_amt!)"
                        print("Discount Amount = \(offerdis)")
                        
                        self!.chaletBooking(chaletId: "\((dict?.chalet_id!)!)", selectedPackage: self!.selectedPackage, checkIn: (dict?.check_in!)!, checkOut: (dict?.check_out!)!, deposit: self!.isClickDeposit == false ? "0" : dis, rent: ren, totalPaid: self!.isClickDeposit == false ? self!.isClickRewards == true ? "\(Int(dict!.rent!) - self!.rewards)" : ren : dis, offerDiscount: offerdis ,paymentGateway: (dataDict?.paymentGateway!)!,paymentId: (dataDict?.paymentID!)!,authId: (dataDict?.authorizationID!)!,trackId: (dataDict?.trackID!)!,transcationId: (dataDict?.transactionID)!,invoiceReference: executePaymentResponse.invoiceReference!,referenceId: (dataDict?.referenceID)!, serverUrl: "api/booking", rewarDiscount: "0")
                        
                    }
                }
            case .failure(let failError):
                print(failError)
                if self?.isUnpaidDone == true{
                    self?.isUnpaidDone = false
                    //showDefaultAlert(viewController: self!, title: "Message", msg: "Payment gateway failed...!")
                    if  failError.errorDescription == "A server with the specified hostname could not be found." || failError.errorDescription == "Transaction not Captured!" {
                        if self!.isFromOffer == false {
                            let dict = self!.arrayUserDetails
                            DispatchQueue.main.async {
                                self!.chaletBooking(chaletId: "\((dict?.chalet_id!)!)", selectedPackage: self!.selectedPackage, checkIn: (dict?.check_in!)!, checkOut: (dict?.check_out!)!, deposit: self!.isClickDeposit == false ? "0" : (dict?.min_deposit!)!, rent: (dict?.rent!)!, totalPaid: self!.isClickDeposit == false ? (dict?.rent!)! : (dict?.min_deposit!)!, offerDiscount: "0",paymentGateway: "",paymentId: "",authId: "",trackId: "",transcationId: "",invoiceReference: "",referenceId: "", serverUrl: "api/paid_booking", rewarDiscount: self!.isClickRewards == false ? "0" : String((dict?.rewarded_amt)!))
                            }
                        }else{
                            let dict = self!.dictOfferUserDetail
                            let dis = "\(dict!.min_deposit!)"
                            let ren = "\(dict!.rent!)"
                            let offerDis = "\(dict!.discount_amt)"
                            DispatchQueue.main.async {
                                self!.chaletBooking(chaletId: "\((dict?.chalet_id!)!)", selectedPackage: self!.selectedPackage, checkIn: (dict?.check_in!)!, checkOut: (dict?.check_out!)!, deposit: self!.isClickDeposit == false ? "0" : dis, rent: ren, totalPaid: self!.isClickDeposit == false ? ren : dis, offerDiscount: offerDis,paymentGateway: "",paymentId: "",authId: "",trackId: "",transcationId: "",invoiceReference: "",referenceId: "", serverUrl: "api/paid_booking", rewarDiscount: "0")
                            }
                        }
                        
                    }else{
                        showDefaultAlert(viewController: self!, title: "Message", msg: failError.errorDescription)
                        
                    }
                }
            }
    }
    
    }
    
    func getExecutePaymentRequest(paymentMethodId: Int) -> MFExecutePaymentRequest {
       
       var rent = ""
        
        if isClickRewards == true{
            if isFromOffer == false {
                let ren = Int((reservedChaletData?.first?.rent)!)
                rent = "\(ren! - self.rewards)"
            }else{
                let ren = self.dictOfferUserDetail.rent!
                rent = "\(ren - self.rewards)"
            }
        }else{
            if isFromOffer == false && isClickDeposit == false && isClickRewards == false{
                rent = (reservedChaletData?.first?.rent)!
            }else if isFromOffer == true{
                rent = "\(self.dictOfferUserDetail.rent!)"
            }
        }
        
        if isClickDeposit == true{
            if isFromOffer == false {
                rent = (self.reservedChaletData?.first?.deposit)!
            }else{
                rent = "\(self.dictOfferUserDetail.min_deposit!)"
            }
        }else{
            if isFromOffer == false && isClickRewards == true{
                let ren = Int((self.reservedChaletData?.first?.rent!)!)
                rent = "\(ren! - self.rewards)"
            }else{
                if isFromOffer == false{
                    rent = (self.reservedChaletData?.first?.rent!)!
                }else{
                    rent = "\(self.dictOfferUserDetail.rent!)"
                }
            }
        }
       
        print("Calculated Payment Amount = \(rent)")
      //  let invoiceValue = rent
       let invoiceValue = Decimal(string: rent)
        let request = MFExecutePaymentRequest(invoiceValue: invoiceValue! , paymentMethod: paymentMethodId)
       //request.userDefinedField = ""
       if isFromOffer == false {
        request.customerEmail = email// must be email
        request.customerMobile = phone
        request.customerCivilId = civilid
        request.customerName = firstName
           let address = MFCustomerAddress(block: "ddd", street: "sss", houseBuildingNo: "sss", address: "sss", addressInstructions: "sss")
           request.customerAddress = address
           request.customerReference = "Test MyFatoorah Reference"
       }else{
           request.customerEmail = email// must be email
           request.customerMobile = phone
           request.customerCivilId = civilid
           request.customerName = firstName
           let address = MFCustomerAddress(block: "ddd", street: "sss", houseBuildingNo: "sss", address: "sss", addressInstructions: "sss")
           request.customerAddress = address
           request.customerReference = "Test MyFatoorah Reference"
       }
       request.language = .english
       request.mobileCountryCode = MFMobileCountryCodeISO.kuwait.rawValue
       request.displayCurrencyIso = .kuwait_KWD
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
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }


}

extension ReservationApprovalVC{
    
    //MARK:- Check Reservation Status
    func checkReservationStatus() {
        ServiceManager.sharedInstance.postMethodAlamofire("api/check-reservation-status", dictionary: ["reserv_id":reservation_id], withHud: false) { (success, response, error) in
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    if response!["booking_status"] as! String == "no_response"{
                        print("Owner yet to Take Decision")
                        self.view_cancelReservation.isHidden = true
                        self.btnPayment.isHidden = true
                    }else if response!["booking_status"] as! String == "not_accepted"{
                        print("Owner Rejected")
                        self.isOwnerChangedStatus = true
                        self.view_cancelReservation.isHidden = true
                        self.btnPayment.isHidden = true
                        let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ReservationRejectedVC") as! ReservationRejectedVC
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }else{
                        print("Owner Accepted")
                        self.isOwnerChangedStatus = true
                        self.view_cancelReservation.isHidden = false
                        self.status_Label.text = "Your reservation has been accepted You can pay now"
                        let successImage: UIImage = UIImage(named: "success_icon")!
                        self.status_Image.image = successImage
                        self.btnPayment.isHidden = false
                        self.timer.invalidate()
                        self.seconds = 1800
                        self.runTimer()
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "", msg: response!["message"]! as! String)
                }
            }else{
                showDefaultAlert(viewController: self, title: "", msg: "Failed..!")
            }
        }
    }
    
    //MARK:- Cancel Reservation
    
    func cancelReservationStatus() {
        ServiceManager.sharedInstance.postMethodAlamofire("api/cancel-reservation-request", dictionary: ["reserv_id":reservation_id], withHud: false) { (success, response, error) in
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    print("RESERVATION CANCELLED")
                }else{
                    showDefaultAlert(viewController: self, title: "", msg: response!["message"]! as! String)
                }
            }else{
                showDefaultAlert(viewController: self, title: "", msg: "Failed..!")
            }
        }
    }
    
    //MARK:- Booking API Call
    
    func chaletBooking(chaletId:String,selectedPackage:String,checkIn:String,checkOut:String,deposit:String,rent:String,totalPaid:String,offerDiscount:String,paymentGateway:String,paymentId:String,authId:String,trackId:String,transcationId:String,invoiceReference:String,referenceId:String,serverUrl:String,rewarDiscount:String) {
        if CAUser.currentUser.id != nil {
            ServiceManager.sharedInstance.postMethodAlamofire(serverUrl, dictionary: ["userid":CAUser.currentUser.id!,"chaletid":chaletId,"selected_package":selectedPackage,"check_in":checkIn,"check_out":checkOut,"deposit":deposit,"rent":rent,"total_paid":totalPaid,"reward_discount":rewarDiscount,"offer_discount":offerDiscount,"payment_gateway":paymentGateway,"payment_id":paymentId,"authorization_id":authId,"track_id":trackId,"transaction_id":transcationId,"invoice_reference":invoiceReference,"reference_id":referenceId], withHud: true) { (success, response, error) in
                print(self.rewards)
                if success {
                    if ((response as! NSDictionary)["status"] as! Bool) == true {
                        let responseBase = BookingDetailBase(dictionary: response as! NSDictionary)
                        self.dictBookingDetails = responseBase?.booking_details
                        print(responseBase?.booking_details)
                        DispatchQueue.main.async {
                            if serverUrl == "api/booking"{
                                if self.isFromOffer{
                                    let bookingDetailsTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "BookingDetailsTVC") as! BookingDetailsTVC
                                           bookingDetailsTVC.dictBookingDetails = self.dictBookingDetails
                                    bookingDetailsTVC.remainingAmtDate = (self.reservedChaletData?.first?.payBytime)!
                                           bookingDetailsTVC.isDeposit = self.isClickDeposit
                                           bookingDetailsTVC.isFrom = "Booked Successfully"
                                           self.navigationController?.pushViewController(bookingDetailsTVC, animated: true)
                                }else{
                                    let userInfo : [String:Any] = ["bookingData":self.dictBookingDetails!,"datentime" : (self.reservedChaletData?.first?.payBytime)!, "isDeposit" : self.isClickDeposit]
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationNames.KgoToSuccessPage), object: nil, userInfo: userInfo)
                                }
                            }else{
                                let paymentFailedTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "PaymentFailedTVC") as! PaymentFailedTVC
                                self.navigationController?.pushViewController(paymentFailedTVC, animated: true)
                            }
                        }
                    }else{
                        showDefaultAlert(viewController: self, title: "Message", msg: "Something went wrong")
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "Message", msg: error!.localizedDescription)
                }
            }
        }else{
            showDefaultAlert(viewController: self, title: "Message", msg: "Please Login for booking")
        }
    }
    
    func checkBlockStatus() {
        if CAUser.currentUser.id != nil {
            ServiceManager.sharedInstance.postMethodAlamofire("api/block_user", dictionary: ["userid": CAUser.currentUser.id!], withHud: true) { [self] (success, response, error) in
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
}
