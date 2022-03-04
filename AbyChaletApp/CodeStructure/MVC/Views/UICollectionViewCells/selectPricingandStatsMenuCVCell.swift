//
//  selectPricingandStatsMenuCVCell.swift
//  AbyChaletApp
//
//  Created by Srishti on 04/03/22.
//

import UIKit

class selectPricingandStatsMenuCVCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgViewBg: UIImageView!
    override var isSelected: Bool {
        didSet {
                isSelected ? setGradientColorForPackageSelectedCell(view: self) : setGradientColorForPackageUnselectedCell(view: self)
                }
        }
    
    override func awakeFromNib() {
    }
}
