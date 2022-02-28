//
//  confirmaddedOfferChaletTVCell.swift
//  AbyChaletApp
//
//  Created by Srishti on 24/02/22.
//

import UIKit

class confirmaddedOfferChaletTVCell: UITableViewCell {
    
    
    @IBOutlet weak var lbl_chaletname : UILabel!
    @IBOutlet weak var lbl_pricetype : UILabel!
    @IBOutlet weak var lbl_rent : UILabel!
    @IBOutlet weak var lbl_offercount : UILabel!
    @IBOutlet weak var lbl_priceAfterDiscount : UILabel!
    @IBOutlet weak var lbl_discountedPrice : UILabel!
    @IBOutlet weak var chalet_Image : UIImageView!
    @IBOutlet weak var viewPriceType : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setValuesToFields(dict:Offered_Chalet_details){
        if dict.price_type == "default_price"{
            self.lbl_pricetype.text = "Default Price"
            self.viewPriceType.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)
        }else{
            self.lbl_pricetype.text = "Seasonal Price"
            self.viewPriceType.backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.6078431373, blue: 0.9490196078, alpha: 1)
        }
        self.lbl_chaletname.text = dict.chalet_name
        self.lbl_offercount.text = "You have (\(String(dict.offerCount!))) Offer"
        if dict.cover_photo != ""{
            chalet_Image.sd_setImage(with: URL(string: dict.cover_photo!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
        }else{
            chalet_Image.image = kPlaceHolderImage
        }
        let rent = dict.rent
        let discountedAmt = String(dict.discountedRent!)
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Arial Bold", size: 28)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9882352941, green: 0.1411764706, blue: 0.2784313725, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Arial", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Arial Bold", size: 30)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2156862745, green: 0.6235294118, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedStringRent = NSMutableAttributedString(string:rent!, attributes:attrs3)
        let attributedRent2 = NSMutableAttributedString(string:" KD", attributes:attrs2)
        attributedStringRent.append(attributedRent2)
        self.lbl_rent.attributedText = attributedStringRent
        
        let attributedStringDiscount = NSMutableAttributedString(string:discountedAmt, attributes:attrs1)
        let attributedDiscountKD = NSMutableAttributedString(string:" KD", attributes:attrs2)
        attributedStringDiscount.append(attributedDiscountKD)
        self.lbl_discountedPrice.attributedText = attributedStringDiscount
    }

}

class showSelectedOfferCVTVCell: UITableViewCell {
    
    @IBOutlet weak var lblcheckin: UILabel!
    @IBOutlet weak var lblcheckout: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var viewProgress: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValuesToFields(dict:Available_Offer_list){
        
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
        let dd = DayInHoursCountDownTimer()
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
