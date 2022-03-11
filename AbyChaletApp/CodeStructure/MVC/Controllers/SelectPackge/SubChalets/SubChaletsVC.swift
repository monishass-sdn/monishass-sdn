//
//  SubChaletsVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 10/03/22.
//

import UIKit
import SVProgressHUD

class SubChaletsVC: UIViewController {
    
    @IBOutlet weak var subChaletCV : UICollectionView!
    
    var mainChaletName = ""
    var mainChaletID = ""
    var fromDate = ""
    var toDate = ""
    var selectedPackagee = ""
    var arraySubChalets = [User_details]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("fromdate = \(fromDate)")
        print("toDate = \(toDate)")
        print("selectedPackage = \(selectedPackagee)")

        setUpNavigationBar()
        getSubchalets()
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "\(mainChaletName)"
        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        let backBarButton = UIBarButtonItem(image: Images.kIconBackGreen, style: .plain, target: self, action: #selector(backButtonTouched))
        self.navigationItem.leftBarButtonItems = [backBarButton]
        let notificationButton = UIBarButtonItem(image: kNotificationCount == 0 ? Images.kIconNoMessage : Images.kIconNotification, style: .plain, target: self, action: #selector(self.didMoveToNotification))
        self.navigationItem.rightBarButtonItems = [notificationButton]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

    }
    @objc func backButtonTouched()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didMoveToNotification(){
        
        let changePasswordTVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(changePasswordTVC, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SubChaletsVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arraySubChalets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewChaletListFromGroupSubChaletCVCell", for: indexPath) as! CollectionViewChaletListFromGroupSubChaletCVCell
        cell.setValuesToFields(dict: self.arraySubChalets[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if arraySubChalets[indexPath.row].offer_available == false{
            if arraySubChalets[indexPath.row].isFromHolidaysandEvents == false{
                return CGSize(width: kScreenWidth, height: 176)
            }else{
                return CGSize(width: kScreenWidth, height: 215)
            }
        }else{
            return CGSize(width: kScreenWidth , height: 215)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.arraySubChalets[indexPath.row].reservation_status == true{
         let reservationVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ReservationTVC") as! ReservationTVC
         reservationVC.arrayUserDetails = self.arraySubChalets
         reservationVC.selectedIndex = indexPath.item
            reservationVC.selectedPackage = self.selectedPackagee
         reservationVC.isFromOffer = false
         reservationVC.isOfferAvailable = self.arraySubChalets[indexPath.row].offer_available ?? false
         reservationVC.arrayUserData = self.arraySubChalets[indexPath.row]
            reservationVC.isFromSubChalets = true
            reservationVC.groupChaletName = self.mainChaletName
         self.navigationController?.pushViewController(reservationVC, animated: true)
         }else{
             let reservationAvailable = self.arraySubChalets[indexPath.row].reservation_available
             let alert = UIAlertController(title: "Message", message: "You Can't book after \(reservationAvailable ?? 0) days from Today", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
             }))
             self.present(alert, animated: true, completion: nil)
         }
    }
   
    
}

extension SubChaletsVC{
    func getSubchalets() {
        SVProgressHUD.show()
      //  self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/available-sub-chalets", dictionary: ["userid":CAUser.currentUser.id != nil ? CAUser.currentUser.id! : 0,"mainchaletId":mainChaletID,"from_date":fromDate,"to_date":toDate,"package":selectedPackagee], withHud: true) { (success, response, error) in
            if success {
                print("response is \(response as! NSDictionary)")

                if response!["status"] as! Bool == true {
                    let responseBase = SubChalet_Base(dictionary: response as! NSDictionary)
                    self.arraySubChalets = (responseBase?.user_details)!
                    DispatchQueue.main.async {
                        self.subChaletCV.reloadData()
                    //    self.view.isUserInteractionEnabled = true
                    }
                }else{
                    showDefaultAlert(viewController: self, title: "", msg: "No Holidays and Events")
                  //  self.view.isUserInteractionEnabled = true
                }
            }else{
                showDefaultAlert(viewController: self, title: "", msg: "Failed..!")
               // self.view.isUserInteractionEnabled = true
            }
        }
    }
}
