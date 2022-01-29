//
//  FAQsViewController.swift
//  AbyChaletApp
//
//  Created by Srishti on 29/12/21.
//

import UIKit
import SVProgressHUD
import Alamofire

struct cellData{
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class FAQsViewController: UIViewController {
    @IBOutlet weak var FAQsTableView: UITableView!
    @IBOutlet weak var heightForTableView : NSLayoutConstraint!
    @IBOutlet weak var vieww: UIView!
    
    var selectedIndex = -1
    var isClickDown = false
    var faqData = [Faq_details]()
    var openedSectionDict = [Int:Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  vieww.roundCorners(corners: [.topLeft, .topRight], radius: 0.0)
       // vieww.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 0.0)


        // Do any additional setup after loading the view.
        setupForCustomNavigationTitle()
        self.setUpNavigationBar()
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
        
        getFAQData()
       // FAQsTableView.rowHeight = UITableView.automaticDimension
       // FAQsTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    

    

    
    //MARK:- SetUp NavigationBar
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
        let notificationButton = UIBarButtonItem(image: Images.kIconNotification, style: .plain, target: self, action: #selector(notificationButtonTouched))
        //self.navigationItem.rightBarButtonItems = [notificationButton]
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    
    @objc func didMoveToNotification(){
        
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
    
    @objc func backButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func notificationButtonTouched()  {
        
        
    }
    
    func setupForCustomNavigationTitle(){

        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "FAQ", attributes:[
                                                    NSAttributedString.Key.foregroundColor: UIColor.white,
                                                    NSAttributedString.Key.font: UIFont(name: "Roboto-BoldItalic", size: 25)! ])

        navTitle.append(NSMutableAttributedString(string: "s", attributes:[
                                                    NSAttributedString.Key.font: UIFont(name: "Roboto-BoldItalic", size: 25)! ,
                                                    NSAttributedString.Key.foregroundColor: UIColor.green]))

        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
    }
    
    func isHtml(_ value:String) -> Bool {
        let validateTest = NSPredicate(format:"SELF MATCHES %@", "<(\"[^\"]*\"|'[^']*'|[^'\">])*>")
        return validateTest.evaluate(with: value)
    }
    
    
    func isValidHtmlString(_ value: String) -> Bool {
        if value.isEmpty {
            return false
        }
        return (value.range(of: "<(\"[^\"]*\"|'[^']*'|[^'\">])*>", options: .regularExpression) != nil)
    }
    

}


extension FAQsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return faqData.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if faqData.count == section{
            return 0
        }
        if openedSectionDict[section] == true{
            return 1
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQsTableViewCell") as! FAQsTableViewCell
        if ((indexPath.section % 2) == 0){
            cell.viewBg.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else{
            cell.viewBg.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        }
        let stringValue = faqData[indexPath.section].answer!
        if isValidHtmlString(stringValue) == true{
      //  if stringValue.contains(htmlStr){
            cell.textViewFaq.attributedText = faqData[indexPath.section].answer?.html2AttributedString
        }else{
            cell.textViewFaq.text = faqData[indexPath.section].answer
       }
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == faqData.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "roundedBottomCell")
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionheader") as! FAQsTableViewCell
        cell.lblFaqQuestion.text = faqData[section].question
        cell.btnUPDOWN.tag = section
        cell.btnUPDOWN.addTarget(self, action: #selector(updownAction(_:)), for: .touchUpInside)
        if openedSectionDict[section] == true{
            cell.arrowButton.setImage(#imageLiteral(resourceName: "arrow-Up"), for: .normal)
        }else{
            cell.arrowButton.setImage(#imageLiteral(resourceName: "arrow-Down"), for: .normal)
        }
        if section % 2 == 0{
            cell.viewBg.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else{
            cell.viewBg.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == faqData.count{
            return 15
        }
        let QuestionString = faqData[section].question
        let lblHeight = heightForView(text: QuestionString!, font: UIFont(name: "Roboto-Medium", size: 18.0)!, width: kScreenWidth - 90)
        return lblHeight + 30
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func updownAction(_ sender: UIButton) {
        if openedSectionDict[sender.tag] == true{
            openedSectionDict[sender.tag] = false
        }else{
            openedSectionDict[sender.tag] = true
        }
        FAQsTableView.reloadData()
     
        
    }
    
    
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    
    
}

extension FAQsViewController{
    //MARK:- GetFAQData
    func getFAQData() {
       //["userid":CAUser.currentUser.id!]
        SVProgressHUD.show()
        ServiceManager.sharedInstance.postMethodAlamofire("api/view_faq", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : ""], withHud: true) { (success, response, error) in

            if success{
                print(response)
                if let responseDic = response as? NSDictionary{
                    let status = responseDic["status"] as! Bool
                    if status{
                        let responseBase = FAQModel(dictionary: responseDic)
                        self.faqData = (responseBase?.faq_details)!
                        for (i,_) in self.faqData.enumerated(){
                            self.openedSectionDict[i] = false
                        }
                        self.checkNotificationCount()
                        DispatchQueue.main.async {
                            self.FAQsTableView.reloadData()
                            
                        }
                    }else{
                        showDefaultAlert(viewController: self, title: "Message", msg: "Error")
                       // showDefaultAlert(viewController: self, title: "Message", msg: responseDic["message"] as! String)
                    }
                }
            }else{
                showDefaultAlert(viewController: self, title: "", msg: "Failed..!")
            }
        }
    }
    
    //MARK:- check notification count
    func checkNotificationCount() {
        if CAUser.currentUser.id != nil {
            ServiceManager.sharedInstance.postMethodAlamofire("api/notification_count", dictionary: ["userid": CAUser.currentUser.id!], withHud: true) { (success, response, error) in
                if success {
                    let messageCount = ((response as! NSDictionary)["message_count"] as! Int)
                    kNotificationCount = messageCount
                    let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
                    self.navigationItem.rightBarButtonItems = [notificationButton]
                }
            }
        }
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
