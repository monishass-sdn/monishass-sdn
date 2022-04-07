//
//  confirmReservationVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 01/03/22.
//

import UIKit
import SVProgressHUD

class confirmReservationVC: UIViewController {
    var arrayUserDetails : User_details!
    var dictOfferUserDetails : Offer_Chalet_list!
    var arryReservedChaletDetails = [Reserved_Chalet_details]()
    @IBOutlet weak var chalet_image: UIImageView!
    @IBOutlet weak var timeLabel:UILabel!
    @IBOutlet weak var lbl_checkin: UILabel!
    @IBOutlet weak var lbl_checkout: UILabel!
    @IBOutlet weak var lbl_rent : UILabel!
    @IBOutlet weak var lbl_chaletid: UILabel!
    @IBOutlet weak var lbl_chaletName: UILabel!
    @IBOutlet weak var lbl_rewardDiscount: UILabel!
    @IBOutlet weak var lbl_offerDiscount: UILabel!
    @IBOutlet weak var lbl_TotalInvoice: UILabel!
    @IBOutlet weak var lbl_RemainingAmt: UILabel!
    @IBOutlet weak var lbl_Deposit: UILabel!

    var timer = Timer()
    var seconds = 3600   // change this value according to the time
    var isTimerRunning : Bool = false
    
    var deposit = "0"
    var rewards = "0"
    var offerDiscount = ""
    var remainingAmount = "0"
    var totalPaid = "0"
    var selectedpackage = ""
    var isFromOffer = false
    var isClickDeposit = false
    var isClickRewards = false
    var email = ""
    var phone = ""
    var civilid = ""
    var firstName = ""
    
    var chalet_id = ""
    var check_in = ""
    var check_out = ""
    var rent = ""
    var reward_Discount = ""
    var offer_Dis = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if isTimerRunning == false {
              runTimer()
         }
        self.setUpNavigationBar()
        setValuestotheFields()
        // Do any additional setup after loading the view.
    }
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Confirmation".localized()
        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    @objc func backButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setValuestotheFields(){
        if isFromOffer == false{
            
            self.lbl_TotalInvoice.font = UIFont(name: "Roboto-Bold", size: 22)
            self.lbl_RemainingAmt.font = UIFont(name: "Roboto-Bold", size: 22)
            
            let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 20)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)] as [NSAttributedString.Key : Any]
            let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 20)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)] as [NSAttributedString.Key : Any]
            
            let attributedStringDiscount = NSMutableAttributedString(string:"KD ", attributes:attrs1)
            let attributedDiscountKD = NSMutableAttributedString(string: deposit, attributes:attrs2)
            attributedStringDiscount.append(attributedDiscountKD)
            self.lbl_Deposit.attributedText = attributedStringDiscount
            
            let attributedStringKD2 = NSMutableAttributedString(string:"KD ", attributes:attrs1)
            let attributedRewardDiscount = NSMutableAttributedString(string: "-\(arrayUserDetails.rewarded_amt!)", attributes:attrs2)
            attributedStringKD2.append(attributedRewardDiscount)
            self.lbl_rewardDiscount.attributedText = attributedStringKD2
            
            let attributedStringKD3 = NSMutableAttributedString(string:"KD ", attributes:attrs1)
            let attributedOfferDiscount = NSMutableAttributedString(string: "-\(offerDiscount)", attributes:attrs2)
            attributedStringKD3.append(attributedOfferDiscount)
            self.lbl_offerDiscount.attributedText = attributedStringKD3
            
            
            
            
            self.lbl_rent.text = arrayUserDetails.rent
            self.lbl_checkin.text = arrayUserDetails.check_in
            self.lbl_checkout.text = arrayUserDetails.check_out
            self.lbl_chaletName.text = arrayUserDetails.chalet_name
            self.lbl_chaletid.text = "No.\(arrayUserDetails.chalet_id!)"
            self.lbl_TotalInvoice.text = "KD \(arrayUserDetails.rent!)"
            self.lbl_RemainingAmt.text = "KD \(remainingAmount)"
            if arrayUserDetails.cover_photo != ""{
                chalet_image.sd_setImage(with: URL(string: arrayUserDetails.cover_photo!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
            }else{
                chalet_image.image = kPlaceHolderImage
            }
            
            chalet_id = String(arrayUserDetails.chalet_id!)
            check_in = arrayUserDetails.check_in!
            check_out = arrayUserDetails.check_out!
            rent = arrayUserDetails.rent!
            reward_Discount = String(arrayUserDetails.rewarded_amt!)
            let offerDis = arrayUserDetails.Offer_discount_amt == nil ? "0" : "0"
            offer_Dis = offerDis
        }else{
            
            self.lbl_TotalInvoice.font = UIFont(name: "Roboto-Bold", size: 22)
            self.lbl_RemainingAmt.font = UIFont(name: "Roboto-Bold", size: 22)
            
            let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 20)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)] as [NSAttributedString.Key : Any]
            let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 20)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)] as [NSAttributedString.Key : Any]
            
            let attributedStringDiscount = NSMutableAttributedString(string:"KD ", attributes:attrs1)
            let attributedDiscountKD = NSMutableAttributedString(string: deposit, attributes:attrs2)
            attributedStringDiscount.append(attributedDiscountKD)
            self.lbl_Deposit.attributedText = attributedStringDiscount
            
            let attributedStringKD2 = NSMutableAttributedString(string:"KD ", attributes:attrs1)
            let attributedRewardDiscount = NSMutableAttributedString(string: "-\(dictOfferUserDetails.rewarded_amt!)", attributes:attrs2)
            attributedStringKD2.append(attributedRewardDiscount)
            self.lbl_rewardDiscount.attributedText = attributedStringKD2
            
            let attributedStringKD3 = NSMutableAttributedString(string:"KD ", attributes:attrs1)
            let attributedOfferDiscount = NSMutableAttributedString(string: "-\(offerDiscount)", attributes:attrs2)
            attributedStringKD3.append(attributedOfferDiscount)
            self.lbl_offerDiscount.attributedText = attributedStringKD3
            
            self.lbl_rent.text = String(dictOfferUserDetails.rent!)
            self.lbl_checkin.text = dictOfferUserDetails.check_in
            self.lbl_checkout.text = dictOfferUserDetails.check_out
           // self.lbl_Deposit.text = "KD \(deposit)"
           // self.lbl_rewardDiscount.text = "KD \(dictOfferUserDetails.rewarded_amt!)"
            self.lbl_chaletName.text = dictOfferUserDetails.chalet_name
            self.lbl_chaletid.text = "No.\(dictOfferUserDetails.chalet_id!)"
            self.lbl_TotalInvoice.text = "KD \(dictOfferUserDetails.rent!)"
           // self.lbl_offerDiscount.text = "KD \(offerDiscount)"
            self.lbl_RemainingAmt.text = "KD \(remainingAmount)"
            if dictOfferUserDetails.cover_photo != ""{
                chalet_image.sd_setImage(with: URL(string: dictOfferUserDetails.cover_photo!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
            }else{
                chalet_image.image = kPlaceHolderImage
            }
            
            chalet_id = String(dictOfferUserDetails.chalet_id!)
            check_in = dictOfferUserDetails.check_in!
            check_out = dictOfferUserDetails.check_out!
            rent = String(dictOfferUserDetails.rent!)
            reward_Discount = String(dictOfferUserDetails.rewarded_amt!)
            offer_Dis = String(dictOfferUserDetails.discount_amt!)
        }
        

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
            self.navigationController?.popViewController(animated: true)
        } else {
             seconds -= 1
           self.timeLabel.text = timeString(time: TimeInterval(seconds))
        }
    }
    func timeString(time:TimeInterval) -> String {
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes,seconds)
    }
    

    @IBAction func goBackBtn_Tapped(_ sender:UIButton!){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmOffer(_ sender: UIButton){
        sendReservationConfirmation()
    }

}

extension confirmReservationVC{
    func sendReservationConfirmation() {
        let userid = CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : ""
        var reservID = ""
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/reservation-request", dictionary: ["userid":userid,"chaletid":chalet_id, "selected_package":selectedpackage,"check_in":check_in,"check_out":check_out,"deposit":deposit,"rent":rent,"total_paid":totalPaid,"reward_discount":reward_Discount,"offer_discount":offer_Dis], withHud: true) { (success, response, error) in
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = ReservationRequestResponseModel(dictionary: response as! NSDictionary)
                    self.arryReservedChaletDetails = (responseBase?.chalet_details)!
                    reservID = response!["reservation_id"] as! String
                    let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ReservationApprovalVC") as! ReservationApprovalVC
                    nextVC.reservation_id = reservID
                    nextVC.reservedChaletData = self.arryReservedChaletDetails
                    nextVC.isFromOffer = self.isFromOffer
                    nextVC.dictOfferUserDetail = self.dictOfferUserDetails
                    nextVC.selectedPackage = self.selectedpackage
                    nextVC.isClickRewards = self.isClickRewards
                    nextVC.isClickDeposit = self.isClickDeposit
                    nextVC.email = self.email
                    nextVC.phone = self.phone
                    nextVC.civilid = self.civilid
                    nextVC.firstName = self.firstName
                    nextVC.remainingamt = self.remainingAmount
                    self.navigationController?.pushViewController(nextVC, animated: true)
   
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.view.isUserInteractionEnabled = true
                    }
                }else{
                    self.view.isUserInteractionEnabled = true
                    showDefaultAlert(viewController: self, title: "", msg: response!["message"]! as! String)
                }
            }else{
                showDefaultAlert(viewController: self, title: "", msg: "Failed..!")
            }
        }
    }
}
