//
//  NotificationVC.swift
//  AbyChaletApp
//
//  Created by Visakh Srishti on 30/05/21.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var btnMessages: UIButton!
    @IBOutlet weak var btnInbox: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var btnMessageWidth: NSLayoutConstraint!
    var showResrvationButton: Bool = false
    var isFromProfile = false
    override func viewDidLoad() {
        super.viewDidLoad()
        checkuserstatus()
        self.setUpNavigationBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(logoutUser), name: NSNotification.Name(rawValue: NotificationNames.kBlockedUser), object: nil)
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.KNoNotification : Images.KNewNotification, style: .plain, target: self, action: nil)
        let reservationButton = UIBarButtonItem(image: showResrvationButton == true ? Images.KReservationicon?.withTintColor(UIColor.white) : Images.KHideReservationicon, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItems = [notificationButton,reservationButton]
        
        btnInbox.setTitle("Inbox".localized(), for: .normal)
        btnMessages.setTitle("Messages".localized(), for: .normal)
    }
    
    @objc func logoutUser() {
        appDelegate.logOut()
    }
    override func viewWillAppear(_ animated: Bool) {
        if self.isFromProfile == true{
            self.didSetInboxVC()
        }else{
            self.didSetMessageVC()
        }
        appDelegate.checkBlockStatus()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Check User/Owner Status
    
    func checkuserstatus(){
        if CAUser.currentUser.userstatus == "user"{
            showResrvationButton = false
            btnMessageWidth.constant = view.frame.width
        }else{
            showResrvationButton = true
        }
    }
    
    //MARK:- SetUp NavigationBar
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false

        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
       // let notificationButton = UIBarButtonItem(image: Images.kIconNotification, style: .plain, target: self, action: #selector(notificationButtonTouched))
        //self.navigationItem.rightBarButtonItems = [notificationButton]
        self.navigationItem.title = "Notifications".localized()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        
    }
    //MARK:- ButtonActions
    //MARK:- Done button action keyboard
    @objc func doneButtonClicked() {
        self.view.endEditing(true)
    }
    @objc func notificationButtonTouched()  {
        
        
    }
    @objc func backButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSwitchActions(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            self.didSetInboxVC()
        case 1:
            self.didSetMessageVC()
        default:
            self.didSetInboxVC()

        }
    }

    //MARK:- Remove Child ViewControllers
    func removeChildVC() {
        if self.children.count > 0{
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
    }
    //MARK:- SetInboxVC
    func didSetInboxVC()
    {
        self.removeChildVC()
        let inboxVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "InboxVC") as! InboxVC
        self.addChild(inboxVC)
        inboxVC.view.frame = viewContainer.bounds
        viewContainer.addSubview(inboxVC.view)
        inboxVC.didMove(toParent: self)
        if kCurrentLanguageCode == "ar"{
            btnInbox.titleLabel?.font = UIFont(name: kFontAlmaraiBold, size: 16)
            btnMessages.titleLabel?.font = UIFont(name: kFontAlmaraiRegular, size: 16)
        }else{
            btnInbox.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16.0)
            btnMessages.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16.0)
        }

        btnInbox.isSelected = true
        btnMessages.isSelected = false
    }
    //MARK:- SetMessagesVC
    func didSetMessageVC()
    {
        self.removeChildVC()
        let messagesVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "MessagesVC") as! MessagesVC
        self.addChild(messagesVC)
        messagesVC.view.frame = viewContainer.bounds
        viewContainer.addSubview(messagesVC.view)
        messagesVC.didMove(toParent: self)
        if kCurrentLanguageCode == "ar"{
            btnInbox.titleLabel?.font = UIFont(name: kFontAlmaraiRegular, size: 16)
            btnMessages.titleLabel?.font = UIFont(name: kFontAlmaraiBold, size: 16)
        }else{
            btnInbox.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 16.0)
            btnMessages.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 16.0)
        }

        btnInbox.isSelected = false
        btnMessages.isSelected = true
    }

    func checkNotificationCount() {
        if CAUser.currentUser.id != nil {
            ServiceManager.sharedInstance.postMethodAlamofire("api/notification_count", dictionary: ["userid": CAUser.currentUser.id!], withHud: true) { (success, response, error) in
                if success {
                    let messageCount = ((response as! NSDictionary)["message_count"] as! Int)
                    kNotificationCount = messageCount
                    let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action:nil)
                    self.navigationItem.rightBarButtonItems = [notificationButton]
                }
            }
        }
    }
    
}
