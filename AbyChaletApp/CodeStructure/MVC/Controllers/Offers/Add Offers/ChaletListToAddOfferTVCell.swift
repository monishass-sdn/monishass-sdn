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
    @IBOutlet weak var heightForDiscountView: NSLayoutConstraint!
    var isExpanded : Bool = false
    var istoggleON : Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   // func setValuesToFields(dict:Offer_Chalet_details){
        func setValuesToFields(index:Int,dict:Offer_Chalet_details,isClick:Bool,selectedIndex:Int){
        self.btnCheckBox.tag = index
        
        self.lblChaletName.text = dict.chalet_name
        if dict.price_type == "default_price"{
            self.lblPriceType.text = "Default Prices"
            self.viewPriceType.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)
        }else{
            self.lblPriceType.text = "Season Prices"
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


class ChaletListToAddedOfferTVCell: UITableViewCell {
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblPriceType: UILabel!
    @IBOutlet weak var lblOfferCount: UILabel!
    @IBOutlet weak var imageChalet: UIImageView!
    @IBOutlet weak var tfDiscountAdded: UITextField!
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var viewPriceType: UIView!
    @IBOutlet weak var heightForDiscountView: NSLayoutConstraint!
    var isExpanded : Bool = false
    var istoggleON : Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   // func setValuesToFields(dict:Offer_Chalet_details){
        func setValuesToFields(index:Int,dict:Offer_Chalet_details,isClick:Bool,selectedIndex:Int){
        self.btnCheckBox.tag = index
            self.tfDiscountAdded.text = "\(dict.discount!)"
        self.lblChaletName.text = dict.chalet_name
        if dict.price_type == "default_price"{
            self.lblPriceType.text = "Default Prices"
            self.viewPriceType.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)
        }else{
            self.lblPriceType.text = "Season Prices"
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
            self.lblPriceType.text = "Default Prices"
        }else{
            self.lblPriceType.text = "Season Prices"
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

        if dict.cover_photo != ""{
            imageChalet.sd_setImage(with: URL(string: dict.cover_photo!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
        }else{
            imageChalet.image = kPlaceHolderImage
        }
        let rent = dict.rent
        
        let attrsRent1 = [NSAttributedString.Key.font : UIFont(name: "Arial Bold", size: 30)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsRent2 = [NSAttributedString.Key.font : UIFont(name: "Arial", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsRent3 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 12)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.168627451, green: 0.3294117647, blue: 0.4078431373, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsRent4 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 12)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedStringRent = NSMutableAttributedString(string:rent!, attributes:attrsRent1)
        let attributedRent2 = NSMutableAttributedString(string:"KD", attributes:attrsRent2)
        attributedStringRent.append(attributedRent2)
        //lblRent.attributedText = attributedStringRent
        
        
        let attributedStringMsg = NSMutableAttributedString(string:"Because there is an ", attributes:attrsRent3)
        let attributedStringMsg2 = NSMutableAttributedString(string:"( Holiday )", attributes:attrsRent4)
        let attributedStringMsg3 = NSMutableAttributedString(string:" on the same date, disable the holiday first so that you can add the Offer ( Discount )", attributes:attrsRent3)
        
        attributedStringMsg.append(attributedStringMsg2)
        attributedStringMsg.append(attributedStringMsg3)
        self.lblMessageOnCard.attributedText = attributedStringMsg

    }

}
