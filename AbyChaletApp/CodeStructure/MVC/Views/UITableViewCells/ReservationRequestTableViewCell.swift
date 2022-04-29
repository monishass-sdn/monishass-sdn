//
//  ReservationRequestTableViewCell.swift
//  AbyChaletApp
//
//  Created by Srishti on 18/04/22.
//

import UIKit

class ReservationRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_chaletNo : UILabel!
    @IBOutlet weak var lbl_ChaletName : UILabel!
    @IBOutlet weak var lbl_checkin : UILabel!
    @IBOutlet weak var lbl_checkout : UILabel!
    @IBOutlet weak var lbl_Rent : UILabel!
    @IBOutlet weak var lbl_PaidStatus: UILabel!
    @IBOutlet weak var lbl_Deposit : UILabel!
    @IBOutlet weak var lbl_OfferDiscount : UILabel!
    @IBOutlet weak var lbl_PaidAmt : UILabel!
    @IBOutlet weak var lbl_Remaining : UILabel!
    @IBOutlet weak var lbl_Commision : UILabel!
    @IBOutlet weak var lbl_TotalAmt : UILabel!
    @IBOutlet weak var image_Chalet: UIImageView!
    @IBOutlet weak var image_PaidStatus : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValuesToFields(dict:Reservation_Request_list){
        self.lbl_ChaletName.text = dict.chalet_details?.first?.chalet_name!
        self.lbl_chaletNo.text = "No.\(dict.chaletid ?? 0)"
        self.lbl_checkin.text = dict.check_in
        self.lbl_checkout.text = dict.check_out
        if dict.chalet_details?.first?.cover_photo != ""{
            image_Chalet.sd_setImage(with: URL(string: (dict.chalet_details?.first?.cover_photo)!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
        }else{
            image_Chalet.image = kPlaceHolderImage
        }
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 20)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 20)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2156862745, green: 0.6235294118, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.568627451, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrs5 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 20)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9882352941, green: 0.1411764706, blue: 0.2784313725, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrs6 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 20)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.968627451, green: 1, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrs7 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 20)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.968627451, green: 1, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrs8 = [NSAttributedString.Key.font : UIFont(name: "Arial Bold", size: 30)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2156862745, green: 0.6235294118, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrs9 = [NSAttributedString.Key.font : UIFont(name: "Arial", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedString1 = NSMutableAttributedString(string:"KD ", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string: dict.deposit ?? "", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        self.lbl_Deposit.attributedText = attributedString1
        
        let attributedString3 = NSMutableAttributedString(string:"KD -", attributes:attrs1)
        let attributedString4 = NSMutableAttributedString(string: dict.offer_discount ?? "", attributes:attrs2)
        
        attributedString3.append(attributedString4)
        self.lbl_OfferDiscount.attributedText = attributedString3
        
        let attributedString5 = NSMutableAttributedString(string:"KD ", attributes:attrs3)
        let attributedString6 = NSMutableAttributedString(string: dict.total_paid ?? "", attributes:attrs3)
        
        attributedString5.append(attributedString6)
        self.lbl_PaidAmt.attributedText = attributedString5
        
        let attributedString7 = NSMutableAttributedString(string:"KD ", attributes:attrs4)
        let attributedString8 = NSMutableAttributedString(string: dict.remaining ?? "", attributes:attrs4)
        
        attributedString7.append(attributedString8)
        self.lbl_Remaining.attributedText = attributedString7
        
        let attributedString9 = NSMutableAttributedString(string:"KD - ", attributes:attrs1)
        let attributedString10 = NSMutableAttributedString(string: dict.owner_commission ?? "", attributes:attrs5)
        let attributedString11 = NSMutableAttributedString(string: " ( \(dict.comission_percentage ?? "0")% )" , attributes:attrs1)

        attributedString9.append(attributedString10)
        attributedString9.append(attributedString11)
        self.lbl_Commision.attributedText = attributedString9
        
        let attributedString12 = NSMutableAttributedString(string:"KD ", attributes:attrs6)
        let attributedString13 = NSMutableAttributedString(string: dict.total_paid ?? "", attributes:attrs7)
        
        attributedString12.append(attributedString13)
        self.lbl_TotalAmt.attributedText = attributedString12
        
        let attributedString14 = NSMutableAttributedString(string:dict.chalet_rent ?? "0", attributes:attrs8)
        let attributedString15 = NSMutableAttributedString(string: " KD", attributes:attrs9)
        
        attributedString14.append(attributedString15)
        self.lbl_Rent.attributedText = attributedString14
        
    }

}


class resreqTimerCell : UITableViewCell{
    @IBOutlet weak var lbl_Timer : UILabel!
    
    var seconds = 0   // change this value according to the time
    var isTimerRunning : Bool = false
    var timer = Timer()

    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }
    
    func setValuesToFields(dict:Reservation_Request_list){
        seconds = dict.request_time ?? 0
        if isTimerRunning == false {
              runTimer()
         }
    }
    @objc func timerClass(){
        seconds -= 1
        self.lbl_Timer.text = String(seconds)
    }
    
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if seconds < 1 {
             timer.invalidate()
             //Send alert to indicate "time's up!"
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationNames.KUpdateTImer_End), object: nil, userInfo: nil)
            
        } else {
             seconds -= 1
           self.lbl_Timer.text = timeString(time: TimeInterval(seconds))
        }
    }
    func timeString(time:TimeInterval) -> String {
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes,seconds)
    }
}

class resreqButtonsCell : UITableViewCell{
    @IBOutlet weak var Btn_Accept:UIButton!
    @IBOutlet weak var Btn_Reject:UIButton!
}
