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
    var isExpanded : Bool = false
    var istoggleON : Bool = false
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
    
    override func prepareForReuse() {
        isExpanded = false
    }

    


}
