//
//  SeasonPriceChaletListTVCell.swift
//  AbyChaletApp
//
//  Created by Srishti on 08/03/22.
//

import UIKit

class SeasonPriceChaletListTVCell: UITableViewCell {
    @IBOutlet weak var lblChalet_name:UILabel!
    @IBOutlet weak var lblPrice_type:UILabel!
    @IBOutlet weak var lblWeekdays_Price:UILabel!
    @IBOutlet weak var lblWeekend_Price:UILabel!
    @IBOutlet weak var lblWeekAB_Price:UILabel!
    @IBOutlet weak var tf_Weekdays_Price:UITextField!
    @IBOutlet weak var tf_Weekend_Price:UITextField!
    @IBOutlet weak var tf_WeekAB_Price:UITextField!
    @IBOutlet weak var chalet_image:UIImageView!
    @IBOutlet weak var bottomViewHeightConstrain:NSLayoutConstraint!
    @IBOutlet weak var btnCheckBox:UIButton!
    @IBOutlet weak var view_PriceType : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValuesToFields(dict:SeasonPrice_Chalet_details){
        self.lblChalet_name.text = dict.chalet_name!
        self.lblWeekend_Price.text = dict.weekend_rent!
        self.lblWeekdays_Price.text = dict.weekday_rent!
        self.lblWeekAB_Price.text = dict.week_rent!
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

class SeasonPriceAddedChaletListTVCell: UITableViewCell {
    @IBOutlet weak var lblChalet_name:UILabel!
    @IBOutlet weak var lblPrice_type:UILabel!
    @IBOutlet weak var lblWeekdays_Price:UILabel!
    @IBOutlet weak var lblWeekend_Price:UILabel!
    @IBOutlet weak var lblWeekAB_Price:UILabel!
    @IBOutlet weak var lblWeekdaysSeason_Price:UILabel!
    @IBOutlet weak var lblWeekendSeason_Price:UILabel!
    @IBOutlet weak var lblWeekABSeason_Price:UILabel!
    @IBOutlet weak var chalet_image:UIImageView!
    @IBOutlet weak var view_PriceType : UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValuesToFields(dict:SeasonPriceAdded_Chalet_details){
        self.lblChalet_name.text = dict.chalet_name!
        self.lblWeekend_Price.text = dict.weekend_rent!
        self.lblWeekdays_Price.text = dict.weekday_rent!
        self.lblWeekAB_Price.text = dict.week_rent!
        self.lblWeekdaysSeason_Price.text = dict.weekdays_seasonprice!
        self.lblWeekendSeason_Price.text = dict.weekend_seasonprice!
        self.lblWeekABSeason_Price.text = dict.week_seasonprice!
        if dict.coverphoto != ""{
            chalet_image.sd_setImage(with: URL(string: dict.coverphoto!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
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

class SeasonPriceAppliedChaletListTVCell: UITableViewCell {
    @IBOutlet weak var lblChalet_name:UILabel!
    @IBOutlet weak var lblPrice_type:UILabel!
    @IBOutlet weak var lblWeekdays_Price:UILabel!
    @IBOutlet weak var lblWeekend_Price:UILabel!
    @IBOutlet weak var lblWeekAB_Price:UILabel!
    @IBOutlet weak var tf_Weekdays_Price:UITextField!
    @IBOutlet weak var tf_Weekend_Price:UITextField!
    @IBOutlet weak var tf_WeekAB_Price:UITextField!
    @IBOutlet weak var chalet_image:UIImageView!
   // @IBOutlet weak var bottomViewHeightConstrain:NSLayoutConstraint!
    @IBOutlet weak var btnCheckBox:UIButton!
    @IBOutlet weak var view_PriceType : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValuesToFields(dict:SeasonPrice_Chalet_details){
        self.tf_Weekdays_Price.text = dict.weekdays_seasonprice!
        self.tf_Weekend_Price.text = dict.weekend_seasonprice!
        self.tf_WeekAB_Price.text = dict.week_seasonprice!
        
        self.lblChalet_name.text = dict.chalet_name!
        self.lblWeekend_Price.text = dict.weekend_rent!
        self.lblWeekdays_Price.text = dict.weekday_rent!
        self.lblWeekAB_Price.text = dict.week_rent!
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
