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
        }else{
            self.lblPrice_type.text = "Seasonal Price"
        }
    }

}

class AddHolidayToChaletOfferAlreadyAppliedTVCell: UITableViewCell {
    @IBOutlet weak var chalet_image: UIImageView!
    @IBOutlet weak var lblChalet_name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
