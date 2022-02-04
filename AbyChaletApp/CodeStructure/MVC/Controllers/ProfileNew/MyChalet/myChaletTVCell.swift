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
    @IBOutlet weak var DetailsView : UIView!
    @IBOutlet weak var DetailViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var lblTotalIncomeKD: UILabel!
    @IBOutlet weak var lblUnpaidAmountKD: UILabel!
    var isExpanded : Bool = false
    var istoggleON : Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        topView.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        DetailsView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
        
        let attrsWhatKindOfJob1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 25)!, NSAttributedString.Key.foregroundColor : UIColor("#379F00")] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 20)!, NSAttributedString.Key.foregroundColor : UIColor("#FF9100")]
        let attrsWhatKindOfJob4 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 24)!, NSAttributedString.Key.foregroundColor : UIColor("#1E4355")] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob3 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 19)!, NSAttributedString.Key.foregroundColor : UIColor("#1E4355")] as [NSAttributedString.Key : Any]
        
        let attributedStringEarn1 = NSMutableAttributedString(string:"8000".localized(), attributes:attrsWhatKindOfJob1)
        let attributedStringEarn2 = NSMutableAttributedString(string:"0".localized(), attributes:attrsWhatKindOfJob2)
        let attributedStringEarn3 = NSMutableAttributedString(string:" KD".localized(), attributes:attrsWhatKindOfJob3)
        let attributedStringEarn4 = NSMutableAttributedString(string:" KD".localized(), attributes:attrsWhatKindOfJob4)

        
        attributedStringEarn1.append(attributedStringEarn4)
        self.lblTotalIncomeKD.attributedText = attributedStringEarn1
        
        attributedStringEarn2.append(attributedStringEarn3)
        self.lblUnpaidAmountKD.attributedText = attributedStringEarn2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        isExpanded = false
    }

    


}
