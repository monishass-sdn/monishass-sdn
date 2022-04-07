//
//  AddHolidayToChaletTVCell.swift
//  AbyChaletApp
//
//  Created by Srishti on 07/03/22.
//

import UIKit

class AddHolidayToChaletTVCell: UITableViewCell {
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var heightForHolidayPriceView: NSLayoutConstraint!
    @IBOutlet weak var lblWeekdays_price : UILabel!
    @IBOutlet weak var lblWeekend_price : UILabel!
    @IBOutlet weak var lblWeekA_WeekB_price : UILabel!
    @IBOutlet weak var tf_holidayPrice: UITextField!
    @IBOutlet weak var chalet_image: UIImageView!
    @IBOutlet weak var lblChalet_name: UILabel!
    @IBOutlet weak var lblPrice_type : UILabel!
    @IBOutlet weak var view_PriceType : UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setValuesToFields(dict: HolidayEventChaletList){
        self.lblChalet_name.text = dict.chalet_name!
        self.lblWeekdays_price.text = dict.weekdays_rent!
        self.lblWeekend_price.text = dict.weekend_rent!
        self.lblWeekA_WeekB_price.text = dict.weekAB_rent!
        if dict.cover_photo != ""{
            chalet_image.sd_setImage(with: URL(string: dict.cover_photo!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
        }else{
            chalet_image.image = kPlaceHolderImage
        }
        if dict.price_type == "default_price"{
            self.lblPrice_type.text = "Default Price"
            self.view_PriceType.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)
        }else{
            self.lblPrice_type.text = "Season Price"
            self.view_PriceType.backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.6078431373, blue: 0.9490196078, alpha: 1)
        }
    }

}

class AddHolidayToChaletOfferAlreadyAppliedTVCell: UITableViewCell {
    @IBOutlet weak var chalet_image: UIImageView!
    @IBOutlet weak var lblChalet_name: UILabel!
    @IBOutlet weak var lblMsgString : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValuesToFields(dict: HolidayEventChaletList){
        self.lblChalet_name.text = dict.chalet_name
        if dict.cover_photo != ""{
            chalet_image.sd_setImage(with: URL(string: dict.cover_photo!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
        }else{
            chalet_image.image = kPlaceHolderImage
        }
        
        let attrsWhatKindOfJob1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 12)!, NSAttributedString.Key.foregroundColor : UIColor("#2B5468")] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 12)!, NSAttributedString.Key.foregroundColor : UIColor("#2B5468")] as [NSAttributedString.Key : Any]
        
        let attributedStringEarn1 = NSMutableAttributedString(string:"Because there is an ( ", attributes:attrsWhatKindOfJob1)
        let attributedStringEarn2 = NSMutableAttributedString(string:"offer", attributes:attrsWhatKindOfJob2)
        let attributedStringEarn3 = NSMutableAttributedString(string:" ) on the same date, disable the offer first so that you can add the holiday price", attributes:attrsWhatKindOfJob1)
        
        attributedStringEarn1.append(attributedStringEarn2)
        attributedStringEarn1.append(attributedStringEarn3)
        self.lblMsgString.attributedText = attributedStringEarn1
    }

}
