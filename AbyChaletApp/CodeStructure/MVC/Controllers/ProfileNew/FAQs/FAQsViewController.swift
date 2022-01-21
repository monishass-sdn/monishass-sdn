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
    @IBOutlet weak var vieww: UIView!
    
    var selectedIndex = -1
    var isClickDown = false
    var faqData = [Faq_details]()
    override func viewDidLoad() {
        super.viewDidLoad()
        vieww.roundCorners(corners: [.topLeft, .topRight], radius: 0.0)
        vieww.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 0.0)


        // Do any additional setup after loading the view.
        setupForCustomNavigationTitle()
        self.setUpNavigationBar()
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
        
        getFAQData()
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
    
    
    @IBAction func btnDownAndUpAction(_ sender: UIButton) {
        if sender.tag != self.selectedIndex{
            self.selectedIndex = sender.tag
            self.isClickDown = true
        }else{
            self.selectedIndex = -1
            self.isClickDown = false
        }
        self.FAQsTableView.reloadData()
        self.FAQsTableView.beginUpdates()
        self.FAQsTableView.endUpdates()
        
    }

}


extension FAQsViewController: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQsTableViewCell") as! FAQsTableViewCell
        cell.btnUPDOWN.tag = indexPath.row
        cell.btnUPDOWN.addTarget(self, action: #selector(updownAction(_:)), for: .touchUpInside)
        if self.selectedIndex == indexPath.row {
            cell.btnUPDOWN.setImage(#imageLiteral(resourceName: "arrow-Up"), for: .normal)
        }else{
            cell.btnUPDOWN.setImage(#imageLiteral(resourceName: "arrow-Down"), for: .normal)
        }
        cell.lblFaqQuestion.text = faqData[indexPath.row].question
        cell.textViewFaq.text = faqData[indexPath.row].answer

        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.isClickDown == false{
            return 60
        }else{
            if selectedIndex == indexPath.row{
                return UITableView.automaticDimension
            }else{
                return 60
            }
            
        }
    }
    
    @objc func updownAction(_ sender: UIButton) {
        if sender.tag != self.selectedIndex{
            self.selectedIndex = sender.tag
            self.isClickDown = true
        }else{
            self.selectedIndex = -1
            self.isClickDown = false
        }
        self.FAQsTableView.reloadData()
        self.FAQsTableView.beginUpdates()
        self.FAQsTableView.endUpdates()
        
    }
    
    
}

extension FAQsViewController{
    //MARK:- GetMyBookingData
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
                        DispatchQueue.main.async {
                            self.FAQsTableView.reloadData()
                        }
                    }else{
                        showDefaultAlert(viewController: self, title: "Message", msg: responseDic["message"] as! String)
                    }
                }
            }else{
                showDefaultAlert(viewController: self, title: "", msg: "Failed..!")
            }
        }
    }
}
