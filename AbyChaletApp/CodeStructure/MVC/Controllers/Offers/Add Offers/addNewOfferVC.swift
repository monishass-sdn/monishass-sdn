//
//  addNewOfferVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 03/01/22.
//

import UIKit

class addNewOfferVC: UIViewController {
    
    @IBOutlet weak var BtnaddNewOffer: UIButton!
    @IBOutlet weak var addOfferTableView: UITableView!
    @IBOutlet weak var lblthereisnoOffer: UILabel!
    
    var testDataCheckin = ["24/01/2022","25/01/2022","26/01/2022","27/01/2022"]
    var testDataCheckout = ["28/01/2022","29/01/2022","30/01/2022","31/01/2022"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigationBar()
        self.addOfferTableView.isHidden = true
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
    }

    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Add Offers".localized()

        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
        let notificationButton = UIBarButtonItem(image: Images.kIconNotification, style: .plain, target: self, action: #selector(notificationButtonTouched))
        //self.navigationItem.rightBarButtonItems = [notificationButton]
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    @objc func backButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func notificationButtonTouched()  {
        
        
    }
    
    @objc func didMoveToNotification(){
        
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
    
    //MARK:- Button Actions
    
    @IBAction func addnewOffer_Tapped(_ sender: UIButton) {
        self.addOfferTableView.isHidden = false
        self.BtnaddNewOffer.isHidden = true
        self.lblthereisnoOffer.isHidden = true
    }


}

extension addNewOfferVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return testDataCheckin.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableOffersTVCell", for: indexPath) as! AvailableOffersTVCell
            cell.lblCheck_in.text = testDataCheckin[indexPath.row]
            cell.lblCheck_out.text = testDataCheckout[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNewOfferTVCell", for: indexPath) as! addNewOfferTVCell
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 165
        }else{
            return 165
        }
    }
    
    
}
