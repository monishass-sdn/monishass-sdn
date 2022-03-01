//
//  confirmReservationVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 01/03/22.
//

import UIKit

class confirmReservationVC: UIViewController {
    var arrayUserDetails : User_details!
    
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
    var offerDiscount = "0"
    var remainingAmount = "0"
    var totalPaid = "0"

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Selected Chalet Name = \(arrayUserDetails.chalet_name ?? "No Value Fetched")")
        if isTimerRunning == false {
              runTimer()
         }
        
        setValuestotheFields()
        // Do any additional setup after loading the view.
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

}
