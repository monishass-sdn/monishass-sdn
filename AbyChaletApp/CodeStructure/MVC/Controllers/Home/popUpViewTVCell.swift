//
//  popUpViewTVCell.swift
//  AbyChaletApp
//
//  Created by Srishti Innovative on 21/10/21.
//

import UIKit

class popUpViewTVCell: UITableViewCell {
    
    @IBOutlet weak var lblARSlNo: UILabel!
    @IBOutlet weak var lblARChaletName: UILabel!
    @IBOutlet weak var imgARChaletImage: UIImageView!
    @IBOutlet weak var lblARId: UILabel!
    @IBOutlet weak var lblARRent: UILabel!
    @IBOutlet weak var lblARCheckOutDate: UILabel!
    @IBOutlet weak var lblARCheckInDate: UILabel!
    @IBOutlet weak var lblARCheckOutTime: UILabel!
    @IBOutlet weak var lblARCheckInTime: UILabel!
    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var lblCheckOut: UILabel!
    @IBOutlet weak var lblBookingDetails: UILabel!
    @IBOutlet weak var lblRentTitle: UILabel!
    @IBOutlet weak var lblARRentalPrice: UILabel!
    @IBOutlet weak var lblCommision: UILabel!
    @IBOutlet weak var lblARCommission: UILabel!
    @IBOutlet weak var lblTotalPaid: UILabel!
    @IBOutlet weak var lblARTotalPaid: UILabel!
    @IBOutlet weak var btnARAccept: UIButton!
    @IBOutlet weak var btnARReject: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblRentTitle.text = "Rental Price".localized()
        lblCheckIn.text = "Check-in".localized()
        lblCheckOut.text = "Check-Out".localized()
        lblBookingDetails.text = "Booking Details".localized()
        lblCommision.text = "Commision".localized()
        lblTotalPaid.text = "Total paid".localized()
        btnARAccept.setTitle("Accept".localized(), for: .normal) 
        btnARReject.setTitle("Reject".localized(), for: .normal)
        
        if kCurrentLanguageCode == "ar"{
            btnARAccept.titleLabel?.font = UIFont(name: kFontAlmaraiRegular, size: 18)
            btnARReject.titleLabel?.font = UIFont(name: kFontAlmaraiRegular, size: 18)
            lblBookingDetails.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblCheckIn.font = UIFont(name: kFontAlmaraiRegular, size: 16)
            lblCheckOut.font = UIFont(name: kFontAlmaraiRegular, size: 16)
            lblRentTitle.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblCommision.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblTotalPaid.font = UIFont(name: kFontAlmaraiRegular, size: 17)
        }else{
            btnARAccept.titleLabel?.font = UIFont(name: "Roboto_Medium", size: 18)
            btnARReject.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
            lblBookingDetails.font = UIFont(name: "Roboto-Regular", size: 17)
            lblCheckIn.font = UIFont(name: "Roboto-Regular", size: 16)
            lblCheckOut.font = UIFont(name: "Roboto-Regular", size: 16)
            lblRentTitle.font = UIFont(name: "Roboto-Regular", size: 17)
            lblCommision.font = UIFont(name: "Roboto-Regular", size: 17)
            lblTotalPaid.font = UIFont(name: "Roboto-Regular", size: 17)

        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state  "\("No.".localized())\(
    }
    
    func setValuesToFields(dict:Reservation_list){
       // self.lblARSlNo.text = "\("No.".localized())\(dict.ownerChalet_details?.first?.chalet_id)"
        self.lblARId.text = "\(dict.ownerChalet_details?.first?.chalet_id! ?? 0)"
        self.lblARChaletName.text = dict.ownerChalet_details?.first?.chalet_name!
        self.lblARRent.text = dict.total_paid!
        self.lblARCheckOutDate.text = dict.check_out!.appFormattedDate
        self.lblARCheckOutTime.text = dict.checkout_time!
        self.lblARCheckInDate.text = dict.check_in!.appFormattedDate
        self.lblARCheckInTime.text = dict.checkin_time!
        self.lblARId.text = dict.reservation_id!
        if dict.ownerChalet_details!.count > 0{
        self.imgARChaletImage.sd_setImage(with: URL(string: (dict.ownerChalet_details?.first?.cover_photo!)!), placeholderImage: kPlaceHolderImage, options: .highPriority, completed: nil)
        }else{
            self.imgARChaletImage.image = kPlaceHolderImage
        }
        self.lblARTotalPaid.text = dict.total_paid!
        
        let attrsWhatKindOfJob1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Medium", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob5 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Medium", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedRentalPrce1 = NSMutableAttributedString(string:"KD ", attributes:attrsWhatKindOfJob1)
        let attributedRentalPrce2 = NSMutableAttributedString(string:"1000", attributes:attrsWhatKindOfJob2)
        attributedRentalPrce1.append(attributedRentalPrce2)
        self.lblARRentalPrice.attributedText = attributedRentalPrce1
        
        let attributedCommission1 = NSMutableAttributedString(string:"KD - ", attributes:attrsWhatKindOfJob1)
        let attributedCommission2 = NSMutableAttributedString(string:"100 ", attributes:attrsWhatKindOfJob5)
        let attributedCommission3 = NSMutableAttributedString(string:"(10%)", attributes:attrsWhatKindOfJob1)
        attributedCommission1.append(attributedCommission2)
        attributedCommission1.append(attributedCommission3)
        self.lblARCommission.attributedText = attributedCommission1
    }

}
