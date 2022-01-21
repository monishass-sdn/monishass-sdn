//
//  AvailableOffersTVCell.swift
//  AbyChaletApp
//
//  Created by Srishti on 05/01/22.
//

import UIKit

class AvailableOffersTVCell: UITableViewCell {
    @IBOutlet weak var lblCheck_in: UILabel!
    @IBOutlet weak var lblCheck_out: UILabel!
    @IBOutlet weak var mainView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
