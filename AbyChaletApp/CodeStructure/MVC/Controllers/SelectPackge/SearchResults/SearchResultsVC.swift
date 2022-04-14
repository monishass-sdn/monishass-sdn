//
//  SearchResultsVC.swift
//  AbyChaletApp
//
//  Created by Srishti on 07/04/22.
//

import UIKit

class SearchResultsVC: UIViewController {
    
    @IBOutlet weak var searchResultCV : UICollectionView!
    @IBOutlet weak var Btn_SwipeUp : UIButton!

    var arrayChaletDetails = [User_details]()
    var fromdate = ""
    var todate = ""
    var selectedPackageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForCustomNavigationTitle()
        self.searchResultCV.reloadData()
        self.view.isUserInteractionEnabled = true
        Btn_SwipeUp.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    func setupForCustomNavigationTitle(){

        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "Aby", attributes:[
                                                    NSAttributedString.Key.foregroundColor: UIColor.green,
                                                    NSAttributedString.Key.font: UIFont(name: "Roboto-BoldItalic", size: 25)! ])

        navTitle.append(NSMutableAttributedString(string: " Chalet", attributes:[
                                                    NSAttributedString.Key.font: UIFont(name: "Roboto-BoldItalic", size: 25)! ,
                                                    NSAttributedString.Key.foregroundColor: UIColor.white]))

        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func Action_SwipeUp(_ sender: UIButton){
        // go to top
        self.searchResultCV?.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath,at: .top,animated: true)
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

extension SearchResultsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayChaletDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewChaletListCVCell", for: indexPath) as! CollectionViewChaletListCVCell
        if self.arrayChaletDetails.count > 0 {
            cell.setValuesToFields(dict: self.arrayChaletDetails[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.arrayChaletDetails.count > 0 {
                if self.arrayChaletDetails[indexPath.row].subchalet_available == true{
                    if self.arrayChaletDetails[indexPath.row].reservation_status == true{
                        let nextVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "SubChaletsVC") as! SubChaletsVC
                        nextVC.mainChaletName = self.arrayChaletDetails[indexPath.row].chalet_name!
                        nextVC.mainChaletID = "\(self.arrayChaletDetails[indexPath.row].chalet_id!)"
                        nextVC.fromDate = self.fromdate
                        nextVC.toDate = self.todate
                        nextVC.selectedPackagee = self.selectedPackageName
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }else{
                        //Reservation Not Available
                        let reservationAvailable = self.arrayChaletDetails[indexPath.row].reservation_available
                        let alert = UIAlertController(title: "Message", message: "You Can't book after \(reservationAvailable ?? 0) days from Today", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }else{
                    if self.arrayChaletDetails[indexPath.row].reservation_status == true{
                         //Reservation Available
                     let reservationVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ReservationTVC") as! ReservationTVC
                     reservationVC.arrayUserDetails = self.arrayChaletDetails
                     reservationVC.selectedIndex = indexPath.item
                     reservationVC.selectedPackage = self.selectedPackageName
                     reservationVC.isFromOffer = false
                     reservationVC.isOfferAvailable = self.arrayChaletDetails[indexPath.row].offer_available ?? false
                     reservationVC.arrayUserData = self.arrayChaletDetails[indexPath.row]
                     reservationVC.requestTimeleft = self.arrayChaletDetails[indexPath.row].request_time ?? 0
                     self.navigationController?.pushViewController(reservationVC, animated: true)
                     }else{
                         //Reservation Not Available
                         let reservationAvailable = self.arrayChaletDetails[indexPath.row].reservation_available
                         let alert = UIAlertController(title: "Message", message: "You Can't book after \(reservationAvailable ?? 0) days from Today", preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                         }))
                         self.present(alert, animated: true, completion: nil)
                     }
                }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if arrayChaletDetails.count > 0{
            if arrayChaletDetails[indexPath.row].offer_available == false{
                if arrayChaletDetails[indexPath.row].isFromHolidaysandEvents == false{
                    return CGSize(width: kScreenWidth, height: 176)
                }
            }
        }
        return CGSize(width: kScreenWidth , height: 215)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in searchResultCV.visibleCells {
            let indexPath = searchResultCV.indexPath(for: cell)
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
    
}
