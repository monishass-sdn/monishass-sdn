//
//  ReservationApprovalVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 02/03/22.
//

import UIKit

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
    var arrayUserDetails : User_details!
    var reservedChaletData : [Reserved_Chalet_details]?
    var reservation_id = ""
    var timer = Timer()
    var seconds = 36000   // change this value according to the time
    var isTimerRunning : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if isTimerRunning == false {
              runTimer()
         }
        setUpNavigationBar()
        setValuestotheFields()
        print("Reservation Id = \(reservation_id)")
        
        // Do any additional setup after loading the view.
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
        }
    }
    func timeString(time:TimeInterval) -> String {
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes,seconds)
    }


}
