//
//  myChaletTVCell.swift
//  AbyChaletApp
//
//  Created by Srishti on 27/12/21.
//

import UIKit

class myChaletTVCell: UITableViewCell {
    
    @IBOutlet weak var BtnViewDetails: UIButton!
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var downUpArrow: UIButton!
    @IBOutlet weak var BtnStat : UIButton!
    @IBOutlet weak var BtnCompare : UIButton!
    @IBOutlet weak var BtnAllChalets : UIButton!
    @IBOutlet weak var DetailsView : UIView!
    @IBOutlet weak var bttonView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblTotalIncomeKD: UILabel!
    @IBOutlet weak var lblUnpaidAmountKD: UILabel!
    @IBOutlet weak var lblChalet_name: UILabel!
    @IBOutlet weak var lblAgreed_commision : UILabel!
    @IBOutlet weak var lblStart_date : UILabel!
    @IBOutlet weak var lblReservation : UILabel!
    @IBOutlet weak var lblCancellation_reservation : UILabel!
    @IBOutlet weak var lblReject : UILabel!
    @IBOutlet weak var lblOffers : UILabel!
    @IBOutlet weak var lblTotal_income : UILabel!
    @IBOutlet weak var lblSubChalet_count: UILabel!
    @IBOutlet weak var imageCloseddate: UIImageView!
    
    var isExpanded : Bool = false
    var istoggleON : Bool = false
    var totalincome = ""
    var unpaid = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        topView.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        DetailsView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func prepareForReuse() {
 //       isExpanded = false
 //   }
    
    func setValuesToFields(dict : ChaletLists){
        
        let attrsWhatKindOfJob1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 25)!, NSAttributedString.Key.foregroundColor : UIColor("#379F00")] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 20)!, NSAttributedString.Key.foregroundColor : UIColor("#FF9100")]
        let attrsWhatKindOfJob4 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 24)!, NSAttributedString.Key.foregroundColor : UIColor("#1E4355")] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob3 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 19)!, NSAttributedString.Key.foregroundColor : UIColor("#1E4355")] as [NSAttributedString.Key : Any]
        
        let attributedStringEarn1 = NSMutableAttributedString(string:"\(dict.totalIncome!)", attributes:attrsWhatKindOfJob1)
        let attributedStringEarn2 = NSMutableAttributedString(string:"\(dict.totalUnPaid!)", attributes:attrsWhatKindOfJob2)
        let attributedStringEarn3 = NSMutableAttributedString(string:" KD".localized(), attributes:attrsWhatKindOfJob3)
        let attributedStringEarn4 = NSMutableAttributedString(string:" KD".localized(), attributes:attrsWhatKindOfJob4)

        
        attributedStringEarn1.append(attributedStringEarn4)
        self.lblTotalIncomeKD.attributedText = attributedStringEarn1
        
        attributedStringEarn2.append(attributedStringEarn3)
        self.lblUnpaidAmountKD.attributedText = attributedStringEarn2

        self.lblReject.text = dict.rejectedReservation
        self.lblReservation.text = dict.reservation_count
        self.lblStart_date.text = dict.startDate
        self.lblAgreed_commision.text = dict.commission
        self.lblTotal_income.text = dict.totalIncome
        self.lblReservation.text = dict.reservation_count
        self.lblChalet_name.text = dict.chalet_name
        self.lblCancellation_reservation.text = dict.cancellationCount
        self.lblOffers.text = dict.offer_count
        self.lblSubChalet_count.text = dict.countOfSubChalets
        
        if dict.reservation_available == true{
            self.toggleBtn.setImage(UIImage(named: "toggleONReservation"), for: .normal)
        }else{
            self.toggleBtn.setImage(UIImage(named: "toggleOFFReservation"), for: .normal)
        }
        
        if dict.closed_date == true{
            self.imageCloseddate.image = UIImage(named: "selectedDateYes")
        }else{
            self.imageCloseddate.image = UIImage(named: "selectedDateNo")
        }
        
    }

    


}
