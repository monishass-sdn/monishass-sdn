//
//  HolidayEventListTVCell.swift
//  AbyChaletApp
//
//  Created by Srishti on 07/03/22.
//

import UIKit

class HolidayEventListTVCell: UITableViewCell {
    @IBOutlet weak var lblcheck_in : UILabel!
    @IBOutlet weak var lblcheck_out: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblEvent_name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setValuesToFields(dict : Holi_event_list){
        self.lblcheck_in.text = dict.check_in
        self.lblcheck_out.text = dict.check_out
        self.lblEvent_name.text = dict.event_name
        if dict.no_ChaletEvent != "0"{
            self.lblCount.isHidden = false
            self.lblCount.text = dict.no_ChaletEvent
        }else{
            self.lblCount.isHidden = true
        }
    }

}
