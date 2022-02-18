//
//  ChaletListToAddOfferTVCell.swift
//  AbyChaletApp
//
//  Created by Srishti on 15/02/22.
//

import UIKit

class ChaletListToAddOfferTVCell: UITableViewCell {
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblPriceType: UILabel!
    @IBOutlet weak var lblOfferCount: UILabel!
    @IBOutlet weak var imageChalet: UIImageView!
    @IBOutlet weak var tfDiscountAdded: UITextField!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var viewPriceType: UIView!
    var istoggleON : Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValuesToFields(dict:Offer_Chalet_details){

        
        self.lblChaletName.text = dict.chalet_name
        if dict.price_type == "default_price"{
            self.lblPriceType.text = "Default Price"
            self.viewPriceType.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)
        }else{
            self.lblPriceType.text = "Seasonal Price"
            self.viewPriceType.backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.6078431373, blue: 0.9490196078, alpha: 1)
        }
        self.lblOfferCount.text = "You have (\(dict.offerCount ?? 0)) Offer"
        if dict.cover_photo != ""{
            imageChalet.sd_setImage(with: URL(string: dict.cover_photo!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
        }else{
            imageChalet.image = kPlaceHolderImage
        }
        let rent = dict.rent
        
        let attrsRent1 = [NSAttributedString.Key.font : UIFont(name: "Arial Bold", size: 30)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2156862745, green: 0.6235294118, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsRent2 = [NSAttributedString.Key.font : UIFont(name: "Arial", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedStringRent = NSMutableAttributedString(string:rent!, attributes:attrsRent1)
        let attributedRent2 = NSMutableAttributedString(string:"KD", attributes:attrsRent2)
        attributedStringRent.append(attributedRent2)
        lblRent.attributedText = attributedStringRent
    }

}

class ChaletWithZeroOfferTVCell: UITableViewCell {
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblPriceType: UILabel!
    @IBOutlet weak var lblOfferCount: UILabel!
    @IBOutlet weak var imageChalet: UIImageView!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var viewPriceType: UIView!
    var istoggleON : Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValuesToFields(dict:Offer_Chalet_details){

        
        self.lblChaletName.text = dict.chalet_name
        if dict.price_type == "default_price"{
            self.lblPriceType.text = "Default Price"
        }else{
            self.lblPriceType.text = "Seasonal Price"
        }
        self.lblOfferCount.text = "You have (\(dict.offerCount ?? 0)) Offer"
        if dict.cover_photo != ""{
            imageChalet.sd_setImage(with: URL(string: dict.cover_photo!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
        }else{
            imageChalet.image = kPlaceHolderImage
        }
        let rent = dict.rent
        
        let attrsRent1 = [NSAttributedString.Key.font : UIFont(name: "Arial Bold", size: 30)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsRent2 = [NSAttributedString.Key.font : UIFont(name: "Arial", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedStringRent = NSMutableAttributedString(string:rent!, attributes:attrsRent1)
        let attributedRent2 = NSMutableAttributedString(string:"KD", attributes:attrsRent2)
        attributedStringRent.append(attributedRent2)
        lblRent.attributedText = attributedStringRent
    }

}

class ChaletFromHolidayTVCell: UITableViewCell {
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblMessageOnCard: UILabel!
    @IBOutlet weak var lblPriceType: UILabel!
    @IBOutlet weak var imageChalet: UIImageView!
    @IBOutlet weak var viewPriceType: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValuesToFields(dict:Offer_Chalet_details){

        
        self.lblChaletName.text = dict.chalet_name
        if dict.price_type == "default_price"{
            self.lblPriceType.text = "Default Price"
           // self.viewPriceType.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)
        }else{
            self.lblPriceType.text = "Seasonal Price"
           // self.viewPriceType.backgroundColor = #colorLiteral(red: 0.2156862745, green: 0.6078431373, blue: 0.9490196078, alpha: 1)
        }
      //  self.lblOfferCount.text = "You have (\(dict.offerCount ?? 0)) Offer"
        if dict.cover_photo != ""{
            imageChalet.sd_setImage(with: URL(string: dict.cover_photo!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
        }else{
            imageChalet.image = kPlaceHolderImage
        }
        let rent = dict.rent
        
        let attrsRent1 = [NSAttributedString.Key.font : UIFont(name: "Arial Bold", size: 30)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsRent2 = [NSAttributedString.Key.font : UIFont(name: "Arial", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedStringRent = NSMutableAttributedString(string:rent!, attributes:attrsRent1)
        let attributedRent2 = NSMutableAttributedString(string:"KD", attributes:attrsRent2)
        attributedStringRent.append(attributedRent2)
        //lblRent.attributedText = attributedStringRent
    }

}
