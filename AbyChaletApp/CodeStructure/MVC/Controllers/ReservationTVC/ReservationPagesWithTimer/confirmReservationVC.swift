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
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Selected Chalet id = \(arrayUserDetails.chalet_id ?? 0)")
        if isTimerRunning == false {
              runTimer()
         }
        self.setUpNavigationBar()
        
        setValuestotheFields()
       // var offerDis = arrayUserDetails.Offer_discount_amt == nil ? "0" : "0"
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
        self.lbl_rent.text = arrayUserDetails.rent
        self.lbl_checkin.text = arrayUserDetails.check_in
        self.lbl_checkout.text = arrayUserDetails.check_out
        self.lbl_Deposit.text = "KD \(deposit)"
        self.lbl_rewardDiscount.text = "KD \(arrayUserDetails.rewarded_amt!)"
        self.lbl_chaletName.text = arrayUserDetails.chalet_name
        self.lbl_chaletid.text = String(arrayUserDetails.chalet_id!)
        self.lbl_TotalInvoice.text = "KD \(arrayUserDetails.rent!)"
        self.lbl_offerDiscount.text = "KD \(offerDiscount)"
        self.lbl_RemainingAmt.text = "KD \(remainingAmount)"
        if arrayUserDetails.cover_photo != ""{
            chalet_image.sd_setImage(with: URL(string: arrayUserDetails.cover_photo!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
        }else{
            chalet_image.image = kPlaceHolderImage
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
        print("user_id = \(CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : "")")
        print("chalet_id = \(arrayUserDetails.chalet_id!)")
        print("selected_package = \(selectedpackage)")
        print("check_in = \(arrayUserDetails.check_in! )")
        print("check_out = \(arrayUserDetails.check_out! )")
        print("deposit = \(deposit)")
        print("rent = \(arrayUserDetails.rent! )")
        print("total_paid = \(totalPaid)")
        print("reward_discount = \(String(arrayUserDetails.rewarded_amt!))")
        let userid = CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : ""
        let chaletid = arrayUserDetails.chalet_id
        let checkin = arrayUserDetails.check_in!
        let checkout = arrayUserDetails.check_out!
        let rent = arrayUserDetails.rent!
        let rewardDiscount = String(arrayUserDetails.rewarded_amt!)
        var offerdis = ""
        if isFromOffer == false{
            offerdis = "0"
        }else{
            offerdis = String(dictOfferUserDetails.discount_amt!)
        }
        print("offer_discount = \(offerdis)")
        var reservID = ""

        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/reservation-request", dictionary: ["userid":userid,"chaletid":chaletid!, "selected_package":selectedpackage,"check_in":checkin,"check_out":checkout,"deposit":"\(deposit)","rent":rent,"total_paid":totalPaid,"reward_discount":rewardDiscount,"offer_discount":offerdis], withHud: true) { (success, response, error) in
            print("Response = \(response)")
            if success {
                if ((response as! NSDictionary) ["status"] as! Bool) == true {
                    let responseBase = ReservationRequestResponseModel(dictionary: response as! NSDictionary)
                    self.arryReservedChaletDetails = (responseBase?.chalet_details)!
                    reservID = response!["reservation_id"] as! String
                    let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ReservationApprovalVC") as! ReservationApprovalVC
                    nextVC.reservation_id = reservID
                    nextVC.reservedChaletData = self.arryReservedChaletDetails
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
