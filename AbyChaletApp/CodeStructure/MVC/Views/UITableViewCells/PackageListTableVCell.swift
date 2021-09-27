//
//  PackageListTableVC.swift
//  AbyChaletApp
//
//  Created by TEJASWINI KADAM on 28/04/21.
//

import UIKit

class PackageListTableVCell: UITableViewCell {

    @IBOutlet weak var lblPackageDays: UILabel!
    @IBOutlet weak var lblPackageType: UILabel!
    
    var packageListData: PackageBookingChartStruct! {
        didSet {
            lblPackageType.text = packageListData.type
            lblPackageDays.text = packageListData.days
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if kCurrentLanguageCode == "ar"{
            lblPackageType.font = UIFont(name: kFontAlmaraiRegular, size: 18)
            lblPackageDays.font = UIFont(name: kFontAlmaraiRegular, size: 15)
        }else{
            lblPackageType.font = UIFont(name: "Roboto-Medium", size: 18)
            lblPackageDays.font = UIFont(name: "Roboto-Medium", size: 15)

        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
