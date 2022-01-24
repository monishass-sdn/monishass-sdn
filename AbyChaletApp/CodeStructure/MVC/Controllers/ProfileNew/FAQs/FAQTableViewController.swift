//
//  FAQTableViewController.swift
//  AbyChaletApp
//
//  Created by Srishti on 24/01/22.
//

import UIKit
import SVProgressHUD

class FAQTableViewController: UITableViewController {
    
    var faqData = [Faq_details]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setupForCustomNavigationTitle()
        getFAQData()
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]

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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        print("Count = \(faqData.count)")
        return faqData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqData[section].answer!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FAQsTableViewCell", for: indexPath) as? FAQsTableViewCell
            cell?.lblFaqQuestion.text = faqData[indexPath.row].question!
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FAQsTableViewCell", for: indexPath) as? FAQsTableViewCell
            cell?.lblAnswer.text = faqData[indexPath.section].answer?.first?.answer
            return cell!
        }
    }



}


extension FAQTableViewController{
    //MARK:- GetFAQData
    func getFAQData() {
        SVProgressHUD.show()
        ServiceManager.sharedInstance.postMethodAlamofire("api/view_faq", dictionary: ["userid":CAUser.currentUser.id != nil ? "\(CAUser.currentUser.id!)" : ""], withHud: true) { (success, response, error) in

            if success{
                print(response)
                if let responseDic = response as? NSDictionary{
                    let status = responseDic["status"] as! Bool
                    if status{
                        let responseBase = FAQModelData(dictionary: responseDic)
                        print(responseBase)
                        self.faqData = (responseBase?.faq_details)!
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
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
