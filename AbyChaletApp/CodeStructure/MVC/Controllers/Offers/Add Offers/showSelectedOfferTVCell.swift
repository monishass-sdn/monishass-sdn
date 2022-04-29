//
//  showSelectedOfferTVCell.swift
//  AbyChaletApp
//
//  Created by Srishti on 15/02/22.
//

import UIKit

class showSelectedOfferTVCell: UITableViewCell {
    
    @IBOutlet weak var lblcheckin: UILabel!
    @IBOutlet weak var lblcheckout: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var viewProgress: UIView!
    let dd = DayInHoursCountDownTimer()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
    }
    
    func setValuesToFields(dict:Available_Offer_list){
        self.lblTimer.text = "loading..."
        if dd.countdownTimer != nil{
            if dd.countdownTimer.isValid {
                self.dd.endTimer()
            }
        }
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let offerExpiry = dateFormater.date(from: dict.offer_checkin!)
        let offerCreatedDate = dateFormater.date(from: dict.offercreated_at!)
        let expiry = Calendar.current.date( byAdding: .hour,value: -Int(dict.offer_expiry!)!,to: offerExpiry!)
        let expiryStr = dateFormater.string(from: expiry!)
        self.strtTimer(time: expiryStr, offerCreated: offerCreatedDate!)
    }
    
    func setTimer(offercheckin : String, offercreatedat : String,offerexpiry: String){
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let offerExpiry = dateFormater.date(from: offercheckin)
        let offerCreatedDate = dateFormater.date(from: offercreatedat)
        let expiry = Calendar.current.date( byAdding: .hour,value: -Int(offerexpiry)!,to: offerExpiry!)
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
        //let dd = DayInHoursCountDownTimer()
        dd.initializeTimer(timeee)
       
        
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
            
            self.lblTimer.text = time
            
        }) {
            DispatchQueue.main.async {
                print("Completed")
            }
        }
    }


}
