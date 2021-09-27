//
//  OfferListTVCell.swift
//  AbyChaletApp
//
//  Created by Visakh Srishti on 27/05/21.
//

import UIKit
import GradientProgress

class OfferListTVCell: UITableViewCell {

    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var collectionView       : UICollectionView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var lblTime: UILabel!
    var timeString: String?
    var countdownTimer : Timer?
    var totalTime = 60
    var dateString = "March 4, 2018 13:20:10" as String
    override func awakeFromNib() {
        super.awakeFromNib()
        let width = kScreenWidth - 30
        let columnLayout = ColumnFlowLayout.init(cellsPerRow: 1, minimumInteritemSpacing: 0.0, minimumLineSpacing: 0.0, sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), cellHeight: 155, cellWidth: width,scrollDirec: .vertical)
        collectionView?.collectionViewLayout = columnLayout
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int,loaded : Bool) {
        if loaded == false {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
        }
    }
    
    func setValuesToFields(dictAdmin:Admin,dict:OfferChalet_list){
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let offerExpiry = dateFormater.date(from: dict.offer_checkin!)
        let offerCreatedDate = dateFormater.date(from: dict.offer_created_at!)
        let expiry = Calendar.current.date( byAdding: .hour,value: -Int(dictAdmin.offer_expiry!)!,to: offerExpiry!)
        let expiryStr = dateFormater.string(from: expiry!)
       // let time = dateFormater.date(from: "05-28-2021 12:05:22")
        //let offerCreated = dateFormater.string(from: offerCreatedDate!)
        self.strtTimer(time: expiryStr, offerCreated: offerCreatedDate!)
        //progressView.progress = 0.0
        DispatchQueue.main.async {
           // self.progressView.progress = 100.0
         //   self.progressView.gradientColors = [#colorLiteral(red: 0.6941176471, green: 0.02352941176, blue: 0.1333333333, alpha: 1),#colorLiteral(red: 1, green: 0.2705882353, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.7647058824, blue: 0, alpha: 1)]
                //[UIColor.yellow.cgColor, UIColor.red.cgColor]
        }
        
    }
    
   

    func strtTimer(time:String,offerCreated:Date)  {
        let timeee = time
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        let date = dateFormater.date(from: time)!
        //let time = timeFormatter.string(from: date!)
        let dd = DateCountDownTimer()
        initializeTimer(timeee)
        let seconds : Double = Double(Date().seconds(from: offerCreated))
        let totalSeconds : Double = Double(date.seconds(from: offerCreated))
        var progressValue = (seconds / totalSeconds)
       // progressView.setProgress(Float(progressValue), animated: true)
        let calender:Calendar = Calendar.current
        let components: DateComponents = calender.dateComponents([.day, .hour, .minute, .second], from: offerCreated, to: date)
        
        if (components.day! >= 0 && components.day! < 3) {
            self.progressView.backgroundColor = #colorLiteral(red: 0.6941176471, green: 0.02352941176, blue: 0.1333333333, alpha: 1)
        }else if (components.day! > 3 && components.day! < 12){
            self.progressView.backgroundColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0, alpha: 1)
        }else{
            self.progressView.backgroundColor = #colorLiteral(red: 1, green: 0.7647058824, blue: 0, alpha: 1)
        }
        startTimer()
       /* dd.startTimer(pUpdateActionHandler: { [self] (time) in
            
            print(time)
            /*let dateFormatterNew = DateFormatter()
            dateFormatterNew.dateFormat = "hh:mm:ss"
            let calendar = NSCalendar.current
            if dateFormatterNew.date(from: time) != nil {
                let dat = dateFormatterNew.date(from: time)
                let components = calendar.component(.hour, from: dat!)
                
                print("Casdasdasd  \(components)")
                
                if components < 15 {
                    DispatchQueue.main.async {
                        self.progressView.gradientColors = [#colorLiteral(red: 0.6941176471, green: 0.02352941176, blue: 0.1333333333, alpha: 1)]
                    }
                }else{
                    DispatchQueue.main.async {
                        self.progressView.gradientColors = [#colorLiteral(red: 0.6941176471, green: 0.02352941176, blue: 0.1333333333, alpha: 1),#colorLiteral(red: 1, green: 0.2705882353, blue: 0, alpha: 1),#colorLiteral(red: 1, green: 0.7647058824, blue: 0, alpha: 1)]
                    }
                }
                
            }*/
            //progressValue = progressValue + 0.0001
            //progressValue = progressValue + 0.0001
            timeString = String()
            timeString = time
            self.lblTime.text = timeString
            //progressView.progress = Float(progressValue)
            /*
             totalTime = min
             progress 0.01
             
             (202170/1)*100
             20202 / startend
             */
            
        }) {
            DispatchQueue.main.async {
            
                print("Completed")
            
            }
        } */
    }
    
    override func prepareForReuse() {
            endTimer()
            lblTime.text = "loading.."
            countdownTimer = nil
            totalTime = 60
            dateString = "March 4, 2018 13:20:10" as String
    }
    
    public func calculatePercentage(value:Double,percentageVal:Double)->Double{
        let val = value * percentageVal
        return val / 100.0
    }

}
class RewardsChaletListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblSlNo: UILabel!
    @IBOutlet weak var lblChaletName: UILabel!
    @IBOutlet weak var lblRent: UILabel!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblCheckOutTime: UILabel!
    @IBOutlet weak var lblCheckInTime: UILabel!
    @IBOutlet weak var imgChaletImage: UIImageView!
    @IBOutlet weak var lblCheckIn: UILabel!
    @IBOutlet weak var lblCheckOut: UILabel!
    @IBOutlet weak var lblDiscountname: UILabel!
    
    func setValuesToFields(dict : OfferUser_details) {
        
        lblDiscountname.text = "Discount".localized()
        lblCheckIn.text = "Check-in".localized()
        lblCheckOut.text = "Check-Out".localized()
        lblSlNo.text = "\("No.".localized())\(dict.chalet_id ?? 0)"
        lblChaletName.text = dict.chalet_name
        
        lblCheckOutDate.text = convertDateFormatOffer(dateStr: dict.check_out!)
        lblCheckInDate.text = convertDateFormatOffer(dateStr: dict.check_in!)
            //dict.check_in
        lblCheckInTime.text = dict.admincheck_in
        lblCheckOutTime.text = dict.admincheck_out
        if dict.cover_photo != ""{
            imgChaletImage.sd_setImage(with: URL(string: dict.cover_photo!), placeholderImage: kPlaceHolderImage, options: .highPriority, context: nil)
        }else{
            imgChaletImage.image = kPlaceHolderImage
        }
        let rent = dict.original_price!
        let disAmt = dict.discount_amt!
        let amt = rent - disAmt
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(dict.original_price!) KD")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        
        //lblRent.attributedText = attributeString
        lblDiscount.text = "-\(dict.discount_amt ?? 0)"
        let totalaMt : Int = dict.original_price! - dict.discount_amt!
        //lblOffer.text = "\(totalaMt) KD"
        
        let attrsWhatKindOfJob1 = [NSAttributedString.Key.font : UIFont(name: "Arial", size: 30)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob2 = [NSAttributedString.Key.font : UIFont(name: "Arial", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6588235294, green: 0.6588235294, blue: 0.6588235294, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attrsRent1 = [NSAttributedString.Key.font : UIFont(name: "Arial Bold", size: 30)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.2156862745, green: 0.6235294118, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        let attrsRent2 = [NSAttributedString.Key.font : UIFont(name: "Arial", size: 22)!, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.1176470588, green: 0.262745098, blue: 0.3333333333, alpha: 1)] as [NSAttributedString.Key : Any]
        
        let attributedStringWhatKindOfJob1 = NSMutableAttributedString(string:"\(dict.original_price!)", attributes:attrsWhatKindOfJob1)
        let attributedStringWhatKindOfJob2 = NSMutableAttributedString(string:"KD", attributes:attrsWhatKindOfJob2)
        attributedStringWhatKindOfJob1.append(attributedStringWhatKindOfJob2)
        attributedStringWhatKindOfJob1.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedStringWhatKindOfJob1.length))
        self.lblRent.attributedText = attributedStringWhatKindOfJob1
        
         let attributedStringRent = NSMutableAttributedString(string:"\(totalaMt)", attributes:attrsRent1)
        let attributedRent2 = NSMutableAttributedString(string:"KD", attributes:attrsRent2)
        attributedStringRent.append(attributedRent2)
        lblOffer.attributedText = attributedStringRent
    }
    
}

extension OfferListTVCell{
    public func startTimer() {
        DispatchQueue.main.async { [self] in
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTime() {
        DispatchQueue.main.async { [self] in
            lblTime.text = timeFormatted(totalTime)
        }
        if totalTime > 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
  
    }

    func endTimer() {
        
        countdownTimer!.invalidate()
    }
    
    public func initializeTimer(_ date: String) {

        self.dateString = date

        // Setting Today's Date
        let currentDate = Date()

        // Setting TargetDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = NSTimeZone.local
        if let targedDate = dateFormatter.date(from: dateString) {

            let currentD = dateFormatter.string(from: currentDate)
            let cuD = dateFormatter.date(from: currentD)
        // Calculating the difference of dates for timer
            let calendar = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: cuD!, to: targedDate)
        let days = calendar.day!
        let hours = calendar.hour!
        let minutes = calendar.minute!
        let seconds = calendar.second!
        totalTime = hours * 60 * 60 + minutes * 60 + seconds
        totalTime = days * 60 * 60 * 24 + totalTime
    }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hours: Int = (totalSeconds / 60 / 60) % 24
        let days: Int = (totalSeconds / 60 / 60 / 24)
        
        if days > 0 {
            return String(format: "%d \("Day".localized()) - %02d:%02d:%02d", days, hours, minutes, seconds)
        }else if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }else if minutes > 0  {
            return String(format: "%02d:%02d",minutes, seconds)
        }else {
            return String(format: "%02d Second", seconds)
        }
    }
}
