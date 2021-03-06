//
//  TermsAndConditionVC.swift
//  AbyChaletApp
//
//  Created by Visakh Srishti on 02/06/21.
//

import UIKit
import WebKit
import SVProgressHUD

class TermsAndConditionVC: UIViewController,WKUIDelegate,WKNavigationDelegate {
    
    @IBOutlet var webView: WKWebView!
    var UrlString = ""
    var isFromReservation = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpNavigationBar()
       // let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        let closeButton = UIBarButtonItem(image: Images.KcloseButton, style: .plain, target: self, action: #selector(self.closeButtonTouched))
        self.navigationItem.rightBarButtonItems = [closeButton]
        self.navigationItem.title = "Legal - Privacy & Terms"
        if isFromReservation == false{
            SVProgressHUD.show()
            webView.navigationDelegate = self
            webView.uiDelegate = self
            let request = URLRequest(url: URL(string: UrlString)!)
            webView.load(request)
        }else{
            let htmlString:String! = "\(UrlString)"
            webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(logoutUser), name: NSNotification.Name(rawValue: NotificationNames.kBlockedUser), object: nil)
    }
    @objc func logoutUser() {
        appDelegate.logOut()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appDelegate.checkBlockStatus()
    }
    
    
    //MARK:- SetUp NavigationBar
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let closeButton = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeButtonTouched))
        closeButton.tintColor = .white
        self.navigationItem.rightBarButtonItems = [closeButton]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    
    
    @objc func closeButtonTouched()  {
        self.dismiss(animated: true, completion: nil)
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
