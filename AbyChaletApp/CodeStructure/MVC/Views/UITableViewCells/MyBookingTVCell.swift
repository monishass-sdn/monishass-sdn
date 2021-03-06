//
//  MyBookingTVCell.swift
//  AbyChaletApp
//
//  Created by Visakh Srishti on 24/05/21.
//

import UIKit
import MapKit
import SDWebImage
import KDCircularProgress
import HGCircularSlider


class MyBookingTVCell: UITableViewCell {
    @IBOutlet weak var viewBg: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBg.addCornerForView(cornerRadius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    

}
class NoBookingTVCell: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var labelText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBg.addCornerForView(cornerRadius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
class BookingRewardsTVCell: UITableViewCell {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var viewBottom: UIView!
    @IBOutlet weak var lblEarn: UILabel!
    @IBOutlet weak var lblSpent: UILabel!
    @IBOutlet weak var lblTotalRewards: UILabel!
    @IBOutlet weak var lblTotalRewardsMessage: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var lblEarnRewards: UILabel!
    @IBOutlet weak var btnQuestionmark: UIButton!
    @IBOutlet weak var lblKD : UILabel!
    var progress: KDCircularProgress!
   // var progress: CircularSlider!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewBg.addCornerForView(cornerRadius: 15)
        
        let gradientImage = UIImage.gradientImageWithBounds(bounds: lblEarnRewards.bounds, colors: [#colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.2705882353, blue: 0, alpha: 1)])
       // lblEarnRewards.textColor = UIColor.init(patternImage: gradientImage)

        if kCurrentLanguageCode == "ar"{
            lblEarn.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblSpent.font = UIFont(name: kFontAlmaraiRegular, size: 15)
            lblTotalRewardsMessage.font = UIFont(name: kFontAlmaraiRegular, size: 15)
        }else{
            lblEarn.font = UIFont(name: "Roboto-Medium", size: 15)
            lblSpent.font = UIFont(name: "Roboto-Medium", size: 15)
            lblTotalRewardsMessage.font = UIFont(name: "Roboto-Medium", size: 15)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //self.viewBottom.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10.0)
        
    }
    
    func setValuesToFields(dictReward:Reward_details) {
        
        let attrsWhatKindOfJob1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 16)!, NSAttributedString.Key.foregroundColor : UIColor("#1E4355")] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 17)!, NSAttributedString.Key.foregroundColor : UIColor("#379F00")] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob3 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 16)!, NSAttributedString.Key.foregroundColor : UIColor("#379BF2")] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob4 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13)!, NSAttributedString.Key.foregroundColor : UIColor("#B10622")] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob5 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 14)!, NSAttributedString.Key.foregroundColor : UIColor("#B10622")] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob6 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 16)!, NSAttributedString.Key.foregroundColor : dictReward.rewarded_amt != "" ?   UIColor("#326277") : UIColor("#A8A8A8")] as [NSAttributedString.Key : Any]
        
        
        let attributedStringEarn1 = NSMutableAttributedString(string:"Earn ".localized(), attributes:attrsWhatKindOfJob1)
        let attributedStringEarn2 = NSMutableAttributedString(string:"\(dictReward.reward_earn ?? "") ", attributes:attrsWhatKindOfJob2)
        let attributedStringEarn3 = NSMutableAttributedString(string:"KD ", attributes:attrsWhatKindOfJob1)
        attributedStringEarn1.append(attributedStringEarn2)
        attributedStringEarn1.append(attributedStringEarn3)
        self.lblEarn.attributedText = attributedStringEarn1
        
        let attributedStringSpent1 = NSMutableAttributedString(string:"On every ".localized(), attributes:attrsWhatKindOfJob1)
        let attributedStringSpent2 = NSMutableAttributedString(string:"\(dictReward.every_spend ?? "") ", attributes:attrsWhatKindOfJob3)
        let attributedStringSpent3 = NSMutableAttributedString(string:"KD", attributes:attrsWhatKindOfJob1)
        let attributedStringSpent4 = NSMutableAttributedString(string:"spent ".localized(), attributes:attrsWhatKindOfJob1)
        attributedStringSpent1.append(attributedStringSpent2)
        attributedStringSpent1.append(attributedStringSpent3)
        attributedStringSpent1.append(attributedStringSpent4)
        lblSpent.attributedText = attributedStringSpent1

        let attributedStringRewards1 = NSMutableAttributedString(string:"Must be used Total ".localized(), attributes:attrsWhatKindOfJob4)
        let attributedStringRewards2 = NSMutableAttributedString(string:"Rewards before ".localized(), attributes:attrsWhatKindOfJob5)
        let attributedStringRewards3 = NSMutableAttributedString(string:"the end of the year".localized(), attributes:attrsWhatKindOfJob4)
        attributedStringRewards1.append(attributedStringRewards2)
        attributedStringRewards1.append(attributedStringRewards3)
        lblTotalRewardsMessage.attributedText = attributedStringRewards1
        
        let attributedStringTotalRewards = NSMutableAttributedString(string:"\("Total Rewards :".localized()) \(dictReward.rewarded_amt ?? "0") KD", attributes:attrsWhatKindOfJob6)
        lblTotalRewards.attributedText = attributedStringTotalRewards
    }
    
    //MARK:- Setup ProgressBar
    func setupProgressBar(dictReward:Reward_details) {
        print("Total Rewards = \(Double(dictReward.total!))")
        
        let progressNew = CircularSlider(frame: CGRect(x: -6.1, y: -5.4, width: 92.5, height: 92.5))
        progressNew.backgroundColor = UIColor.white
        progressNew.lineWidth = 12
        progressNew.thumbLineWidth = 0.7
        progressNew.thumbRadius = 4.5
        progressNew.diskColor = UIColor.white
        progressNew.trackColor = UIColor.white
        progressNew.cornerRadius = 42.5
        progressNew.borderWidth = 1
        progressNew.borderColor = #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8588235294, alpha: 1)
        progressNew.endThumbTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        progressNew.endThumbStrokeColor = UIColor.white
        progressNew.isUserInteractionEnabled = false
        self.progressView.addSubview(progressNew)
        self.progressView.backgroundColor = UIColor.clear
        self.progressView.borderColor = #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8588235294, alpha: 1)
        self.progressView.borderWidth = 1.5
        progressNew.numberOfRounds = 1
        
        if dictReward.total != 0 {
            
            let totolD = Double(dictReward.total!)
            
            let progressValue = totolD / 2000
            print("Progress Value = \(progressValue)")
         //   self.lblEarnRewards.text = "\(totolD)        KD"
            
            if progressValue == 0.0{
                progressNew.endPointValue = CGFloat(progressValue)
                progressNew.trackFillColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
                self.lblEarnRewards.textColor = #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
                progressNew.endThumbTintColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
                self.lblKD.textColor = #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
            }else if progressValue >= 0.01 && progressValue <= 0.25{
                progressNew.endPointValue = CGFloat(progressValue)
                progressNew.trackFillColor = #colorLiteral(red: 0.4352941176, green: 0.8549019608, blue: 0.2666666667, alpha: 1)
                self.lblEarnRewards.textColor = #colorLiteral(red: 0.4352941176, green: 0.8549019608, blue: 0.2666666667, alpha: 1)
                progressNew.endThumbTintColor = #colorLiteral(red: 0.4352941176, green: 0.8549019608, blue: 0.2666666667, alpha: 1)
                self.lblKD.textColor = #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)
            }else if progressValue >= 0.26 && progressValue <= 0.50{
                progressNew.endPointValue = CGFloat(progressValue)
                progressNew.trackFillColor = #colorLiteral(red: 1, green: 0.8352941176, blue: 0, alpha: 1)
                self.lblEarnRewards.textColor = #colorLiteral(red: 1, green: 0.8352941176, blue: 0, alpha: 1)
                progressNew.endThumbTintColor = #colorLiteral(red: 1, green: 0.8352941176, blue: 0, alpha: 1)
                self.lblKD.textColor = #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)
            }else if progressValue >= 0.51 && progressValue <= 0.75{
                progressNew.endPointValue = CGFloat(progressValue)
                progressNew.trackFillColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0, alpha: 1)
                self.lblEarnRewards.textColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0, alpha: 1)
                progressNew.endThumbTintColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0, alpha: 1)
                self.lblKD.textColor = #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)
            }else{
                progressNew.endPointValue = CGFloat(progressValue)
                progressNew.trackFillColor = #colorLiteral(red: 0.6941176471, green: 0.02352941176, blue: 0.1333333333, alpha: 1)
                self.lblEarnRewards.textColor = #colorLiteral(red: 0.6941176471, green: 0.02352941176, blue: 0.1333333333, alpha: 1)
                progressNew.endThumbTintColor = #colorLiteral(red: 0.6941176471, green: 0.02352941176, blue: 0.1333333333, alpha: 1)
                self.lblKD.textColor = #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)
            }

            
            if totolD > 2000 || totolD < 2000{
                let everySpend = Double(dictReward.every_spend!)
                let total = totolD / everySpend!
                let new = total.truncatingRemainder(dividingBy: 1.0)
                let rounded = Double(round(1000*new)/1000)
                let inPercentage = rounded * 100
                if inPercentage > 0 {
                    let angle = 3.6*inPercentage
                    let earnRewards = rounded * everySpend!
                    self.lblEarnRewards.text = "\(earnRewards.clean)"
                   // progress.angle = angle
                    if angle >= 360 {
                        //self.updateRewardDetails(rewardAmount: "\(dictReward.rewarded_amt!)", reservationAmount: "\(dictReward.total!)")
                    }
                }else{
                  //  progress.angle = 360
                    self.lblEarnRewards.text = "\(2000)"
                    //self.updateRewardDetails(rewardAmount: "\(dictReward.rewarded_amt!)", reservationAmount: "\(dictReward.total!)")
                }
            }else if totolD == 2000{
              //  progress.angle = 360
                self.lblEarnRewards.text = "\(2000)"
                //self.updateRewardDetails(rewardAmount: "\(dictReward.rewarded_amt!)", reservationAmount: "\(dictReward.total!)")
                
            }else {
               // progress.angle = 0
                self.lblEarnRewards.text = "\(0)"
            }
           
            
        }else{
            progressNew.endPointValue = 0.000
            progressNew.trackFillColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
            self.lblEarnRewards.textColor = #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
            progressNew.endThumbTintColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
            progressNew.endThumbStrokeColor = #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8588235294, alpha: 1)
            progressNew.thumbRadius = 5
            progressNew.thumbLineWidth = 1
            self.lblKD.textColor = #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1)
            self.lblEarnRewards.text = "\(0)"
        }
        
    }
    
    //MARK:- updateRewardDetails
    func updateRewardDetails(rewardAmount:String,reservationAmount:String) {
       /* ServiceManager.sharedInstance.postMethodAlamofire("api/reward_count", dictionary: ["userid":CAUser.currentUser.id!,"reward_amount":rewardAmount,"reservation_amt":reservationAmount], withHud: true) { (success, response, error) in
            if success {
                
            }
        }*/
    }


}

class InActiveBookingTVCell: UITableViewCell {
    
    
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblSlNo: UILabel!
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckInTime: UILabel!
    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var lblCheckOut: UILabel!
    @IBOutlet weak var imgChaletImage: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblBookingId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblCheckIn.text = "Check-in".localized()
        lblCheckOut.text = "Check-Out".localized()
        
        if kCurrentLanguageCode == "ar"{
            lblCheckIn.font = UIFont(name: kFontAlmaraiRegular, size: 16)
            lblCheckOut.font = UIFont(name: kFontAlmaraiRegular, size: 16)
            lblStatus.font = UIFont(name: kFontAlmaraiRegular, size: 13)
            lblSlNo.font = UIFont(name: kFontAlmaraiRegular, size: 15)

        }else{
            lblCheckIn.font = UIFont(name: "Roboto-Medium", size: 16)
            lblCheckOut.font = UIFont(name: "Roboto-Medium", size: 16)
            lblStatus.font = UIFont(name: "Roboto-Medium", size: 13)
            lblSlNo.font = UIFont(name: "Roboto-Medium", size: 13)

        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //self.viewBottom.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10.0)
        
    }
    func setValuesToFields(dict:MyBooking_details) {
        let arrayBookingDetails = dict.myBookingChalet_details?.first
        self.lblSlNo.text = "\("No.".localized())\(arrayBookingDetails?.chalet_id! ?? 0)"
        self.lblChaletName.text = arrayBookingDetails?.chalet_name!
        self.imgChaletImage.sd_setImage(with: URL(string: (arrayBookingDetails?.cover_photo!)!), placeholderImage: kPlaceHolderImage, options: .highPriority, completed: nil)
        self.lblRent.text = dict.rent!
        self.lblCheckOutDate.text = convertDateFormat(dateStr: dict.check_out!)
        self.lblCheckOutTime.text = dict.admincheck_out!
        self.lblCheckInDate.text = convertDateFormat(dateStr: dict.check_in!)
        self.lblCheckInTime.text = dict.admincheck_in!
        self.lblBookingId.text = dict.reservation_id!
        self.lblStatus.text = "Not Active".localized()
    }
}
class NotAvailableBookingTVCell: UITableViewCell {
    
    
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblSlNo: UILabel!
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckInTime: UILabel!
    
    @IBOutlet weak var imgChaletImage: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblBookingId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //self.viewBottom.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10.0)
        
    }
    func setValuesToFields(dict:MyBooking_details) {
        
        let arrayBookingDetails = dict.myBookingChalet_details?.first
        self.lblSlNo.text = "\("No.".localized())\(arrayBookingDetails?.chalet_id! ?? 0)"
        self.lblChaletName.text = arrayBookingDetails?.chalet_name!
        self.imgChaletImage.sd_setImage(with: URL(string: (arrayBookingDetails?.cover_photo!)!), placeholderImage: kPlaceHolderImage, options: .highPriority, completed: nil)
        self.lblRent.text = dict.rent!
        self.lblCheckOutDate.text = convertDateFormat(dateStr: dict.check_out!)
        self.lblCheckOutTime.text = dict.admincheck_out!
        self.lblCheckInDate.text = convertDateFormat(dateStr: dict.check_in!)
        self.lblCheckInTime.text = dict.admincheck_in!
        self.lblBookingId.text = dict.reservation_id!
        self.lblStatus.text = "Not Available".localized()
    }
}
class ActiveBookingTVCell: UITableViewCell, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnCopy: UIButton!
    @IBOutlet weak var btnClickMap : UIButton!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblSlNo: UILabel!
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var lblCheckOut: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckInTime: UILabel!
    @IBOutlet weak var imgChaletImage: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblBookingId: UILabel!
    @IBOutlet weak var btnCallUs: UIButton!
    let annotation = MKPointAnnotation()
    override func awakeFromNib() {
        super.awakeFromNib()
        btnCallUs.setTitle("Call us".localized(), for: .normal)
        lblCheckIn.text = "Check-in".localized()
        lblCheckOut.text = "Check-Out".localized()
        lblLocation.text = "Location".localized()
        btnCopy.setTitle("Copy".localized(), for: .normal)
      //  btnCopy.setTitle("Copied".localized(), for: .normal)
        btnCallUs.setTitle("Call us".localized(), for: .normal)

        
        if kCurrentLanguageCode == "ar"{
            lblCheckIn.font = UIFont(name: kFontAlmaraiRegular, size: 16)
            lblCheckOut.font = UIFont(name: kFontAlmaraiRegular, size: 16)
            lblLocation.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblStatus.font = UIFont(name: kFontAlmaraiRegular, size: 13)
            btnCallUs.titleLabel?.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblSlNo.font = UIFont(name: kFontAlmaraiRegular, size: 15)
        }else{
            lblCheckIn.font = UIFont(name: "Roboto-Medium", size: 16)
            lblCheckOut.font = UIFont(name: "Roboto-Medium", size: 16)
            lblLocation.font = UIFont(name: "Roboto-Medium", size: 17)
            lblStatus.font = UIFont(name: "Roboto-Medium", size: 13)
            btnCallUs.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 17)
            lblSlNo.font = UIFont(name: "Roboto-Medium", size: 15)

        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //self.viewBottom.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10.0)
        
    }
    func setValuesToFields(dict:MyBooking_details) {
        
        let arrayBookingDetails = dict.myBookingChalet_details?.first
        self.lblSlNo.text = "\("No.".localized())\(arrayBookingDetails?.chalet_id! ?? 0)"
        self.lblChaletName.text = arrayBookingDetails?.chalet_name!
        self.imgChaletImage.sd_setImage(with: URL(string: (arrayBookingDetails?.cover_photo!)!), placeholderImage: kPlaceHolderImage, options: .highPriority, completed: nil)
        self.lblRent.text = dict.rent!
        
        self.lblCheckOutDate.text = convertDateFormat(dateStr: dict.check_out!)
        self.lblCheckOutTime.text = dict.admincheck_out!
        self.lblCheckInDate.text = convertDateFormat(dateStr: dict.check_in!)
            //dict.check_in!
        self.lblCheckInTime.text = dict.admincheck_in!
        self.lblBookingId.text = dict.reservation_id!
        self.lblStatus.text = "Active".localized()
        
        let lat = Double(arrayBookingDetails!.longitude!)
        let long = Double(arrayBookingDetails!.latitude!)
        
        if lat != nil && long != nil {
            mapView.delegate = self
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            mapView.setCenter(CLLocationCoordinate2D(latitude: lat!, longitude: long!), animated: true)
            mapView.addAnnotation(annotation)
        }
        
    }
    
    private func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil;
        }else{
            let pinIdent = "Pin";
            var pinView: MKPinAnnotationView;
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdent) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation;
                pinView = dequeuedView;
            }else{
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);

            }
            return pinView;
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:"comgooglemaps://?center=\(String(describing: view.annotation!.coordinate.latitude)),\(String(describing: view.annotation!.coordinate.longitude))&zoom=14&views=traffic&q=\(String(describing: view.annotation!.coordinate.latitude)),\(String(describing: view.annotation!.coordinate.longitude))")!, options: [:], completionHandler: nil)
        } else {
            print("Can't use comgooglemaps://")
        }
    }
    
    func convertDateFormat(dateStr:String) -> String {
        var dateString = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateStr)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateString = dateFormatter.string(from: date!)
        return dateString
    }
    
    
}
class AwaitingBookingTVCell: UITableViewCell {
    
    
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblSlNo: UILabel!
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var lblCheckOut: UILabel!
    @IBOutlet weak var lblRemaining: UILabel!
    @IBOutlet weak var lblCheckInTime: UILabel!
    @IBOutlet weak var imgChaletImage: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblBookingId: UILabel!
    @IBOutlet weak var lblReaminingAmt: UILabel!
    @IBOutlet weak var lblRemainingDateTime: UILabel!
    @IBOutlet weak var lblPleasePayRemainingAmt: UILabel!
    @IBOutlet weak var btnPay: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        //btnPay.titleLabel?.text = "Payment now".localized()
        btnPay.setTitle("Payment now".localized(), for: .normal)
        lblCheckIn.text = "Check-in".localized()
        lblCheckOut.text = "Check-Out".localized()
        lblRemaining.text = "Remaining".localized()
        lblPleasePayRemainingAmt.text = "Please pay the remaining amount before".localized()
        
        if kCurrentLanguageCode == "ar"{
            lblCheckIn.font = UIFont(name: kFontAlmaraiRegular, size: 16)
            lblCheckOut.font = UIFont(name: kFontAlmaraiRegular, size: 16)
            lblRemaining.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblPleasePayRemainingAmt.font = UIFont(name: kFontAlmaraiRegular, size: 17)
            lblStatus.font = UIFont(name: kFontAlmaraiRegular, size: 13)
            lblSlNo.font = UIFont(name: kFontAlmaraiRegular, size: 15)

        }else{
            lblCheckIn.font = UIFont(name: "Roboto-Medium", size: 16)
            lblCheckOut.font = UIFont(name: "Roboto-Medium", size: 16)
            lblRemaining.font = UIFont(name: "Roboto-Medium", size: 17)
            lblPleasePayRemainingAmt.font = UIFont(name: "Roboto-Medium", size: 17)
            lblStatus.font = UIFont(name: "Roboto-Medium", size: 13)
            lblSlNo.font = UIFont(name: "Roboto-Medium", size: 13)

        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //self.viewBottom.roundCorners(corners: [.bottomLeft,.bottomRight], radius: 10.0)
        
    }
    func setValuesToFields(dict:MyBooking_details) {
        
        let arrayBookingDetails = dict.myBookingChalet_details?.first
        self.lblSlNo.text = "\("No.".localized())\(arrayBookingDetails?.chalet_id! ?? 0)"
        self.lblChaletName.text = arrayBookingDetails?.chalet_name!
        self.imgChaletImage.sd_setImage(with: URL(string: (arrayBookingDetails?.cover_photo!)!), placeholderImage: kPlaceHolderImage, options: .highPriority, completed: nil)
        self.lblRent.text = dict.rent!
        self.lblCheckOutDate.text = convertDateFormat(dateStr: dict.check_out!)
        self.lblCheckOutTime.text = dict.admincheck_out!
        self.lblCheckInDate.text = convertDateFormat(dateStr: dict.check_in!)
        self.lblCheckInTime.text = dict.admincheck_in!
        self.lblBookingId.text = dict.reservation_id!
        self.lblStatus.text = "Awaiting Payment".localized()
        let rent = Int(dict.rent!)
        let totalPaid = Int(dict.total_paid!)
        let rewardsUsed = Int(dict.reward_discount!) ?? 0
        let remainingAmt = rent! - totalPaid! - rewardsUsed
        self.lblReaminingAmt.text = "KD \(remainingAmt)"
        //self.lblRemainingDateTime.text = "\(dict.check_in!) (\(dict.admincheck_in!))"
        
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd hh:mm a"
        let checkinDate = dateFormater.date(from: "\(String(describing: dict.check_in!)) \(String(describing: dict.admincheck_in!))")
        //let difference = Calendar.current.dateComponents([.hour], from: Date(), to: checkinDate!)
        let remaingTimeToPay = Int(arrayBookingDetails!.remaining_amt_pay!)
        
        let wedDate = Calendar.current.date( byAdding: .hour,value: -remaingTimeToPay!,to: checkinDate!)
        dateFormater.dateFormat = "dd/MM/yyyy ( hh:mm a )"
        lblRemainingDateTime.text = dateFormater.string(from: wedDate!)

        
        
    }
}

class CancelledBookingTVCell: UITableViewCell {
    
    @IBOutlet weak var lblSlNo: UILabel!
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var lblCheckOut: UILabel!
    @IBOutlet weak var lblCheckInTime: UILabel!
    @IBOutlet weak var imgChaletImage: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblBookingId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblCheckIn.text = "Check-in".localized()
        lblCheckOut.text = "Check-Out".localized()
        lblStatus.text = "Cancelled".localized()
    }
    
    func setValuesToFields(dict:MyBooking_details) {
        let arrayBookingDetails = dict.myBookingChalet_details?.first
        self.lblSlNo.text = "\("No.".localized())\(arrayBookingDetails?.chalet_id! ?? 0)"
        self.lblChaletName.text = arrayBookingDetails?.chalet_name!
        //self.imgChaletImage.sd_setImage(with: URL(string: (arrayBookingDetails?.cover_photo!)!), placeholderImage: kPlaceHolderImage, options: .highPriority, completed: nil)
        self.lblRent.text = dict.rent!
        self.lblCheckOutDate.text = convertDateFormat(dateStr: dict.check_out!)
        self.lblCheckOutTime.text = dict.admincheck_out!
        self.lblCheckInDate.text = convertDateFormat(dateStr: dict.check_in!)
        self.lblCheckInTime.text = dict.admincheck_in!
        self.lblBookingId.text = dict.reservation_id!
        
    }
}
