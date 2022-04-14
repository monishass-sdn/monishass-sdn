//
//  SearchChaletsWithNoResultsVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 07/04/22.
//

import UIKit
import SVProgressHUD

class SearchChaletsWithNoResultsVC: UIViewController {
    
    @IBOutlet weak var lblFromDate : UILabel!
    @IBOutlet weak var lblToDate : UILabel!
    @IBOutlet weak var lblPackage : UILabel!
    @IBOutlet weak var Btn_SwipeUp : UIButton!
    @IBOutlet weak var noresultCollectionView : UICollectionView!

    var fromdate = ""
    var todate = ""
    var selectedPackageName = ""
    var arraynoresultsChalets = [User_details]()

    override func viewDidLoad() {
        print("from date = \(fromdate)")
        print("to date = \(todate)")
        print("selectedPackageName = \(selectedPackageName)")

        super.viewDidLoad()
        setUpNavigationBar()
        setupTopView()
        getChaletsWhenNoResults()
        Btn_SwipeUp.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Available Chalet".localized()
        self.navigationController?.navigationBar.barTintColor = kAppThemeColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func setupTopView(){
        self.lblFromDate.text = fromdate
        self.lblToDate.text = todate
        let attrsWhatKindOfJob1 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 13)!, NSAttributedString.Key.foregroundColor : UIColor("#FFFFFF")] as [NSAttributedString.Key : Any]
        let attrsWhatKindOfJob2 = [NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 13)!, NSAttributedString.Key.foregroundColor : UIColor("#49FF00")] as [NSAttributedString.Key : Any]
        
        let attributedStringEarn1 = NSMutableAttributedString(string:"There is no chalet Available for this date \n Don't worry we have other ( ".localized(), attributes:attrsWhatKindOfJob1)
        let attributedStringEarn2 = NSMutableAttributedString(string:"\(self.selectedPackageName)", attributes:attrsWhatKindOfJob2)
        let attributedStringEarn3 = NSMutableAttributedString(string:" ) for you", attributes:attrsWhatKindOfJob1)
        
        attributedStringEarn1.append(attributedStringEarn2)
        attributedStringEarn1.append(attributedStringEarn3)
        self.lblPackage.attributedText = attributedStringEarn1
    }
    
    @IBAction func Action_SwipeUp(_ sender: UIButton){
        // go to top
        self.noresultCollectionView?.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath,at: .top,animated: true)
        self.Btn_SwipeUp.isHidden = true
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
extension SearchChaletsWithNoResultsVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arraynoresultsChalets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewChaletListCVCell", for: indexPath) as! CollectionViewChaletListCVCell
        if self.arraynoresultsChalets.count > 0 {
            cell.setValuesToFields(dict: self.arraynoresultsChalets[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.arraynoresultsChalets.count > 0 {
                if self.arraynoresultsChalets[indexPath.row].subchalet_available == true{
                    if self.arraynoresultsChalets[indexPath.row].reservation_status == true{
                        let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "SubChaletsVC") as! SubChaletsVC
                        nextVC.mainChaletName = self.arraynoresultsChalets[indexPath.row].chalet_name!
                        nextVC.mainChaletID = "\(self.arraynoresultsChalets[indexPath.row].chalet_id!)"
                        nextVC.fromDate = self.fromdate
                        nextVC.toDate = self.todate
                        nextVC.selectedPackagee = self.selectedPackageName
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }else{
                        //Reservation Not Available
                        let reservationAvailable = self.arraynoresultsChalets[indexPath.row].reservation_available
                        let alert = UIAlertController(title: "Message", message: "You Can't book after \(reservationAvailable ?? 0) days from Today", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }else{
                    if self.arraynoresultsChalets[indexPath.row].reservation_status == true{
                         //Reservation Available
                     let reservationVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ReservationTVC") as! ReservationTVC
                     reservationVC.arrayUserDetails = self.arraynoresultsChalets
                     reservationVC.selectedIndex = indexPath.item
                     reservationVC.selectedPackage = self.selectedPackageName
                     reservationVC.isFromOffer = false
                     reservationVC.isOfferAvailable = self.arraynoresultsChalets[indexPath.row].offer_available ?? false
                     reservationVC.arrayUserData = self.arraynoresultsChalets[indexPath.row]
                     reservationVC.requestTimeleft = self.arraynoresultsChalets[indexPath.row].request_time ?? 0
                     self.navigationController?.pushViewController(reservationVC, animated: true)
                     }else{
                         //Reservation Not Available
                         let reservationAvailable = self.arraynoresultsChalets[indexPath.row].reservation_available
                         let alert = UIAlertController(title: "Message", message: "You Can't book after \(reservationAvailable ?? 0) days from Today", preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                         }))
                         self.present(alert, animated: true, completion: nil)
                     }
                }

           // }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in noresultCollectionView.visibleCells {
            let indexPath = noresultCollectionView.indexPath(for: cell)
            //print("visible cell indexpath = \(indexPath)")
            if indexPath == [0,0]{
            }else if indexPath == [0,1]{
                self.Btn_SwipeUp.isHidden = true
            }else if indexPath == [0,2]{
                self.Btn_SwipeUp.isHidden = true
            }else  if indexPath == [0,3]{
                self.Btn_SwipeUp.isHidden = true
            }else if indexPath == [0,4]{
                self.Btn_SwipeUp.isHidden = true
            }else{
                self.Btn_SwipeUp.isHidden = false // Show Swipe-Up Button
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if arraynoresultsChalets.count > 0{
            if arraynoresultsChalets[indexPath.row].offer_available == false{
                if arraynoresultsChalets[indexPath.row].isFromHolidaysandEvents == false{
                    return CGSize(width: kScreenWidth, height: 176)
                }
            }
        }
        return CGSize(width: kScreenWidth , height: 215)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
}

extension SearchChaletsWithNoResultsVC {
    //MARK:- Get Chalets When there is no search Results
    func getChaletsWhenNoResults() {
        SVProgressHUD.show()
        self.view.isUserInteractionEnabled = false
        ServiceManager.sharedInstance.postMethodAlamofire("api/available_chalet", dictionary: ["from_date":fromdate,"to_date":todate,"package":selectedPackageName], withHud: true) { (success, response, error) in
            if success {
                print("response is \(response as! NSDictionary)")
                
                if response!["status"] as! Bool == true {
                    let responseBase = ChaletSearchBase(dictionary: response as! NSDictionary)
                    self.arraynoresultsChalets = (responseBase?.user_details)!
                    self.noresultCollectionView.reloadData()
                    if self.arraynoresultsChalets.count > 0 {
                        DispatchQueue.main.async {
                            self.view.isUserInteractionEnabled = true
                        }
                    }else{
                        // do nothing
                    }

                }else{
                    showDefaultAlert(viewController: self, title: "", msg: "No Chalets Found")
                    self.view.isUserInteractionEnabled = true
                }
            }else{
                showDefaultAlert(viewController: self, title: "", msg: "Failed..!")
                self.view.isUserInteractionEnabled = true
            }
        }
    }
}
