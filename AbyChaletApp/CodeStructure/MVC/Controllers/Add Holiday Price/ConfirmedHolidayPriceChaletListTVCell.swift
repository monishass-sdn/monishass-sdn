//
//  ConfirmedHolidayPriceChaletListTVCell.swift
//  AbyChaletApp
//
//  Created by Srishti on 08/03/22.
//

import UIKit

class ConfirmedHolidayPriceChaletListTVCell: UITableViewCell {
    
    @IBOutlet weak var lblChalet_name: UILabel!
    @IBOutlet weak var lblPrice_type: UILabel!
    @IBOutlet weak var lblWeekday_Price: UILabel!
    @IBOutlet weak var lblWeekend_Price: UILabel!
    @IBOutlet weak var lblWeekAB_Price: UILabel!
    @IBOutlet weak var holiday_Price: UILabel!
    @IBOutlet weak var lblChalet_image: UIImageView!
    @IBOutlet weak var view_PriceType : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValuesToFields(dict: Inserted_Holiday_chalets){
        self.lblChalet_name.text = dict.chalet_name!
        if dict.price_type == "default_price"{
            self.lblPrice_type.text = "Default Price"
            self.view_PriceType.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)
        }else{
            self.lblPrice_type.text = "Season Price"
            self.view_PriceType.backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.6078431373, blue: 0.9490196078, alpha: 1)

        }
        self.lblWeekday_Price.text = dict.weekdays_rent!
        self.lblWeekend_Price.text = dict.weekend_rent!
        self.lblWeekAB_Price.text = dict.weekAB_rent!
        if dict.cover_photo != ""{
            lblChalet_image.sd_setImage(with: URL(string: dict.cover_photo!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
        }else{
            lblChalet_image.image = kPlaceHolderImage
        }
        let holiPrice = String(dict.holiday_price!)
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Arial Bold", size: 28)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9882352941, green: 0.1411764706, blue: 0.2784313725, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Arial", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedStringDiscount = NSMutableAttributedString(string:holiPrice, attributes:attrs1)
        let attributedDiscountKD = NSMutableAttributedString(string:" KD", attributes:attrs2)
        attributedStringDiscount.append(attributedDiscountKD)
        self.holiday_Price.attributedText = attributedStringDiscount
    }

}
