//
//  InboxListTVCell.swift
//  AbyChaletApp
//
//  Created by Visakh Srishti on 30/05/21.
//

import UIKit
import SDWebImage

class InboxListTVCell: UITableViewCell {

    @IBOutlet var heightConstrainARView: NSLayoutConstraint!
    @IBOutlet var heightConstrainBottomView: NSLayoutConstraint!
    @IBOutlet weak var viewAR: UIView!
    @IBOutlet weak var viewBottom: UIView!
    
    @IBOutlet weak var lblSlNo: UILabel!
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckInTime: UILabel!
    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var lblCheckOut: UILabel!
    @IBOutlet weak var lblBookingDetails: UILabel!
    @IBOutlet weak var lblCommision: UILabel!
    @IBOutlet weak var lblTotalPaid: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgChaletImage: UIImageView!
    @IBOutlet weak var lblRentTitle: UILabel!
    
    
    @IBOutlet weak var lblARSlNo: UILabel!
    @IBOutlet weak var lblARChaletName: UILabel!
    @IBOutlet weak var lblARRent: UILabel!
    @IBOutlet weak var lblARCheckOutDate: UILabel!
    @IBOutlet weak var lblARCheckInDate: UILabel!
    @IBOutlet weak var lblARCheckOutTime: UILabel!
    @IBOutlet weak var lblARCheckInTime: UILabel!
    @IBOutlet weak var lblARId: UILabel!
    @IBOutlet weak var lblARRentalPrice: UILabel!
    @IBOutlet weak var lblARCommission: UILabel!
    @IBOutlet weak var lblARTotalPaid: UILabel!
    @IBOutlet weak var imgARChaletImage: UIImageView!
    @IBOutlet weak var btnARAccept: UIButton!
    @IBOutlet weak var btnARReject: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblRentTitle.text = "Rental Price".localized()
        lblCheckIn.text = "Check-in".localized()
        lblCheckOut.text = "Check-Out".localized()
        lblBookingDetails.text = "Booking Details".localized()
        lblCommision.text = "Commision".localized()  // Need to give Arabic string
        lblTotalPaid.text = "Total paid".localized()
        btnARAccept.setTitle("Accept".localized(), for: .normal) // Need to give Arabic string
        btnARReject.setTitle("Reject".localized(), for: .normal) // Need to give Arabic string
        
        if kCurrentLanguageCode == "ar"{
            btnARAccept.titleLabel?.font = UIFont(name: kFontAlmaraiRegular, size: 18)
            btnARReject.titleLabel?.font = UIFont(name: kFontAlmaraiRegular, size: 18)
            lblBookingDetails.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblCheckIn.font = UIFont(name: kFontAlmaraiRegular, size: 16)
            lblCheckOut.font = UIFont(name: kFontAlmaraiRegular, size: 16)
            lblTotalPaid.font = UIFont(name: kFontAlmaraiRegular, size: 17)
        }else{
            btnARAccept.titleLabel?.font = UIFont(name: "Roboto_Medium", size: 18)
            btnARReject.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 18)
            lblBookingDetails.font = UIFont(name: "Roboto-Regular", size: 17)
            lblCheckIn.font = UIFont(name: "Roboto-Regular", size: 16)
            lblCheckOut.font = UIFont(name: "Roboto-Regular", size: 16)
            lblTotalPaid.font = UIFont(name: "Roboto-Regular", size: 17)

        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setValuesToFields(dict:Reservation_list,isClickedOpen:Bool,index:Int,selectedIdx:Int)  {
        
        self.lblId.text = "\(dict.ownerChalet_details?.first?.chalet_id! ?? 0)"
        self.lblChaletName.text = dict.ownerChalet_details?.first?.chalet_name!
        self.lblRent.text = dict.total_paid!
        self.lblCheckOutDate.text = dict.check_out!.appFormattedDate
        self.lblCheckOutTime.text = dict.checkout_time!
        self.lblCheckInDate.text = dict.check_in!.appFormattedDate
        self.lblCheckInTime.text = dict.checkin_time!
        self.lblId.text = dict.reservation_id!
        self.lblStatus.text = dict.booking_status!
        if dict.ownerChalet_details!.count > 0{
        self.imgChaletImage.sd_setImage(with: URL(string: (dict.ownerChalet_details?.first?.cover_photo!)!), placeholderImage: kPlaceHolderImage, options: .highPriority, completed: nil)
        }else{
            self.imgChaletImage.image = kPlaceHolderImage
        }
        if dict.booking_status == "Reject"{
            self.lblStatus.backgroundColor = UIColor("#FC2447")
        }else if dict.booking_status == "Processing"{
            self.lblStatus.backgroundColor = UIColor("#FF9100")
        }else{
            self.lblStatus.backgroundColor = UIColor("#6FDA44")
        }
        
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
        self.btnARAccept.tag = index
        self.btnARReject.tag = index
        
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
        
        
        
        if isClickedOpen == false {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.heightConstrainARView.constant = 0.0
                self.heightConstrainBottomView.constant = 155.0
                self.viewAR.isHidden = true
                self.viewBottom.isHidden = false
                self.layoutIfNeeded()
            })
        }else{
            if index == selectedIdx {
                
                
                UIView.animate(withDuration: 0.2, animations: { () -> Void in
                    self.heightConstrainARView.constant = 355.0
                    self.heightConstrainBottomView.constant = 0.0
                    self.viewAR.isHidden = false
                    self.viewBottom.isHidden = true
                    self.layoutIfNeeded()
                })
                
                
            }else{
                self.heightConstrainARView.constant = 0.0
                self.heightConstrainBottomView.constant = 155.0
                self.viewAR.isHidden = true
                self.viewBottom.isHidden = false
            }
        }
        
    }

}
class InboxAcceptRejectTVCell: UITableViewCell {

    @IBOutlet weak var lblSlNo: UILabel!
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckInTime: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblRentalPrice: UILabel!
    @IBOutlet weak var lblCommission: UILabel!
    @IBOutlet weak var lblTotalPaid: UILabel!
    @IBOutlet weak var imgChaletImage: UIImageView!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnReject: UIButton!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setValuesToFields()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    func setValuesToFields() {
        
        let attrsWhatKindOfJob1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Medium", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob5 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Medium", size: 16)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedRentalPrce1 = NSMutableAttributedString(string:"KD ", attributes:attrsWhatKindOfJob1)
        let attributedRentalPrce2 = NSMutableAttributedString(string:"1000", attributes:attrsWhatKindOfJob2)
        attributedRentalPrce1.append(attributedRentalPrce2)
        self.lblRentalPrice.attributedText = attributedRentalPrce1
        
        let attributedCommission1 = NSMutableAttributedString(string:"KD - ", attributes:attrsWhatKindOfJob1)
        let attributedCommission2 = NSMutableAttributedString(string:"100 ", attributes:attrsWhatKindOfJob5)
        let attributedCommission3 = NSMutableAttributedString(string:"(10%)", attributes:attrsWhatKindOfJob1)
        attributedCommission1.append(attributedCommission2)
        attributedCommission1.append(attributedCommission3)
        self.lblCommission.attributedText = attributedCommission1
        
    }
}
class NoNotificationTVCell: UITableViewCell {
    @IBOutlet weak var lblNoNotificationMessage: UILabel!
}
class CancelReservationTVCell: UITableViewCell {
    
    @IBOutlet weak var lblSlNo: UILabel!
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckInTime: UILabel!
    @IBOutlet weak var imgChaletImage: UIImageView!
    @IBOutlet weak var lblBookingId: UILabel!
    @IBOutlet weak var lblRemainingAmt: UILabel!
    @IBOutlet weak var lblCanceledDate: UILabel!
    @IBOutlet weak var lblCanceledTime: UILabel!
    @IBOutlet weak var lblCanceledStatus: UILabel!
    @IBOutlet weak var lblWearesorry: UILabel!
    @IBOutlet weak var lblCancelled: UILabel!
    @IBOutlet weak var lblReservationCancelled: UILabel!
    @IBOutlet weak var lblRemaining: UILabel!
    
    func setValuesToFields(dict:Message_Notifcation) {
        
        if dict.reservation_details!.count > 0{

            
            
            let detailDict = dict.reservation_details?.first!
            
            

            //self.lblCanceledTime.text = dict.duration!
            lblCanceledStatus.text = "Reservation Cancelled".localized()
            lblRemaining.text = "Remaining".localized()
            lblReservationCancelled.text = "Reservation has been cancelled".localized()
            lblCancelled.text = "Cancelled".localized()
            lblWearesorry.text = "We are sorry, your reservation has been cancelled due to non-payment of the remaining amount".localized()
            lblSlNo.text = "\(detailDict?.chalet_details?.first?.chalet_id! ?? 0)"
            lblChaletName.text = "\(detailDict?.chalet_details?.first?.chalet_name! ?? "")"
            lblRent.text =  detailDict?.rent!
            lblCheckOutDate.text = detailDict?.check_out!
            lblCheckOutTime.text = detailDict?.checkout_time!
            lblCheckInDate.text = detailDict?.check_in!
            lblCheckInTime.text = detailDict?.checkin_time!
            self.lblCanceledTime.text = dict.duration
            if let imgUrl = detailDict?.chalet_details?.first?.cover_photo {
                self.imgChaletImage.sd_setImage(with: URL(string: imgUrl), placeholderImage: kPlaceHolderImage, options: .highPriority, completed: nil)
            }
            lblRemainingAmt.text = "KD\(detailDict?.remaining_amt! ?? "0")"
            lblCanceledDate.text = detailDict?.canceled_date!
            self.lblBookingId.text = detailDict?.reservation_id!
            
        /*    var now = Date()
            let givenDate = dict.duration
            print("givenDate ====== \(givenDate)")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
            let cancelledDate = dateFormatter.date(from: givenDate!)
            self.lblCanceledTime.text = cancelledDate?.timeAgoDisplay()
 */
        }
    }
    
}
class ChalletTVCell: UITableViewCell {
    @IBOutlet weak var lblSlNo: UILabel!
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblOfferRent: UILabel!
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckInTime: UILabel!
    @IBOutlet weak var imgChaletImage: UIImageView!
    @IBOutlet weak var lblDiscountAmt: UILabel!
    
    
    func setValuesToFields(dict:Message_Notifcation) {
        if dict.reservation_details!.count > 0{
            let detailDict = dict.reservation_details?.first!
            lblSlNo.text = "\(detailDict?.chalet_details?.first?.chalet_id! ?? 0)"
            lblChaletName.text = "\(detailDict?.chalet_details?.first?.chalet_name! ?? "")"
            lblRent.text =  detailDict?.rent!
            lblCheckOutDate.text = detailDict?.check_out!
            lblCheckOutTime.text = detailDict?.checkout_time!
            lblCheckInDate.text = detailDict?.check_in!
            lblCheckInTime.text = detailDict?.checkin_time!
            if let imgUrl = detailDict?.chalet_details?.first?.cover_photo {
                self.imgChaletImage.sd_setImage(with: URL(string: imgUrl), placeholderImage: kPlaceHolderImage, options: .highPriority, completed: nil)
            }
        }
    }
}
class ChalletTextTVCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMesage: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var titleView: UIView!
    
    func setValuesToFields(dict:Message_Notifcation) {
        
    /*    let now = Date()
        let givenDate = dict.duration!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let notificationDate = dateFormatter.date(from: givenDate)
        self.lblTime.text = notificationDate?.timeAgoDisplay()
     */
        self.lblTime.text = dict.duration!
        self.lblTitle.text = dict.notification_title!
        self.lblMesage.text = dict.notification_message!
        if dict.read_status == true{
            titleView.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8588235294, alpha: 1)
            lblTitle.textColor = #colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)
            lblTime.textColor = #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
            lblMesage.textColor = #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
        }else{
            titleView.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.3843137255, blue: 0.4666666667, alpha: 1)
            lblTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lblTime.textColor = #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
            lblMesage.textColor = #colorLiteral(red: 0.4470588235, green: 0.4862745098, blue: 0.5568627451, alpha: 1)
        }
    }
    
}
class CancelPaymentTVCell: UITableViewCell {
    
}

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            return "\(secondsAgo) sec ago"
        }else if secondsAgo < hour{
            return "\(secondsAgo / minute) min ago"
        }else if secondsAgo < day {
            return "\(secondsAgo / hour) hour ago"
        }else if secondsAgo < week{
            return "\(secondsAgo / day) days ago"
        }
        return "\(secondsAgo / week) weeks ago"
    }
}
