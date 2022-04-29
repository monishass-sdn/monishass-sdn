//
//  AvailableOffersTVCell.swift
//  AbyChaletApp
//
//  Created by Srishti on 05/01/22.
//

import UIKit

class AvailableOffersTVCell: UITableViewCell {
    @IBOutlet weak var lblCheck_in: UILabel!
    @IBOutlet weak var lblCheck_out: UILabel!
    @IBOutlet weak var lblTImer: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewProgress: UIView!
    @IBOutlet weak var lblAppliedOfferCount: UILabel!
    let dd = DayInHoursCountDownTimer()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValuesToFields(dict : Available_Offer_list){
        self.lblTImer.text = "loading..."
        if dd.countdownTimer != nil{
            if dd.countdownTimer.isValid {
                self.dd.endTimer()
            }
        }
        self.lblCheck_in.text = dict.check_in
        self.lblCheck_out.text = dict.check_out
        if dict.offered_chalets == "0"{
            self.lblAppliedOfferCount.isHidden = true
        }else{
            self.lblAppliedOfferCount.isHidden = false
            self.lblAppliedOfferCount.text = dict.offered_chalets
        }
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let offerExpiry = dateFormater.date(from: dict.offer_checkin!)
        let offerCreatedDate = dateFormater.date(from: dict.offercreated_at!)
        let expiry = Calendar.current.date( byAdding: .hour,value: -Int(dict.offer_expiry!)!,to: offerExpiry!)
        let expiryStr = dateFormater.string(from: expiry!)
        self.strtTimer(time: expiryStr, offerCreated: offerCreatedDate!)
    }
    
    func strtTimer(time:String,offerCreated:Date)  {
        let timeee = time
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        let date = dateFormater.date(from: time)!
      //  let dd = DayInHoursCountDownTimer()
        dd.initializeTimer(timeee)
       // let seconds : Double = Double(Date().seconds(from: offerCreated))
       // let totalSeconds : Double = Double(date.seconds(from: offerCreated))
       
        
        let calender:Calendar = Calendar.current
        let components: DateComponents = calender.dateComponents([.day, .hour, .minute, .second], from: offerCreated, to: date)
        

        if (components.hour! >= 0 && components.hour! < Int(0.25)) {
            self.viewProgress.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.1411764706, blue: 0.2784313725, alpha: 1)
        }else if (components.hour! > Int(0.25) && components.day! < 1){
            self.viewProgress.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.7333333333, blue: 0.1411764706, alpha: 1)
        }else{
            self.viewProgress.backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.8549019608, blue: 0.2666666667, alpha: 1)
        }
        
        dd.startTimer1(pUpdateActionHandler: { [self] (time) in
            
            self.lblTImer.text = time
            
        }) {
            DispatchQueue.main.async {
                print("Completed")
            }
        }
    }

}
