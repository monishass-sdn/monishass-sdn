//
//  FAQsTableViewCell.swift
//  AbyChaletApp
//
//  Created by Srishti on 29/12/21.
//

import UIKit

class FAQsTableViewCell: UITableViewCell {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblFaqQuestion: UILabel!
    @IBOutlet weak var textViewFaq: UITextView!
    @IBOutlet weak var topConstrainTextview: NSLayoutConstraint!
    @IBOutlet weak var bottomConstrainDownButton: NSLayoutConstraint!
    @IBOutlet weak var btnUPDOWN: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        textViewFaq.textAlignment = NSTextAlignment.justified
        viewBg.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setValuesToFields(index:Int,dictFaq:Faq_details,isClick:Bool,selectedIndex:Int) {
        self.btnUPDOWN.tag = index
        self.lblFaqQuestion.text = dictFaq.question
        self.textViewFaq.text = dictFaq.answer
        
        
        if selectedIndex == index{
            if isClick == false{
                lblFaqQuestion.numberOfLines = 1
            }else{
                lblFaqQuestion.numberOfLines = 0
            }
        }else{
            lblFaqQuestion.numberOfLines = 1
        }
        
        let lblHeight = heightForView(text: self.lblFaqQuestion.text!, font: UIFont(name: "Roboto-Medium", size: 15.0)!, width: kScreenWidth - 146)
        print("label Height = \(lblHeight)")
        if lblHeight < 30 {
            self.topConstrainTextview.constant = lblHeight + 30
        }else{
            self.topConstrainTextview.constant = lblHeight + 20
        }
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }

}
