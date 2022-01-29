//
//  AddNewChaletVC.swift
//  AbyChaletApp
//
//  Created by Visakh Srishti on 07/06/21.
//

import UIKit
import WebKit
import SVProgressHUD

class AddNewChaletVC: UIViewController,WKUIDelegate,WKNavigationDelegate {

    
    @IBOutlet var webView: WKWebView!
    var UrlString = "https://sicsapp.com/Aby_chalet/adminmail"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForCustomNavigationTitle()
        self.setUpNavigationBar()
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
    //    self.navigationItem.title = "Add your Chalet"
        SVProgressHUD.show()
        webView.navigationDelegate = self
        webView.uiDelegate = self
        let request = URLRequest(url: URL(string: UrlString)!)
        webView.load(request)
        
        NotificationCenter.default.addObserver(self, selector: #selector(logoutUser), name: NSNotification.Name(rawValue: NotificationNames.kBlockedUser), object: nil)
    //    self.navigationController?.navigationBar.titleTextAttributes = [
         //   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
      //  ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appDelegate.checkBlockStatus()
        
    }
    
    
    @objc func logoutUser() {
        appDelegate.logOut()
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
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    
    func setupForCustomNavigationTitle(){

        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "Add Your Chalet", attributes:[
                                                    NSAttributedString.Key.foregroundColor: UIColor.white,
                                                    NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 22)! ])
        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
    }
    
    //MARK:- ButtonActions
    //MARK:- Done button action keyboard
    @objc func doneButtonClicked() {
        self.view.endEditing(true)
    }
    @objc func backButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func notificationButtonTouched()  {
        
        
    }
    

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
        SVProgressHUD.dismiss()
    }
    
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

    @objc func didMoveToNotification(){
        
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
}
